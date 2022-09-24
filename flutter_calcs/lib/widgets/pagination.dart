import 'package:flutter/material.dart';

class Pagination extends StatelessWidget {
  final Padding? padding;
  final Color buttonColor;
  final Color textColor;
  final Color splashColor;
  final String nav;
  final String? title;
  final IconData? icon;
  final bool? isIcon;

  const Pagination(
      {this.title,
      required this.nav,
      required this.buttonColor,
      this.padding,
      required this.splashColor,
      required this.textColor,
      this.isIcon = false,
      this.icon,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, top: 5.0, bottom: 5.0),
      child: MaterialButton(
        minWidth: 5,
        color: buttonColor,
        textColor: textColor,
        child: isIcon == false ? Text(title!) : Icon(icon),
        onPressed: () => {Navigator.pushNamed(context, nav)},
        splashColor: splashColor,
      ),
    );
  }
}
