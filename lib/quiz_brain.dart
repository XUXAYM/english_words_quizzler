import 'package:english_words_quizzler/question.dart';
import 'package:english_words_quizzler/question_repo.dart';



class QuizzBrain{
  QuizzBrain(this._repo){
    _questionNumber = _initFirstQuestion();
  }

  final QuestionRepo _repo;

  int _questionNumber = 0;

  Question getQuestion() {
    try {
      return _repo.getByOrder(_questionNumber);
    }
    catch (ex){
      return null;
    }
  }
  void nextQuestion() {
    if(!isFinish) {
      do {
        _questionNumber++;
      }
      while (_repo.getByOrder(_questionNumber).getAnswersRatio() > 1);
    }
  }
  int _initFirstQuestion(){
    int index = 0;
    while (_repo.getByOrder(index).getAnswersRatio() > 1){
      index++;
    }
    return index;
  }

  bool get isFinish => _questionNumber >= _repo.getLength();

  void reset(){
    _questionNumber = 0;
  }

 Future<bool> checkAnswer(String input) async {
    bool isCorrect = _repo.getByOrder(_questionNumber).checkAnswer(input);
    await _repo.saveData();
    return isCorrect;
 }
}