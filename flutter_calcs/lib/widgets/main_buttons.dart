import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class MainButtons extends StatelessWidget {
  final Function()? onPressed;
  final String name;
  final Color textColor;
  final bool active;

  const MainButtons(
      {required this.onPressed,
      required this.name,
      required this.textColor,
      required this.active,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(name),
        color: active == true
            ? ColorConstants.lightBlue
            : ColorConstants.secondaryDarkAppColor,
        textColor: textColor,
      ),
    );
  }
}
