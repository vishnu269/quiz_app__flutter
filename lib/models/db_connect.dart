import 'package:http/http.dart' as http;
// ignore: unused_import
import 'package:quizappflutter/models/question_model.dart';
import 'dart:convert'; //the http package

class DBconnect {
  //lets first create a function to add a question to our database
  //declare the name of the tableyou want to create and add .json as suffix
  final url = Uri.parse(
      'https://simplequizapp-c3c6d-default-rtdb.firebaseio.com/questions.json');

  //fetch the data from database
  Future<List<Questions>> fetchQuestions() async {
    //we got the data from just doing this,
    //now lets print to see what we got
    return http.get(url).then((response) {
      //the 'then' method returns a 'response' which is our data
      // to whats inside we have to decode it first

      var data = json.decode(response.body) as Map<String, dynamic>;
      List<Questions> newQuestions = [];

      data.forEach((key, value) {
        var newQuestion = Questions(
          id: key, //the encrypted key/the title we gave to our data
          title: value['title'], //title of question
          options: Map.castFrom(value['options']), //options of the question
        );
        //add to newQuestions
        newQuestions.add(newQuestion);
      });

      return newQuestions;
    });
  }
}
