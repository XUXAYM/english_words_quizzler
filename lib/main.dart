import 'package:flutter/material.dart';
import 'Pages/loading_page.dart';

void main() {
  runApp(QuizzlerApp());
}

class QuizzlerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'English Words Quizzler App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade800,
      ),
      home: LoadingPage(),
    );
  }
}
