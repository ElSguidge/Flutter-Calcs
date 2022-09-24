import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calcs/constants/color_constants.dart';
import 'package:flutter_calcs/database/db.dart';
import 'package:flutter_calcs/widgets/add_button.dart';
import 'package:flutter_calcs/widgets/custom_drawer.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import '../../widgets/pagination.dart';

class TotalPressure extends StatefulWidget {
  const TotalPressure({Key? key}) : super(key: key);

  @override
  State<TotalPressure> createState() => _TotalPressureState();
}

class _TotalPressureState extends State<TotalPressure> {
  FirebaseServices firebaseServices = FirebaseServices();

  String title = 'Total Pressure';

  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  final TextEditingController _thirdController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _firstController.addListener(_calculate);
    _secondController.addListener(_calculate);
  }

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    _thirdController.dispose();
    _firstController.removeListener(_calculate);
    _secondController.removeListener(_calculate);
    super.dispose();
  }

  void _calculate() {
    String? str1 = ' Pa';
    if (_firstController.text.trim().isNotEmpty &&
        _secondController.text.trim().isNotEmpty) {
      final firstValue = double.parse(_firstController.text);
      final secondValue = double.parse(_secondController.text);
      _thirdController.text = (firstValue + secondValue).toString() + str1;
    }
  }

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
        backgroundColor: ColorConstants.darkScaffoldBackgroundColor,
      ),
      drawer: const CustomDrawer(),
      backgroundColor: ColorConstants.lightScaffoldBackgroundColor,
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: const <Widget>[
                Pagination(
                  nav: 'commissioning_home',
                  buttonColor: ColorConstants.secondaryDarkAppColor,
                  padding: Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0)),
                  splashColor: ColorConstants.splashButtons,
                  textColor: Colors.white,
                  isIcon: true,
                  icon: Icons.home,
                ),
                Pagination(
                  title: 'TAB',
                  nav: 'calculators',
                  buttonColor: ColorConstants.secondaryDarkAppColor,
                  padding: Padding(
                      padding: EdgeInsets.fromLTRB(50.0, 5.0, 0.0, 5.0)),
                  splashColor: ColorConstants.splashButtons,
                  textColor: Colors.white,
                  isIcon: false,
                ),
                Pagination(
                  title: 'Air',
                  nav: 'air',
                  buttonColor: ColorConstants.secondaryDarkAppColor,
                  padding: Padding(
                      padding: EdgeInsets.fromLTRB(50.0, 5.0, 0.0, 5.0)),
                  splashColor: ColorConstants.splashButtons,
                  textColor: Colors.white,
                  isIcon: false,
                ),
                Pagination(
                  title: 'Airflow & Vel.',
                  nav: 'airflowVel',
                  buttonColor: ColorConstants.secondaryDarkAppColor,
                  padding: Padding(
                      padding: EdgeInsets.fromLTRB(50.0, 5.0, 0.0, 5.0)),
                  splashColor: ColorConstants.splashButtons,
                  textColor: Colors.white,
                  isIcon: false,
                ),
                Pagination(
                  title: 'Total Pres...',
                  nav: 'totalPressure',
                  buttonColor: ColorConstants.messageColor,
                  padding: Padding(
                      padding: EdgeInsets.fromLTRB(50.0, 5.0, 0.0, 5.0)),
                  splashColor: ColorConstants.splashButtons,
                  textColor: Colors.white,
                  isIcon: false,
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
              AddButton(title: title),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: ColorConstants.borderColor),
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: ColorConstants.secondaryDarkAppColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,1}')),
                      ],
                      controller: _firstController,
                      // onChanged: (value) {
                      //   _calculate();
                      // },
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.white70),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: ColorConstants.lightScaffoldBackgroundColor,
                        labelText: 'Velocity Pressure (VP)',
                        hintText: 'Enter velocity pressure [in Pa]',
                        focusColor: Colors.white,
                        labelStyle: const TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              // ignore: unnecessary_const
                              color: Colors.white60),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,1}')),
                      ],
                      controller: _secondController,
                      // onChanged: (value) {
                      //   _calculate();
                      // },
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.white70),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: ColorConstants.lightScaffoldBackgroundColor,
                        labelText: 'Static Pressure (SP)',
                        hintText: 'Enter static pressure [in Pa]',
                        focusColor: Colors.white,
                        labelStyle: const TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              // ignore: unnecessary_const
                              color: Colors.white60),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'Calculated Total Pressure: ',
                    style: TextStyle(color: Color(0xFFffffff)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
                    child: AbsorbPointer(
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: _thirdController,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor:
                              ColorConstants.lightScaffoldBackgroundColor,
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
          backgroundColor: ColorConstants.lightScaffoldBackgroundColor,
          child: SizedBox(
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
}
