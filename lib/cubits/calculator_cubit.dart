import 'dart:collection';

import 'package:calculator/cubits/calculator_states.dart';
import 'package:calculator/models/button_model.dart';
import 'package:calculator/models/operators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalcCubit extends Cubit<CalcStates> {
  CalcCubit() : super(IntialCalcState());
  static CalcCubit instance(BuildContext context) =>
      BlocProvider.of<CalcCubit>(context);
  List<ButtonModel> get equalRow => [
        EqualButton(
            content: '=',
            onPressed: () {
              _evaluateResult();
            }),
      ];
  List<ButtonModel> get firstRow => [
        NumberButton(
            content: '0',
            onPressed: () {
              _updateExpressionContent('0');
            }),
        NumberButton(
            content: '.',
            onPressed: () {
              if (currentNumber.isEmpty || currentNumber.contains('.')) return;
              _updateExpressionContent('.');
            }),
        NumberButton(
            content: 'Ans',
            onPressed: () {
              if ((expression.isNotEmpty &&
                      expression[expression.length - 1] == ')') ||
                  currentNumber.isNotEmpty) _updateOperator(MultiplyOperator());
              _updateExpressionContent(previousAns.toString());
            }),
        OperatorButton(
            content: '+',
            onPressed: () {
              _updateOperator(PlusOperator());
            }),
      ];
  List<ButtonModel> get secondRow => [
        NumberButton(
            content: '1',
            onPressed: () {
              _updateExpressionContent('1');
            }),
        NumberButton(
            content: '2',
            onPressed: () {
              _updateExpressionContent('2');
            }),
        NumberButton(
          content: '3',
          onPressed: () {
            _updateExpressionContent('3');
          },
        ),
        OperatorButton(
            content: '*',
            onPressed: () {
              _updateOperator(MultiplyOperator());
            }),
      ];
  List<ButtonModel> get thirdRow => [
        NumberButton(
            content: '4',
            onPressed: () {
              _updateExpressionContent('4');
            }),
        NumberButton(
            content: '5',
            onPressed: () {
              _updateExpressionContent('5');
            }),
        NumberButton(
            content: '6',
            onPressed: () {
              _updateExpressionContent('6');
            }),
        OperatorButton(
            content: '/',
            onPressed: () {
              _updateOperator(DivisionOperator());
            }),
      ];
  List<ButtonModel> get fourthRow => [
        NumberButton(
            content: '7',
            onPressed: () {
              _updateExpressionContent('7');
            }),
        NumberButton(
            content: '8',
            onPressed: () {
              _updateExpressionContent('8');
            }),
        NumberButton(
            content: '9',
            onPressed: () {
              _updateExpressionContent('9');
            }),
        OperatorButton(
            content: '-',
            onPressed: () {
              _updateOperator(MinusOperator());
            }),
      ];
  List<ButtonModel> get fifthRow => [
        OperatorButton(
            content: '%',
            onPressed: () {
              _updateOperator(ModulasOperator());
            }),
        OperatorButton(
            content: '(',
            onPressed: () {
              if (currentNumber.isNotEmpty) {
                _updateOperator(MultiplyOperator());
              }
              _operators.addFirst(LeftParenthis());
              expression += '(';
              emit(ChnageExpressionState());
            }),
        OperatorButton(
            content: ')',
            onPressed: () {
              _addOperand();
              expression += ')';
              while (
                  _operators.isNotEmpty && _operators.first is! LeftParenthis) {
                _calculateSimpleExpression();
              }
              if (_operators.isNotEmpty) _operators.removeFirst();

              emit(ChnageExpressionState());
            }),
        OperatorButton(
            content: 'AC',
            color: Colors.red,
            onPressed: () {
              expression = '';
              _operands.clear();
              _operators.clear();
              currentNumber = '';
              emit(ChnageExpressionState());
            })
      ];
  List<ButtonModel> get sixthRow => [
        OperatorButton(
            content: 'X^2',
            onPressed: () {
              _updateOperator(ExponentialOperator());
              _updateExpressionContent('2');
            }),
        OperatorButton(
            content: 'sqr(X)',
            onPressed: () {
              _updateOperator(ExponentialOperator());
              _updateExpressionContent('0.5');
            }),
        OperatorButton(
            content: 'X^y',
            onPressed: () {
              _updateOperator(ExponentialOperator());
            }),
        OperatorButton(
            content: '1/X',
            onPressed: () {
              _updateExpressionContent('1');
              _updateOperator(DivisionOperator());
            }),
      ];
  double previousAns = 0;
  String expression = '';
  String currentNumber = '';
  Queue<Operator> _operators = Queue();
  Queue<double> _operands = Queue();
  void _appendOperator(Operator op) {
    if (currentNumber.isNotEmpty) _addOperand();
    if (_operators.isEmpty || _operators.first is LeftParenthis)
      _operators.addFirst(op);
    else {
      while (_operators.isNotEmpty &&
          Operator.currentOperatorIsHigherOrderThanLastOperator(
              _operators.first, op)) {
        _calculateSimpleExpression();
      }
      _operators.addFirst(op);
    }
    print(_operands.last);
  }

  void _calculateSimpleExpression() {
    final double operand2 = _operands.removeFirst();
    final double operand1 = _operands.removeFirst();
    final Operator lastOperator = _operators.removeFirst();
    final result = lastOperator.calculateResult(operand1, operand2);
    _operands.addFirst(result);
  }

  void _addOperand() {
    if (currentNumber.isEmpty) return;
    double numb = double.parse(currentNumber);
    _operands.addFirst(numb);
    currentNumber = '';
  }

  void _evaluateResult() {
    if (_operators.isEmpty) return;
    if (currentNumber.isNotEmpty) _addOperand();
    if (expression[expression.length - 1] == ')' ||
        _isDigit(expression[expression.length - 1])) {
      while (_operators.isNotEmpty) {
        _calculateSimpleExpression();
      }
      _changeFinalAnswerResult();
    }

    print(_operands.last);
  }

  bool _isDigit(String? content) {
    if (content == null) return false;
    return double.tryParse(content) != null;
  }

  void _changeFinalAnswerResult() {
    final double result = _operands.first;
    dynamic actualResultWithPrecision = result;
    if (result - result.toInt() == 0)
      actualResultWithPrecision = (result).truncate();

    expression = actualResultWithPrecision.toString();
    previousAns = result.toDouble();
    currentNumber = actualResultWithPrecision.toString();
    emit(ChnageExpressioResultnState());
  }

  void _updateExpressionContent(String content) {
    expression += content;
    currentNumber += content;
    emit(ChnageExpressionState());
  }

  void _updateOperator(Operator op) {
    if (currentNumber.isEmpty) {
      if (expression.isEmpty || expression[expression.length - 1] != ')')
        return;
    }
    expression += op.content;
    _appendOperator(op);
    emit(ChnageExpressionState());
  }
}
