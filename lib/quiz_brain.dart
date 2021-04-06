import 'package:english_words/english_words.dart';
import 'package:english_words_quizzler/question.dart';

class QuizzBrain{
  final List<Question> _questions = nouns.map((word) => Question(word, [''])).toList();

  int _questionNumber = 0;

  Question getQuestion() => this._questions[_questionNumber];

  void nextQuestion() {
    if(_questionNumber < _questions.length - 1)
      _questionNumber++;
  }

  bool get isFinish => _questionNumber >= 10;

  void reset(){
    _questionNumber = 0;
  }

 // Future<bool> checkAnswer(String input) async {
    //String correctAnswer = this._questions[_questionNumber].answer;
    //if(correctAnswer == ''){
      //correctAnswer = await _translate();
      //this._questions[_questionNumber].answer = correctAnswer;
    //}
//  }
}