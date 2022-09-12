import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class AppButtons extends StatelessWidget {
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  IconData? icon;
  double size;
  bool? isIcon;

  AppButtons(
      {Key? key,
      required this.textColor,
      required this.backgroundColor,
      required this.borderColor,
      required this.text,
      required this.size,
      this.isIcon = false,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        child: Center(
          child: isIcon == false
              ? Text(
                  text,
                  style: TextStyle(color: textColor, fontSize: size),
                )
              : Icon(
                  icon,
                  color: textColor,
                ),
        ),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: borderColor,
              width: 1.0,
            )));
  }
}
