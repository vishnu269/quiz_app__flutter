import 'package:flutter/material.dart';

import '../models/constants.dart';

class Questionwidget extends StatelessWidget {
  const Questionwidget(
      {Key? key,
      required this.question,
      required this.indexAction,
      required this.totalQuestions})
      : super(key: key);

  final String question;
  final int indexAction;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Question ${indexAction + 1} / $totalQuestions : \n\n $question',
        style: const TextStyle(
          fontSize: 24.0,
          color: neutral,
        ),
      ),
    );
  }
}
