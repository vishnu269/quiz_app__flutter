import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizappflutter/models/constants.dart';
import 'package:quizappflutter/models/question_model.dart';
import 'package:quizappflutter/widgets/next_button.dart';
import 'package:quizappflutter/widgets/question_widget.dart';

import '../widgets/option_card.dart';

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

  int score = 0;

  bool isPressed = false;

  bool isAlreadySelected = false;

  //create a function to display the next question
  void nextQuestion() {
    if (index == _questions.length - 1) {
      return;
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select any option'),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(vertical: 20.0),
          ),
        );
      }
    }
  }

  //create a function for changing color
  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
        setState(() {
          isPressed = true;
          isAlreadySelected = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //change the background
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Quiz App'),
        backgroundColor: background,
        shadowColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'Score: $score',
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ],
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

            const SizedBox(height: 25.0),
            for (int i = 0; i < _questions[index].options.length; i++)
              GestureDetector(
                onTap: () => checkAnswerAndUpdate(
                    _questions[index].options.values.toList()[i]),
                child: OptionCard(
                  option: _questions[index].options.keys.toList()[i],
                  color: isPressed
                      ? _questions[index].options.values.toList()[i] == true
                          ? correct
                          : incorrect
                      : neutral,
                ),
              )
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
