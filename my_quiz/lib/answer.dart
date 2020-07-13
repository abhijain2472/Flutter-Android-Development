import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerText;
  final Function answerQuestion;

  Answer({this.answerText, this.answerQuestion});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(12, 12, 12,0),
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blue,
        onPressed: answerQuestion,
        child: Text(answerText,style: TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),),
      ),
    );
  }
}
