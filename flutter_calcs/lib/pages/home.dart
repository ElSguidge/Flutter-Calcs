import 'package:flutter/material.dart';

import 'package:flutter_calcs/constants/color_constants.dart';
import 'package:flutter_calcs/constants/constants.dart';

import '../widgets/custom_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Welcome',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorConstants.darkScaffoldBackgroundColor,
      ),
      drawer: const CustomDrawer(),
      backgroundColor: ColorConstants.lightScaffoldBackgroundColor,

      // ignore: avoid_unnecessary_containers
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5.0, 3.0, 5.0),
                  child: MaterialButton(
                    minWidth: 5,
                    color: ColorConstants.secondaryDarkAppColor,
                    textColor: Colors.white,
                    child: const Text("projects"),
                    onPressed: () =>
                        {Navigator.pushNamed(context, upComingProjects)},
                    splashColor: const Color(0xFFa78bfa),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
