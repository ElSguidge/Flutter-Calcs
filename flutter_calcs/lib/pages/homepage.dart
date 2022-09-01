import 'package:flutter/material.dart';
import 'package:flutter_calcs/constants/constants.dart';
import 'package:flutter_calcs/widgets/custom_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Image(
          image: AssetImage('lib/icons/agc-logo-white.png'),
        ),
      ),
      drawer: const CustomDrawer(),
      body: Material(
        color: Colors.grey,
        child: ListTile(
          leading: const Icon(Icons.home),
          onTap: () {
            Navigator.pushNamed(context, homeRoute);
          },
        ),
      ),
    );
  }
}
