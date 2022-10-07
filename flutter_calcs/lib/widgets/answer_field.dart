import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class AnswerField extends StatelessWidget {
  final TextEditingController controller;

  const AnswerField({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintStyle: const TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: ColorConstants.lightScaffoldBackgroundColor,
      ),
    );
  }
}
