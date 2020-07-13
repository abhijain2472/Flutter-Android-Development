import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heroapp/next.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Next.routeName: (context) => Next(),
      },
      home: MyNewApp(),
    );
  }
}

class MyNewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'hero',

              child: Image(
                image: AssetImage('assets/newIcon.png'),
                height: 80,
                width: 80,
              ),
            ),
            SizedBox(
              height: 160,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Next.routeName);
              },
              child: Text('Next'),
            )
          ],
        ),
      ),
    );
  }
}
