import 'package:calculator/models/button_model.dart';
import 'package:calculator/screens/calculator_screen.dart';
import 'package:calculator/widgets/calculator_button.dart';
import 'package:flutter/material.dart';

class RowButtons extends StatelessWidget {
  const RowButtons({Key? key, required this.buttons}) : super(key: key);
  final List<ButtonModel> buttons;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons
            .map((e) => Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: CalculatorButton(
                    content: e.content,
                    backgroundColor: e.color,
                    onPressed: e.onPressed,
                  ),
                )))
            .toList(),
      ),
    );
  }
}
