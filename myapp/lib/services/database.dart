import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/brews.dart';
import 'package:myapp/models/users.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference appCollection =
      Firestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await appCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }


  // get brews stream
  Stream<List<Brew>> get brews {
    return appCollection.snapshots().map((_brewListFromSnapshot));
  }


// get user doc stream
  Stream<UserData> get userData {
    return appCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }


  //brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
        name: doc.data['name'] ?? '',
        strength: doc.data['strength'] ?? 0,
        sugars: doc.data['sugars'] ?? '',
      );
    }).toList();
  }


  // user data from snapshots

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        sugars: snapshot.data['sugars'],
        strength: snapshot.data['strength']
    );
  }
}
