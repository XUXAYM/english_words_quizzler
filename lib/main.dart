import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'nouns_quizz_page.dart';

void main() {
  runApp(QuizzlerApp());
}

class QuizzlerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'English Words Quizzler App',
      home: KeyboardDismissOnTap(
        child: NounsQuizzPage(),
      ),
    );
  }
}
