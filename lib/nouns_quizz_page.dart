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

  void _reset() => setState(() {
        _correctCount = 0;
        _incorrectCount = 0;
        _controller.clear();
        _nounsQuizzBrain.reset();
      });

  void _nextQuestion() {
    {
      if (_nounsQuizzBrain.isFinish)
        _showFinishAlert();
      else{
        _nounsQuizzBrain.nextQuestion();
      }
    }
  }

  void _checkAnswer() {
    if (_controller.text.isEmpty) return;

    _nounsQuizzBrain
        .checkAnswer(_controller.text)
        .then((answer) {
          _showResultAlert(answer);
          _controller.clear();
        });
    //_focusNode.unfocus();
  }

  void _showCorrectAnswerAlert() => Alert(
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
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _nextQuestion();
              });
            },
          )
        ],
      ).show();

  void _showFinishAlert() {
    Alert(
      context: context,
      style: AlertStyle(
        animationType: AnimationType.grow,
        animationDuration: Duration(milliseconds: 400),
        backgroundColor: Colors.grey.shade100,
      ),
      title: 'Итог',
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  color: Colors.black,
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
                  color: Colors.black,
                  fontSize: 16.0,
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),
        ],
      ),
      closeFunction: () => _reset(),
      buttons: [
        DialogButton(
          child: Text('OK'),
          onPressed: () {
            _reset();
            Navigator.pop(context);
          },
        )
      ],
    ).show();
  }

  void _showResultAlert(bool isCorrectAnswer) async {
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
                child: Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    _correctCount++;
                    _nextQuestion();
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
                    color: Colors.white,
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
                  _incorrectCount++;
                  Navigator.pop(context);
                  _showCorrectAnswerAlert();
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
                  onSubmitted: (_) => _checkAnswer(),
                  focusNode: _focusNode,
                  controller: _controller,
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 24.0,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    focusColor: Colors.white70,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade500),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade500),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
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
                      onPressed: () => _checkAnswer(),
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
