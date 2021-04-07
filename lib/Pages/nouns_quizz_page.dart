import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../alerts.dart';

class NounsQuizzPage extends StatefulWidget {
  NounsQuizzPage({@required this.nounsQuizzBrain});

  final nounsQuizzBrain;

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
        widget.nounsQuizzBrain.reset();
      });

  void _nextQuestion() {
    {
      if (widget.nounsQuizzBrain.isFinish)
        _showFinishAlert();
      else {
        widget.nounsQuizzBrain.nextQuestion();
      }
    }
  }

  void _checkAnswer() async {
    if (_controller.text.isEmpty) return;

    widget.nounsQuizzBrain.checkAnswer(_controller.text).then((answer) {
      _showResultAlert(answer);
      _controller.clear();
    });
    _focusNode.unfocus();
  }

  void _showCorrectAnswerAlert() => correctAnswerAlert(context,
          widget.nounsQuizzBrain.getQuestion().answers[0].toUpperCase(), () {
        Navigator.pop(context);
        setState(() {
          _nextQuestion();
        });
      }).show();

  void _showFinishAlert() =>
      finishAlert(context, _correctCount, _incorrectCount, _reset).show();

  void _showResultAlert(bool isCorrectAnswer)  => resultAlert(
          context,
          isCorrectAnswer,
          () {
          Navigator.pop(context);
          setState(() {
            _correctCount++;
            _nextQuestion();
          });
          },
          () {
          _incorrectCount++;
          Navigator.pop(context);
          _showCorrectAnswerAlert();
          }).show();


  @override
  void initState() {
    super.initState();

    _keyboardVisibilityController.onChange.listen((event) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
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
                    child: widget.nounsQuizzBrain.getQuestion() == null
                        ? CircularProgressIndicator()
                        : Text(
                            widget.nounsQuizzBrain.getQuestion().word,
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
      ),
    );
  }
}
