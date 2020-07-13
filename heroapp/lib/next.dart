import 'package:flutter/material.dart';
class Next extends StatelessWidget {
  static const routeName ='/next-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hero test'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'hero',
              child: Image(
                image: AssetImage('assets/newIcon.png'),
                height: 200,
                width: 200,

              ),
            ),

          ],
        ),
      ),
    );
  }
}
