import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/color_constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? labelText;
  final String? hintText;
  final RegExp regExp;
  final Icon? icon;

  const CustomTextField(
      {Key? key,
      this.hintText,
      required this.regExp,
      this.icon,
      required this.controller,
      this.keyboardType,
      this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(regExp),
      ],
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintStyle: const TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: ColorConstants.lightScaffoldBackgroundColor,
        labelText: labelText,
        hintText: hintText,
        floatingLabelAlignment: FloatingLabelAlignment.center,
        labelStyle: const TextStyle(color: Colors.white, fontSize: 18),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              width: 2,
              // ignore: unnecessary_const
              color: ColorConstants.lightBlue),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
