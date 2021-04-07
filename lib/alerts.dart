import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Alert correctAnswerAlert(BuildContext context, String correctAnswer, Function onPressed) {
  return Alert(
    context: context,
    style: AlertStyle(
      animationType: AnimationType.grow,
      animationDuration: Duration(milliseconds: 400),
      isCloseButton: false,
      isOverlayTapDismiss: false,
    ),
    title: 'Правильный ответ:',
    type: AlertType.info,
    desc: correctAnswer,
    buttons: [
      DialogButton(child: Text('OK'), onPressed: onPressed),
    ],
  );
}

Alert finishAlert(BuildContext context, int correct, int wrong, Function onPressed) {
  return Alert(
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
              ': $correct',
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
              ': $wrong',
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
    closeFunction: () => onPressed(),
    buttons: [
      DialogButton(
        child: Text('OK'),
        onPressed: () {
          onPressed();
          Navigator.pop(context);
        },
      )
    ],
  );
}

Alert resultAlert(BuildContext context, bool isCorrectAnswer, Function onNextTap, Function onSkipTap) {
  return Alert(
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
        onPressed: onNextTap,
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
        onPressed: onSkipTap,
      ),
    ],
  );
}