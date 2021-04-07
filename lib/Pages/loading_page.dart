import 'package:english_words_quizzler/question_repo.dart';
import 'package:english_words_quizzler/quiz_brain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'nouns_quizz_page.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  void loadingData() async{
    await Future.delayed(Duration(seconds: 4));
    final repo = QuestionRepo();
    await repo.initData();
    Navigator.push(context, MaterialPageRoute(builder: (context) => NounsQuizzPage(nounsQuizzBrain: QuizzBrain(repo),)));
  }

  @override
  void initState() {
    super.initState();
    loadingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingFour(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
