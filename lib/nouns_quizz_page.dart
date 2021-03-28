import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'quiz_brain.dart';

QuizzBrain _nounsQuizzBrain = QuizzBrain();

class NounsQuizzPage extends StatefulWidget {
  @override
  _NounsQuizzPageState createState() => _NounsQuizzPageState();
}

class _NounsQuizzPageState extends State<NounsQuizzPage> {
  final _keyboardVisibilityController = KeyboardVisibilityController();
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  int _correctCount = 0;
  int _incorrectCount = 0;

  void _showAlertResult(bool isCorrectAnswer) async {
    await Alert(
      context: context,
      style: AlertStyle(
        animationType: AnimationType.grow,
        animationDuration: Duration(milliseconds: 400),
        isCloseButton: false,
        isOverlayTapDismiss: false,
      ),
      title: isCorrectAnswer ? 'Correct!' : 'Wrong!',
      type: isCorrectAnswer ? AlertType.success : AlertType.error,
      buttons: isCorrectAnswer
          ? <DialogButton>[
              DialogButton(
                color: Colors.green,
                child: Text('Next'),
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    _controller.clear();
                    _correctCount++;
                    _nounsQuizzBrain.nextQuestion();
                  });
                },
              ),
            ]
          : <DialogButton>[
              DialogButton(
                color: Colors.green,
                child: Text(
                  'Try again',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              DialogButton(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.grey.shade700,
                ),
                child: Text(
                  'Skip',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Alert(
                    context: context,
                    style: AlertStyle(
                      animationType: AnimationType.grow,
                      animationDuration: Duration(milliseconds: 400),
                      isCloseButton: false,
                      isOverlayTapDismiss: false,
                    ),
                    title: 'Правильный ответ:',
                    type: AlertType.info,
                    desc: _nounsQuizzBrain.getQuestion().answer.toUpperCase(),
                    buttons: [
                      DialogButton(
                        child: Text('OK'),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ).show();
                  setState(() {
                    _controller.clear();
                    _incorrectCount++;
                    _nounsQuizzBrain.nextQuestion();
                  });
                },
              ),
            ],
    ).show();
  }

  @override
  void initState() {
    super.initState();

    _keyboardVisibilityController.onChange.listen((event) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            children: [
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                      Text(
                        ': $_correctCount',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                      Text(
                        ': $_incorrectCount',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                color: Colors.grey.shade500,
                indent: 8.0,
                endIndent: 8.0,
              ),
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
              Divider(
                color: Colors.grey.shade500,
                indent: 8.0,
                endIndent: 8.0,
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  onSubmitted: (value) {
                    _nounsQuizzBrain.checkAnswer(_controller.text).then((value) {
                      _showAlertResult(value);
                    });
                  },
                  focusNode: _focusNode,
                  controller: _controller,
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 24.0,
                  ),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade500),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    filled: true,
                    focusColor: Colors.white70,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade500),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                  toolbarOptions: ToolbarOptions(),
                  cursorColor: Colors.grey.shade900,
                  strutStyle: StrutStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              !_keyboardVisibilityController.isVisible
                  ? FloatingActionButton(
                      backgroundColor: Colors.green.shade800,
                      onPressed: () {
                        _nounsQuizzBrain
                            .checkAnswer(_controller.text)
                            .then((value) {
                          _showAlertResult(value);
                        });
                        _focusNode.unfocus();
                      },
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 32.0,
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
