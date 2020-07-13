import 'package:flutter/material.dart';
import 'package:fluttershare/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.pink
      ),
      title: 'FlutterInstGram',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
