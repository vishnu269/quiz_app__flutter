import 'package:flutter/material.dart';
import 'package:quizappflutter/models/db_connect.dart';
import 'package:quizappflutter/models/question_model.dart';
import 'package:quizappflutter/screens/home_screen.dart';

void main() {
  var db = DBconnect();
  // db.addQuestion(Questions(id: '20', title: 'What is 20 x 10 ?', options: {
  //   '100': false,
  //   '200': true,
  //   '300': false,
  //   '500': false,
  // }));
  db.fetchQuestions();
  //the runApp method
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
