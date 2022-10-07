import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class FormulaButton extends StatelessWidget {
  final Function()? onPressed;
  final String? formula;

  const FormulaButton(
      {required this.onPressed, required this.formula, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
        onPressed: () => onPressed!(),
        child: Math.tex(
          formula!,
          mathStyle: MathStyle.display,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
