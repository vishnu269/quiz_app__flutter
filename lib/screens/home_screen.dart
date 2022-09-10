import 'package:flutter/material.dart';
import 'package:quizappflutter/models/constants.dart';
import 'package:quizappflutter/models/db_connect.dart';
import 'package:quizappflutter/models/question_model.dart';
import 'package:quizappflutter/widgets/next_button.dart';
import 'package:quizappflutter/widgets/question_widget.dart';
import 'package:quizappflutter/widgets/result_box.dart';

import '../widgets/option_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //create an object for DBconnect
  var db = DBconnect();

  late Future _questions;

  Future<List<Questions>> getData() async {
    return db.fetchQuestions();
  }

  @override
  void initState() {
    _questions = getData();
    super.initState();
  }

  //create an index to loop through questions
  int index = 0;
  // create a score variable
  int score = 0;
  //create a bool value to check if the user has clicked
  bool isPressed = false;
  //create a function to display the next question
  bool isAlreadySelected = false;

  //create a function to display the next question
  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      //this is the block where questions end
      showDialog(
          context: context,
          barrierDismissible:
              false, //it will disable the dismiss function on clicking outside of box
          builder: (ctx) => ResultBox(
                result: score, //total points the user get
                questionLength: questionLength,
                onPressed: startOver, //out of how many question
              ));
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
      }
      setState(() {
        isPressed = true;
        isAlreadySelected = true;
      });
    }
  }

  //create a function to start over
  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    //use the FutureBuilder Widget
    return FutureBuilder(
        future: _questions as Future<List<Questions>>,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              var extractedData = snapshot.data as List<Questions>;

              return Scaffold(
                //change the background
                backgroundColor: background,
                appBar: AppBar(
                  title: const Text(
                    'Quiz App',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.cyanAccent,
                    ),
                  ),
                  backgroundColor: background,
                  shadowColor: Colors.transparent,
                  actions: [
                    SizedBox(height: 30.0),
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
                      SizedBox(height: 30.0),
                      //add questionwidget here
                      Questionwidget(
                        indexAction: index,
                        question: extractedData[index].title,
                        totalQuestions: extractedData.length,
                      ),

                      const Divider(color: neutral, thickness: 2),

                      const SizedBox(height: 25.0),
                      for (int i = 0;
                          i < extractedData[index].options.length;
                          i++)
                        GestureDetector(
                          onTap: () => checkAnswerAndUpdate(
                              extractedData[index].options.values.toList()[i]),
                          child: OptionCard(
                            option:
                                extractedData[index].options.keys.toList()[i],
                            color: isPressed
                                ? extractedData[index]
                                            .options
                                            .values
                                            .toList()[i] ==
                                        true
                                    ? correct
                                    : incorrect
                                : neutral,
                          ),
                        ),
                    ],
                  ),
                ),

                //use the  floating action button
                floatingActionButton: GestureDetector(
                  onTap: () => nextQuestion(extractedData.length),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: NextButton(),
                  ),
                ),

                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
              );
            }
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20.0),
                  Text(
                    'Please Wait while questions are loading..',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      decoration: TextDecoration.none,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: Text('No Data'),
          );
        });
  }
}
