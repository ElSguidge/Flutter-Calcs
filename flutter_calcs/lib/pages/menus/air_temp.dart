import 'package:flutter/material.dart';
import 'package:flutter_calcs/widgets/custom_drawer.dart';
import 'package:flutter_calcs/widgets/list_buttons.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants.dart';

class Sections {
  final String calc;
  final String nav;
  const Sections({required this.calc, required this.nav});
}

class AirTemp extends StatefulWidget {
  const AirTemp({Key? key}) : super(key: key);

  @override
  State<AirTemp> createState() => _AirTempState();
}

class _AirTempState extends State<AirTemp> {
  List<Sections> tests = [
    const Sections(calc: 'Convert (°F, °C, R, K)', nav: airTempConvert),
    const Sections(calc: 'Mixed Air Temp.', nav: mixedAirTemp),
    const Sections(calc: 'Mixed Air Enthalpy', nav: homeRoute),
    const Sections(calc: 'Outside Air Percent.', nav: homeRoute),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 5.0, 3.0, 5.0),
                child: MaterialButton(
                  minWidth: 5,
                  color: ColorConstants.secondaryDarkAppColor,
                  textColor: Colors.white,
                  child: const Icon(Icons.home),
                  onPressed: () =>
                      {Navigator.pushNamed(context, commissioningHome)},
                  splashColor: const Color(0xFFa78bfa),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                child: MaterialButton(
                  minWidth: 5,
                  color: ColorConstants.secondaryDarkAppColor,
                  textColor: Colors.white,
                  child: const Text('TAB'),
                  onPressed: () => {Navigator.pushNamed(context, calculators)},
                  splashColor: const Color(0xFFa78bfa),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(3.0, 5.0, 0.0, 5.0),
                child: MaterialButton(
                  minWidth: 5,
                  color: ColorConstants.secondaryDarkAppColor,
                  textColor: Colors.white,
                  child: const Text('Air'),
                  onPressed: () => {Navigator.pushNamed(context, air)},
                  splashColor: const Color(0xFFa78bfa),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(3.0, 5.0, 0.0, 5.0),
                child: MaterialButton(
                  minWidth: 5,
                  color: ColorConstants.messageColor,
                  textColor: Colors.white,
                  child: const Text('Air Temp'),
                  onPressed: () => {Navigator.pushNamed(context, airTemp)},
                  splashColor: const Color(0xFFa78bfa),
                ),
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
