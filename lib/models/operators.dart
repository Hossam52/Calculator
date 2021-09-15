import 'dart:math';

abstract class Operator {
  String get content;
  bool _isHigherPrecedenceThan(Operator op);
  double calculateResult(double first, double second);
  static bool currentOperatorIsHigherOrderThanLastOperator(
      Operator currentOperator, Operator lastOperatorInQueue) {
    return currentOperator._isHigherPrecedenceThan(lastOperatorInQueue);
  }
}

abstract class FirstOrderOperators extends Operator {
  @override
  bool _isHigherPrecedenceThan(Operator op) {
    if (op is FirstOrderOperators) return true;
    return false;
  }
}

class PlusOperator extends FirstOrderOperators {
  @override
  String get content => '+';
  @override
  double calculateResult(double first, double second) {
    return first + second;
  }
}

class MinusOperator extends FirstOrderOperators {
  @override
  double calculateResult(double first, double second) {
    return first - second;
  }

  @override
  String get content => '-';
}

///////////////////////////////////////////////////
abstract class SecondOrderOperators extends Operator {
  @override
  bool _isHigherPrecedenceThan(Operator op) {
    if (op is FirstOrderOperators || op is SecondOrderOperators)
      return true;
    else
      return false;
  }
}

class MultiplyOperator extends SecondOrderOperators {
  @override
  double calculateResult(double first, double second) {
    return first * second;
  }

  @override
  String get content => '*';
}

class DivisionOperator extends SecondOrderOperators {
  @override
  double calculateResult(double first, double second) {
    return first / second;
  }

  @override
  String get content => '/';
}

class ModulasOperator extends SecondOrderOperators {
  @override
  double calculateResult(double first, double second) {
    return first % second;
  }

  @override
  String get content => '%';
}

//////////////////////////////////////////////////

abstract class ThirdOrderOperators extends Operator {
  @override
  bool _isHigherPrecedenceThan(Operator op) {
    if (op is FirstOrderOperators ||
        op is SecondOrderOperators ||
        op is ThirdOrderOperators)
      return true;
    else
      return false;
  }
}

class ExponentialOperator extends ThirdOrderOperators {
  // final double exponential;

  // ExponentialOperator({required this.exponential});
  @override
  double calculateResult(double first, double second) {
    return pow(first, second).toDouble();
  }

  @override
  String get content => '^';
}

abstract class ForthOrderOperators extends Operator {
  @override
  bool _isHigherPrecedenceThan(Operator op) {
    if (op is FirstOrderOperators ||
        op is SecondOrderOperators ||
        op is ThirdOrderOperators ||
        op is ForthOrderOperators)
      return true;
    else
      return false;
  }
}

class LeftParenthis extends ForthOrderOperators {
  @override
  double calculateResult(double first, double second) {
    return 0.0;
  }

  @override
  String get content => '(';
}

class RightParenthis extends ForthOrderOperators {
  @override
  double calculateResult(double first, double second) {
    return 0.0;
  }

  @override
  String get content => ')';
}
