import 'package:flutter/material.dart';
import 'package:flutter_calcs/constants/constants.dart';

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
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              const DrawerHeader(
                child: Center(
                  child: Image(
                    image: AssetImage('lib/icons/cropped-AGC_Logo_2022.png'),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pushNamed(context, homeRoute);
                },
              ),
              ListTile(
                leading: const Icon(Icons.build),
                title: const Text('Install'),
                onTap: () {
                  Navigator.pushNamed(context, installHome);
                },
              ),
              ListTile(
                leading: const Icon(Icons.assignment_turned_in_sharp),
                title: const Text('Commissioning'),
                onTap: () {
                  Navigator.pushNamed(context, commissioningHome);
                },
              ),
            ],
          ),
        ),
      ),
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
