import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  const ImageInput(this.onSelectImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;


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
                                icon: Icon(Icons.camera_alt), onPressed: () {
                                Navigator.of(context).pop();
                                _takePicture(ImageSource.camera);
                            }),
                          ),
                          SizedBox(height: 10,),
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
                                icon: Icon(Icons.image), onPressed: () {
                              Navigator.of(context).pop();

                              _takePicture(ImageSource.gallery);
                            }),
                          ),
                          SizedBox(height: 10,),
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
                                icon: Icon(Icons.delete), onPressed: () {
                              Navigator.of(context).pop();

                              if(_storedImage!=null){
                                  setState(() {
                                    _storedImage=null;
                                  });
                                }
                            }),
                          ),
                          SizedBox(height: 10,),
                          Text('Delete'),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        });
  }

  Future<void> _takePicture(ImageSource type) async {
    final imageFile = await ImagePicker.pickImage(
      source: type,
      maxWidth: 600,
    );
    if (imageFile!=null) {
      setState(() {
        _storedImage = imageFile;
      });
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(imageFile.path);
      final savedImage = await imageFile.copy('${appDir.path}/$fileName');
      widget.onSelectImage(savedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              showImagePickerOption(context);
            },
          ),
        ),
      ],
    );
  }
}
