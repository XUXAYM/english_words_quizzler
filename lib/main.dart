import 'package:flutter/material.dart';

import 'nouns_quizz_page.dart';

void main() {
  runApp(QuizzlerApp());
}

class QuizzlerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'English Words Quizzler App',
      home: NounsQuizzPage(),
    );
  }
}
