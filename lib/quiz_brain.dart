import 'package:english_words/english_words.dart';
import 'package:english_words_quizzler/question.dart';
import 'package:translator/translator.dart';

class QuizzBrain{
  final _translator = GoogleTranslator();
  final List<Question> _questions = nouns.map((word) => Question(word, word)).toList();

  int _questionNumber = 0;

  Question getQuestion() => this._questions[_questionNumber];
  void nextQuestion() {
    if(_questionNumber < _questions.length - 1)
      _questionNumber++;
  }

  Future<bool> checkAnswer(String input) async {
    String correctAnswer = await _translate();
    this._questions[_questionNumber].answer = correctAnswer;
    return correctAnswer.toLowerCase() == input.toLowerCase();
  }

  Future<String> _translate() async {
    var result = await _translator.translate(this._questions[_questionNumber].word, from: 'en', to: 'ru');
    return result.text;
  }
}