import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttershare/models/user.dart';
import 'package:fluttershare/pages/home.dart';
import 'package:fluttershare/widgets/progress.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';
import 'package:image/image.dart' as Im;

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class Upload extends StatefulWidget {
  final User currentUser;

  const Upload({this.currentUser});

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File _file;
  bool isUploading = false;
  bool showLoading = false;
  String postId = Uuid().v4();
  TextEditingController locationController = TextEditingController();
  TextEditingController captionController = TextEditingController();

  Future<void> _takePicture(ImageSource type) async {
    // ignore: deprecated_member_use
    final imageFile = await ImagePicker.pickImage(
        source: type, maxWidth: 675, maxHeight: 960);
    if (imageFile != null) {
      setState(() {
        _file = imageFile;
      });
    }
  }

  void showImagePickerOption(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: 80,
                margin: EdgeInsets.all(25),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.lightBlue,
                            radius: 25,
                            child: IconButton(
                                color: Colors.white,
                                icon: Icon(Icons.camera_alt),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  _takePicture(ImageSource.camera);
                                }),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Camera'),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.teal,
                            radius: 25,
                            child: IconButton(
                                color: Colors.white,
                                icon: Icon(Icons.image),
                                onPressed: () {
                                  Navigator.of(context).pop();

                                  _takePicture(ImageSource.gallery);
                                }),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Gallery'),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.redAccent,
                            radius: 25,
                            child: IconButton(
                                color: Colors.white,
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Cancel'),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        });
  }

  Container buildSplashScreen() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/upload.svg',
            height: 220,
          ),
          SizedBox(height: 20),
          RaisedButton.icon(
            color: Colors.white,
            icon: Icon(Icons.camera),
            label: Text('Upload Image'),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              showImagePickerOption(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(_file.readAsBytesSync());
    final compressedImageFile = File('$path/img_$postId.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
    setState(() {
      _file = compressedImageFile;
    });
  }

  Future<String> uploadImage(imageFile) async {
    StorageUploadTask uploadTask =
        storageReference.child('post_$postId.jpg').putFile(imageFile);

    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> createPostInFireStore({
    String mediaUrl,
    String location,
    String description,
  }) async {
    await postRef
        .document(widget.currentUser.id)
        .collection('userPosts')
        .document(postId)
        .setData({
      'postId': postId,
      'ownerId': widget.currentUser.id,
      'username': widget.currentUser.username,
      'mediaUrl': mediaUrl,
      'description': description,
      'location': location,
      'timestamp': timestamp,
      'likes': {},
    });
  }

  void clearAll() {
    setState(() {
      captionController.clear();
      locationController.clear();
      isUploading = false;
      _file = null;
      postId = Uuid().v4();
    });
  }

  void handleSubmit() async {
    FocusScope.of(context).unfocus();
    setState(() {
      isUploading = true;
    });
    await compressImage();
    String mediaUrl = await uploadImage(_file);
    await createPostInFireStore(
      mediaUrl: mediaUrl,
      location: locationController.text,
      description: captionController.text,
    );
    clearAll();
  }

  getUserLocation() async {
    setState(() {
      showLoading=true;
    });
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placeMarks = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placeMark = placeMarks[0];
    String formattedAddress = '${placeMark.locality}, ${placeMark.country}';
    locationController.text = formattedAddress;
    String completeAddress =
        '${placeMark.subThoroughfare} ${placeMark.thoroughfare}, ${placeMark.subLocality} ${placeMark.locality}, ${placeMark.subAdministrativeArea}, ${placeMark.administrativeArea} ${placeMark.postalCode}, ${placeMark.country}';
    print('Complete add is : $completeAddress');
    setState(() {
      showLoading=false;
    });
  }

  Scaffold buildUploadForm() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            clearAll();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Upload Post',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          FlatButton(
            onPressed: isUploading ? null : () => handleSubmit(),
            child: Text(
              'Post',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            ListView(
              children: [
                isUploading ? linearProgress() : Text(''),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 220.0,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(_file),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        CachedNetworkImageProvider(widget.currentUser.photoUrl),
                  ),
                  title: Container(
                    child: TextField(
                      controller: captionController,
                      decoration: InputDecoration(
                          hintText: 'Write a caption...',
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.pin_drop,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                  title: Container(
                    child: TextField(
                      controller: locationController,
                      decoration: InputDecoration(
                          hintText: 'Where was this photo taken ?',
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Container(
                  height: 100.0,
                  width: 200.0,
                  alignment: AlignmentDirectional.center,
                  child: RaisedButton.icon(
                    color: Colors.white,
                    icon: Icon(Icons.my_location),
                    label: Text('Use Current Location'),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: getUserLocation,
                  ),
                ),
              ],
            ),
            Center(child: showLoading ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
            ) : null),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _file == null ? buildSplashScreen() : buildUploadForm();
  }
}
