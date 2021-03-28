import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'quiz_brain.dart';

QuizzBrain _nounsQuizzBrain = QuizzBrain();

class NounsQuizzPage extends StatefulWidget {
  @override
  _NounsQuizzPageState createState() => _NounsQuizzPageState();
}

class _NounsQuizzPageState extends State<NounsQuizzPage> {
  String inputString;

  void _showAlertResult(bool isCorrectAnswer) {
    Alert(
      context: context,
      style: AlertStyle(
        animationType: AnimationType.grow,
        animationDuration: Duration(milliseconds: 400),
        isCloseButton: false,
        isOverlayTapDismiss: false,
      ),
      title: isCorrectAnswer ? 'Correct!' : 'Wrong!',
      type: isCorrectAnswer ? AlertType.success : AlertType.error,
      buttons: <DialogButton>[
        DialogButton(
          color: Colors.green,
          child: Text('Next'),
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              _nounsQuizzBrain.nextQuestion();
            });
          },
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  _nounsQuizzBrain.getQuestion().word,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontSize: 24.0,
                ),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(),
                  filled: true,
                  focusColor: Colors.white70,
                  fillColor: Colors.white,
                  hoverColor: Colors.green,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                ),
                toolbarOptions: ToolbarOptions(),
                cursorColor: Colors.grey.shade900,
                strutStyle: StrutStyle(
                  fontSize: 24.0,
                ),
                onChanged: (text) {
                  inputString = text;
                },
              ),
            ),
            SizedBox(
              height: 32,
            ),
            FloatingActionButton(
              backgroundColor: Colors.white70,
              onPressed: () {
                _nounsQuizzBrain.checkAnswer(inputString).then((value) {
                  _showAlertResult(value);
                });
              },
              child: Icon(
                Icons.check,
                color: Colors.green.shade800,
              ),
            ),
            SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
