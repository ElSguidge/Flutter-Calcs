// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_calcs/constants/constants.dart';
import 'package:flutter_calcs/widgets/custom_drawer.dart';
import 'package:flutter_calcs/widgets/list_buttons.dart';

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
    const Sections(calc: 'Vol. Flow Rate', nav: homeRoute),
    const Sections(calc: 'Total Pressure', nav: totalPressure),
    const Sections(calc: 'Velocity of Air', nav: homeRoute),
    const Sections(calc: 'Air Changes', nav: calculators),
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
          ),
        ),
        backgroundColor: const Color(0xFF111827),
      ),
      drawer: const CustomDrawer(),
      backgroundColor: const Color(0xFF111827),

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
                  color: const Color(0xFF6d28d9),
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
                  color: const Color(0xFF6d28d9),
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
                  color: const Color(0xFF6d28d9),
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
                  color: const Color(0xFF22c55e),
                  textColor: Colors.white,
                  child: const Text('Airflow & Vel.'),
                  onPressed: () => {Navigator.pushNamed(context, airflowVel)},
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
                onTap: () {
                  Navigator.pushNamed(context, calculations.nav);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListButtons(
                    textColor: Colors.white,
                    backgroundColor: const Color(0xFF6b7280),
                    borderColor: Colors.grey[200]!,
                    text: calculations.calc,
                    size: 20,
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
