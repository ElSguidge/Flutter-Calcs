import 'package:flutter/material.dart';
import 'package:flutter_calcs/constants/constants.dart';
import 'package:flutter_calcs/widgets/custom_drawer.dart';
import 'package:flutter_calcs/widgets/list_buttons.dart';

class Sections {
  final String calc;
  final String nav;
  const Sections({required this.calc, required this.nav});
}

class Air extends StatefulWidget {
  const Air({Key? key}) : super(key: key);

  @override
  State<Air> createState() => _AirState();
}

class _AirState extends State<Air> {
  List<Sections> tests = [
    const Sections(calc: 'Airflow and Velocity', nav: airflowVel),
    const Sections(calc: 'Air Temp.', nav: airTemp),
    const Sections(calc: 'Heat Transfer', nav: heatTransfer),
    const Sections(calc: 'Fan Equations', nav: fanEquations),
    const Sections(calc: 'Sheave Equations', nav: sheaveEquations),
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
                  color: const Color(0xFF22c55e),
                  textColor: Colors.white,
                  child: const Text('Air'),
                  onPressed: () => {Navigator.pushNamed(context, air)},
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
