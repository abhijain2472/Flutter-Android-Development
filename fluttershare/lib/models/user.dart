import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String username;
  final String displayName;
  final String email;
  final String photoUrl;
  final String bio;

  User({
    this.id,
    this.username,
    this.displayName,
    this.email,
    this.photoUrl,
    this.bio,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc['id'],
      bio: doc['bio'],
      displayName: doc['displayName'],
      email: doc['email'],
      photoUrl: doc['photoUrl'],
      username: doc['username'],
    );
  }
}
