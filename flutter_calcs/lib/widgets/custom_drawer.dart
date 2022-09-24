import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calcs/constants/color_constants.dart';

import '../constants/constants.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  signOut() async {
    await _auth.signOut();

    // print("user logged out");
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0)),
        child: Drawer(
          child: Container(
            color: ColorConstants.secondaryDarkAppColor,
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
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  onTap: () {
                    Navigator.pushNamed(context, homeRoute);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.build),
                  title: const Text('Install'),
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  onTap: () {
                    Navigator.pushNamed(context, installHome);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.assignment_turned_in_sharp),
                  title: const Text('Commissioning'),
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  onTap: () {
                    Navigator.pushNamed(context, commissioningHome);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Log out'),
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  onTap: () {
                    signOut();
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, openingView);
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
