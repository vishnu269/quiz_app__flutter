import 'package:http/http.dart' as http;
// ignore: unused_import
import 'package:quizappflutter/models/question_model.dart';
import 'dart:convert'; //the http package

class DBconnect {
  //lets first create a function to add a question to our database
  //declare the name of the tableyou want to create and add .json as suffix
  final url = Uri.parse(
      'https://simplequizapp-c3c6d-default-rtdb.firebaseio.com/questions.json');

  Future<void> addQuestion(Questions question) async {
    http.post(url,
        body: json.encode({
          'title': question.title,
          'options': question.options,
        }));
  }

  //fetch the data from database
  Future<void> fetchQuestions() async {
    //we got the data from just doing this,
    //now lets print to see what we got
    http.get(url).then((response) {
      //the 'then' method returns a 'response' which is our data
      // to whats inside we have to decode it first

      //  final json = "[" + response.body + "]";
      var data = json.decode(response.body) as Map<String, dynamic>;

      // data.forEach((key, value) {
      //   var newQuestion = Questions(
      //     id: key, //the encrypted key/the title we gave to our data
      //     title: value['title'], //title of question
      //     options: value['options'], //options of the question
      //   );
      // });

      print(data);
    });
  }
}
