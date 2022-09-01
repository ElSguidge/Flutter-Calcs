import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
    );
  }
}
