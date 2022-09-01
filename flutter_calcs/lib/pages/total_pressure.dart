import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calcs/constants/constants.dart';
import 'package:flutter_calcs/widgets/custom_drawer.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:provider/provider.dart';

class TotalPressure extends StatefulWidget {
  const TotalPressure({Key? key}) : super(key: key);

  @override
  State<TotalPressure> createState() => _TotalPressureState();
}

class _TotalPressureState extends State<TotalPressure> {
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  final TextEditingController _thirdController = TextEditingController();
  int get index => 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        backgroundColor: const Color(0xFF111827),
      ),
      drawer: const CustomDrawer(),
      backgroundColor: const Color(0xFF111827),
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
                    onPressed: () =>
                        {Navigator.pushNamed(context, calculators)},
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
                    minWidth: 1,
                    color: const Color(0xFF6d28d9),
                    textColor: Colors.white,
                    child: const Text('Airflow &..'),
                    onPressed: () => {Navigator.pushNamed(context, airflowVel)},
                    splashColor: const Color(0xFFa78bfa),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(3.0, 5.0, 0.0, 5.0),
                  child: MaterialButton(
                    minWidth: 5,
                    color: const Color(0xFF22c55e),
                    textColor: Colors.white,
                    child: const Text('Total Pr..'),
                    onPressed: () =>
                        {Navigator.pushNamed(context, totalPressure)},
                    splashColor: const Color(0xFFa78bfa),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    openDialog();
                  },
                  child: Math.tex(
                    r'\sqrt{abc}',
                    mathStyle: MathStyle.display,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Expanded(
                child: Text(
                  'TOTAL PRESSURE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Expanded(child: AddButton(item: item)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Color(0xFFe4e4e7)),
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: const Color(0xFF334155),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 20.0),
                    child: Container(
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,1}')),
                        ],
                        controller: _firstController,
                        onChanged: (value) {
                          _calculate();
                        },
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF64748b),
                          labelText: 'Velocity Pressure (VP)',
                          hintText: 'Enter velocity pressure [in Pa]',
                          focusColor: Colors.white,
                          labelStyle: const TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                // ignore: unnecessary_const
                                color: const Color(0xFFcbd5e1)),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,1}')),
                      ],
                      controller: _secondController,
                      onChanged: (value) {
                        _calculate();
                      },
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        filled: true,
                        fillColor: const Color(0xFF64748b),
                        labelText: 'Static Pressure (SP)',
                        hintText: 'Enter static pressure [in Pa]',
                        focusColor: Colors.white,
                        labelStyle: const TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              // ignore: unnecessary_const
                              color: const Color(0xFFcbd5e1)),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: const Text(
                      'Calculated Total Pressure: ',
                      style: TextStyle(color: Color(0xFFffffff)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 30.0),
                    child: AbsorbPointer(
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: _thirdController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF64748b),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: const Color(0xFF64748b),
          child: Container(
            height: 300.0, // Change as per your requirement
            width: 500.0, // Change as per your requirement
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Math.tex(
                    r'TP(Pa) = VP + SP',
                    mathStyle: MathStyle.display,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  void _calculate() {
    String? str1 = ' Pa';
    if (_firstController.text.trim().isNotEmpty &&
        _secondController.text.trim().isNotEmpty) {
      final firstValue = double.parse(_firstController.text);
      final secondValue = double.parse(_secondController.text);
      _thirdController.text = (firstValue + secondValue).toString() + str1;
    }
  }
}
