import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Abhi(),
    ));

class Abhi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[850],
        appBar: AppBar(
          title: Text('Abhishek ID Card'),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
          elevation: 0.0,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/img1.jpg'),
                  radius: 40,
                ),
              ),

              Divider(
                height: 60,
                color: Colors.grey[900],
              ),
              Text(
                'Name',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Abhishek Jain',
                style: TextStyle(
                  color: Colors.amber[300],
                  fontSize: 28,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),

              Text(
                'Current Ninja Level',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '7',
                style: TextStyle(
                  color: Colors.amber[300],
                  fontSize: 28,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),

              Row(
                children: <Widget>[
                  Icon(Icons.email,
                  color: Colors.grey[400],),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'abhishekjain2472@gmail.com',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                      letterSpacing: 2,

                    ),
                  ),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
