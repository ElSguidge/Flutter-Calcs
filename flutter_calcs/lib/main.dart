import 'package:flutter/material.dart';
import 'package:flutter_calcs/constants/constants.dart';
import 'package:flutter_calcs/router.dart' as router;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
      initialRoute: homeRoute,
    );
  }
}
