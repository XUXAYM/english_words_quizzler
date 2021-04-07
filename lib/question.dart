
class Question{
  Question(this.word, this.answers);

  final List<String> answers;
  final String word;
  int _correctAnswers = 0;
  int _wrongAnswers = 0;

  Question.fromJson(Map<String, dynamic> json)
      : word = json['word'],
        answers = (json['answers'] as List)?.map((item) => item as String)?.toList(),
        _correctAnswers = json['correct'],
        _wrongAnswers = json['wrong'];

  Map<String, dynamic> toJson() =>
      {
        'word': word,
        'answers': answers,
        'correct': _correctAnswers,
        'wrong': _wrongAnswers,
      };

  bool checkAnswer(String userAnswer){
    if (answers.contains(userAnswer.toLowerCase().trim())) {
      _correctAnswers++;
      print('Correct: $_correctAnswers');
      return true;
    }else{
      _wrongAnswers++;
      print('Wrong: $_wrongAnswers');
      return false;
    }
  }

  int getAnswersRatio() => _correctAnswers - _wrongAnswers;
}