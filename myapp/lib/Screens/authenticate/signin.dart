import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/services/auth.dart';
import 'package:myapp/shared/constant.dart';
import 'package:myapp/shared/loading.dart';

class SignIn extends StatefulWidget {
  Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
                title: Text('Sign In to Myapp'),
                backgroundColor: Colors.brown[800],
                elevation: 0,
                actions: <Widget>[
                  FlatButton.icon(
                      textColor: Colors.white,
                      onPressed: () {
                        widget.toggleView();
                      },
                      icon: Icon(Icons.person),
                      label: Text('Register')),
                ]),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: kTextInputDecoration.copyWith(
                            hintText: 'Enter an Email'),
                        validator: (value) =>
                            value.isEmpty ? 'Enter an Email !' : null,
                        onChanged: (value) {
                          setState(() => email = value);
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: kTextInputDecoration.copyWith(
                            hintText: 'Enter an Password'),
                        validator: (value) => value.length < 6
                            ? 'Password must be 6+ character long !'
                            : null,
                        onChanged: (value) {
                          setState(() => password = value);
                        },
                        obscureText: true,
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading=true;
                            });

                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'SignIn Failed !';
                                loading = false;
                              });
                            }
                          }
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        color: Colors.brown[700],
                      ),
                      SizedBox(height: 15),
                      Text(
                        error,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                        ),
                      )
                    ],
                  )),
            ),
          );
  }
}
