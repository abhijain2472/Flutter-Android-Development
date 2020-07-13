import 'package:flutter/material.dart';
import 'package:myapp/Screens/wrapper.dart';
import 'package:myapp/models/users.dart';
import 'package:myapp/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: Wrapper(),
      ),
    );
  }
}


