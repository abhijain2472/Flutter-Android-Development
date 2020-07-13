import 'package:flutter/material.dart';
import 'question.dart';
import 'answer.dart';
class Quiz extends StatelessWidget {
  final List<Map<String,Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz({this.questions,this.questionIndex,this.answerQuestion});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Question(
          questionText: questions[questionIndex]['questionText'],
        ),
        ...(questions[questionIndex]['answers'] as List<Map<String,Object>>)
            .map((answer) {
          return Answer(
            answerQuestion: () => answerQuestion(answer['score']),
            answerText: answer['text'],
          );
        }).toList(),
      ],
    );
  }
}
