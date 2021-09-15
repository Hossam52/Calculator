import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton(
      {Key? key,
      required this.content,
      this.backgroundColor = const Color(0xFFFF6B6B),
      required this.onPressed})
      : super(key: key);
  final String content;
  final Color backgroundColor;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: property(backgroundColor)),
      onPressed: onPressed,
      child: FittedBox(
          child: Text(content,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white))),
    );
  }

  MaterialStateProperty<T> property<T>(T value) {
    return MaterialStateProperty.all(value);
  }
}
