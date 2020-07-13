import 'package:flutter/material.dart';
import 'package:myapp/Screens/authenticate/authenticate.dart';
import 'package:myapp/Screens/home/home.dart';
import 'package:myapp/models/users.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user==null){
      return Authenticate();
    }
    else{
      return Home();
    }
  }
}
