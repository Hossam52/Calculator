import 'package:calculator/cubits/calculator_cubit.dart';
import 'package:calculator/cubits/calculator_states.dart';
import 'package:calculator/models/button_model.dart';
import 'package:calculator/widgets/row_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(flex: 2, child: _buildDigitsResult(context)),
            Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _buildButtonsWidget(context),
                ))
          ],
        ),
      )),
    );
  }

  Widget _buildDigitsResult(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey.shade400,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPreviousAns(context),
            Spacer(),
            Expanded(child: _buildInputDigits(context))
          ],
        ),
      ),
    );
  }

  Widget _buildPreviousAns(context) {
    return BlocBuilder<CalcCubit, CalcStates>(
      builder: (_, state) => Text(
        'Ans = ${CalcCubit.instance(context).previousAns}',
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildInputDigits(context) {
    return BlocBuilder<CalcCubit, CalcStates>(
      builder: (_, state) => Container(
        width: double.infinity,
        color: Colors.brown.shade50,
        padding: const EdgeInsets.all(5),
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            CalcCubit.instance(context).expression,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonsWidget(BuildContext context) {
    CalcCubit.instance(context).fifthRow[2] = NumberButton(content: 'contaent');
    return Column(
      children: [
        Expanded(
            child: RowButtons(buttons: CalcCubit.instance(context).sixthRow)),
        Expanded(
            child: RowButtons(buttons: CalcCubit.instance(context).fifthRow)),
        Expanded(
            child: RowButtons(buttons: CalcCubit.instance(context).fourthRow)),
        Expanded(
            child: RowButtons(buttons: CalcCubit.instance(context).thirdRow)),
        Expanded(
            child: RowButtons(buttons: CalcCubit.instance(context).secondRow)),
        Expanded(
            child: RowButtons(buttons: CalcCubit.instance(context).firstRow)),
        Expanded(
            child: RowButtons(buttons: CalcCubit.instance(context).equalRow)),
      ],
    );
  }
}
