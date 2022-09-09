import 'package:flutter/material.dart';
import 'package:quizappflutter/models/constants.dart';
import 'package:quizappflutter/models/question_model.dart';
import 'package:quizappflutter/widgets/next_button.dart';
import 'package:quizappflutter/widgets/question_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Questions> _questions = [
    Questions(id: '10', title: 'What is 4 + 8 ?', options: {
      '5': false,
      '14': false,
      '12': true,
      '16': false,
    }),
    Questions(id: '11', title: 'What is 30 + 20 ?', options: {
      '50': true,
      '40': false,
      '60': false,
      '70': false,
    }),
  ];

  int index = 0;

  //create a function to display the next question
  void nextQuestion() {
    if (index == _questions.length - 1) {
      return;
    } else {
      setState(() {
        index++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Quiz App'),
        backgroundColor: background,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            //add questionwidget here
            Questionwidget(
              indexAction: index,
              question: _questions[index].title,
              totalQuestions: _questions.length,
            ),

            const Divider(color: neutral, thickness: 2),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: NextButton(
          nextQuestion: nextQuestion, //the above nextQuestion function ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
