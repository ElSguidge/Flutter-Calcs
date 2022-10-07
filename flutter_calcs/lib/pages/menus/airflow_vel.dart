// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_calcs/constants/color_constants.dart';
import 'package:flutter_calcs/constants/constants.dart';
import 'package:flutter_calcs/widgets/custom_drawer.dart';
import 'package:flutter_calcs/widgets/list_buttons.dart';

import '../../widgets/pagination.dart';

class Sections {
  final String calc;
  final String nav;
  const Sections({required this.calc, required this.nav});
}

class AirFlowVelMenu extends StatefulWidget {
  const AirFlowVelMenu({Key? key}) : super(key: key);

  @override
  State<AirFlowVelMenu> createState() => _AirFlowVelMenuState();
}

class _AirFlowVelMenuState extends State<AirFlowVelMenu> {
  List<Sections> tests = [
    const Sections(calc: 'Vol. Flow Rate', nav: volFlowRate),
    const Sections(calc: 'Total Pressure', nav: totalPressure),
    const Sections(calc: 'Velocity of Air', nav: velOfAir),
    const Sections(calc: 'Air Changes', nav: airChange),
    const Sections(calc: 'Duct Area', nav: ductArea),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Airside Calculators',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
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
          Row(
            children: const <Widget>[
              Pagination(
                nav: 'commissioning_home',
                buttonColor: ColorConstants.secondaryDarkAppColor,
                padding:
                    Padding(padding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0)),
                splashColor: ColorConstants.splashButtons,
                textColor: Colors.white,
                isIcon: true,
                icon: Icons.home,
              ),
              Pagination(
                title: 'TAB',
                nav: 'calculators',
                buttonColor: ColorConstants.secondaryDarkAppColor,
                padding:
                    Padding(padding: EdgeInsets.fromLTRB(50.0, 5.0, 0.0, 5.0)),
                splashColor: ColorConstants.splashButtons,
                textColor: Colors.white,
                isIcon: false,
              ),
              Pagination(
                title: 'Air',
                nav: 'air',
                buttonColor: ColorConstants.secondaryDarkAppColor,
                padding:
                    Padding(padding: EdgeInsets.fromLTRB(50.0, 5.0, 0.0, 5.0)),
                splashColor: ColorConstants.splashButtons,
                textColor: Colors.white,
                isIcon: false,
              ),
              Pagination(
                title: 'Airflow & Vel.',
                nav: 'airflowVel',
                buttonColor: ColorConstants.messageColor,
                padding:
                    Padding(padding: EdgeInsets.fromLTRB(50.0, 5.0, 0.0, 5.0)),
                splashColor: ColorConstants.splashButtons,
                textColor: Colors.white,
                isIcon: false,
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: tests.length,
            itemBuilder: (context, index) {
              final calculations = tests[index];
              return InkWell(
                splashColor: const Color(0xFFa78bfa),
                onTap: () {
                  Navigator.pushNamed(context, calculations.nav);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListButtons(
                    textColor: Colors.white,
                    backgroundColor: ColorConstants.darkScaffoldBackgroundColor,
                    borderColor: Colors.grey[900]!,
                    text: calculations.calc,
                    size: 21,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
