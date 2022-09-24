import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calcs/constants/color_constants.dart';
import 'package:flutter_calcs/constants/constants.dart';
import 'package:flutter_calcs/database/db.dart';
import 'package:flutter_calcs/widgets/add_button.dart';
import 'package:flutter_calcs/widgets/custom_drawer.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import '../../widgets/pagination.dart';

class VelocityAir extends StatefulWidget {
  const VelocityAir({Key? key}) : super(key: key);

  @override
  State<VelocityAir> createState() => _VelocityAirState();
}

class _VelocityAirState extends State<VelocityAir> {
  bool standard = true;
  FirebaseServices firebaseServices = FirebaseServices();

  String title = 'Velocity of Air';

  final TextEditingController _velocityController = TextEditingController();
  final TextEditingController _thirdController = TextEditingController();
  final TextEditingController _airDensity = TextEditingController();
  final TextEditingController _airDensityAnswer = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _velocityController.dispose();
    _thirdController.dispose();
    _airDensity.dispose();
    _airDensityAnswer.dispose();
    super.dispose();
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
                  title: 'Vel. of Air',
                  nav: 'velOfAir',
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
                  'Velocity of Air (V)',
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
                      controller: _velocityController,
                      onChanged: (value) {
                        _calculate();
                      },
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Text(
                        "Standard Air?",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          standard == true ? "Yes" : "No",
                          style: TextStyle(
                              color: standard == true
                                  ? CupertinoColors.activeGreen
                                  : CupertinoColors.destructiveRed,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CupertinoSwitch(
                          // This bool value toggles the switch.
                          value: standard,
                          thumbColor: Colors.white,
                          trackColor: ColorConstants.borderColor,
                          activeColor: ColorConstants.lightGreen,
                          onChanged: (bool? value) {
                            // This is called when the user toggles the switch.
                            setState(() {
                              standard = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: !standard,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,5}')),
                            ],
                            controller: _airDensity,
                            onChanged: (value) {
                              _calculate();
                            },
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
                              fillColor:
                                  ColorConstants.lightScaffoldBackgroundColor,
                              labelText: 'Air Density (p)',
                              hintText: 'Enter air density [kg/m³]',
                              focusColor: Colors.white,
                              labelStyle: const TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    // ignore: unnecessary_const
                                    color: const Color(0xFFcbd5e1)),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Calculated Velocity of Air (V): ',
                            style: TextStyle(color: Color(0xFFffffff)),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
                          child: AbsorbPointer(
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: _airDensityAnswer,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintStyle:
                                    const TextStyle(color: Colors.white70),
                                border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
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
                  Visibility(
                    visible: standard,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Calculated Velocity of Air (V): ',
                            style: TextStyle(color: Color(0xFFffffff)),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
                          child: AbsorbPointer(
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: _thirdController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintStyle:
                                    const TextStyle(color: Colors.white70),
                                border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white),
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
                    r'V_{(stdair)} = 1.225 \times \sqrt{VP}',
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
    String? str1 = ' m/s';
    final firstValue = double.parse(_velocityController.text);

    if (_velocityController.text.trim().isNotEmpty && standard == true) {
      final square = sqrt(firstValue);
      _thirdController.text = (square * 1.225).toStringAsFixed(2) + str1;
    }
    if (_velocityController.text.trim().isNotEmpty &&
        _airDensity.text.trim().isNotEmpty) {
      final airD = double.parse(_airDensity.text);
      final square = sqrt(firstValue);
      _airDensityAnswer.text = (square * airD).toStringAsFixed(2) + str1;
    }
  }
}
