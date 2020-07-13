import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int counter = 0;

  void fun() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Second app'),
        backgroundColor: Colors.red[500],
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'you clicked button this time',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue,
                fontFamily: 'Sen',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '$counter',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
                fontFamily: 'Sen',
              ),
            ),
            IconButton(icon: Icon(Icons.phone),
              onPressed: () {},
            color: Colors.lightBlue,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fun,
        child: Icon(Icons.add),
      ),
    );
  }
}