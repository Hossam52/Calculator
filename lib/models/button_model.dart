import 'package:flutter/cupertino.dart';

void _temp() {}

abstract class ButtonModel {
  String content;
  VoidCallback onPressed;
  Color color;
  ButtonModel(
      {required this.content,
      this.onPressed = _temp,
      this.color = const Color(0xFF74c69d)});
}

class NumberButton extends ButtonModel {
  NumberButton({required String content, VoidCallback onPressed = _temp})
      : super(content: content, onPressed: onPressed);
}

class OperatorButton extends ButtonModel {
  OperatorButton(
      {required String content, VoidCallback onPressed = _temp, Color? color})
      : super(
            content: content,
            onPressed: onPressed,
            color: color ?? Color(0xFF1b4332));
}

class EqualButton extends ButtonModel {
  EqualButton({required String content, VoidCallback onPressed = _temp})
      : super(content: content, onPressed: onPressed, color: Color(0xFFba181b));
}
