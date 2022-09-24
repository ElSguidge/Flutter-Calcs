import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calcs/constants/color_constants.dart';
import 'package:flutter_calcs/database/db.dart';
import 'package:flutter_calcs/widgets/add_button.dart';
import 'package:flutter_calcs/widgets/custom_drawer.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import '../../widgets/pagination.dart';

class OutsideAirPercentage extends StatefulWidget {
  const OutsideAirPercentage({Key? key}) : super(key: key);

  @override
  State<OutsideAirPercentage> createState() => _OutsideAirPercentageState();
}

class _OutsideAirPercentageState extends State<OutsideAirPercentage> {
  bool standard = true;
  FirebaseServices firebaseServices = FirebaseServices();

  String title = 'Outside Air Percentage';

  final TextEditingController _raTemp = TextEditingController();
  final TextEditingController _mixAirTemp = TextEditingController();
  final TextEditingController _outsideAirTemp = TextEditingController();
  final TextEditingController _tempAnswer = TextEditingController();

  final TextEditingController _enthRa = TextEditingController();
  final TextEditingController _enthMixed = TextEditingController();
  final TextEditingController _enthOutside = TextEditingController();
  final TextEditingController _enthAnswer = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _raTemp.dispose();
    _mixAirTemp.dispose();
    _outsideAirTemp.dispose();
    _tempAnswer.dispose();
    _enthRa.dispose();
    _enthMixed.dispose();
    _enthOutside.dispose();
    _enthAnswer.dispose();
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
      drawer: CustomDrawer(),
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
                  title: 'Air Temp.',
                  nav: 'airTemp',
                  buttonColor: ColorConstants.secondaryDarkAppColor,
                  padding: Padding(
                      padding: EdgeInsets.fromLTRB(50.0, 5.0, 0.0, 5.0)),
                  splashColor: ColorConstants.splashButtons,
                  textColor: Colors.white,
                  isIcon: false,
                ),
                Pagination(
                  title: 'Outside Air Per.',
                  nav: 'outsideAirPer',
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
                  'Outside Air Percentage',
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
                  const Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(
                        "Calculate with Temperature or Enthalpy?",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      standard == true ? "Temperature" : "Enthalpy",
                      style: TextStyle(
                          color: standard == true
                              ? ColorConstants.lightBlue
                              : ColorConstants.lightRed,
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
                  Visibility(
                    visible: standard,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 10.0, 10.0, 10.0),
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^-?\d*\.?\d{0,2}')),
                                    ],
                                    controller: _raTemp,
                                    onChanged: (value) {
                                      _calculate();
                                    },
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            signed: true, decimal: true),
                                    cursorColor: Colors.white,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintStyle: const TextStyle(
                                          color: Colors.white70),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: ColorConstants
                                          .lightScaffoldBackgroundColor,
                                      labelText: 'RA Temp °C',
                                      hintText: 'Enter °C',
                                      focusColor: Colors.white,
                                      labelStyle:
                                          const TextStyle(color: Colors.white),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            // ignore: unnecessary_const
                                            color: Colors.white60),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                // optional flex property if flex is 1 because the default flex is 1
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10.0, 10.0, 20.0, 10.0),
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^-?\d*\.?\d{0,2}')),
                                    ],
                                    controller: _mixAirTemp,
                                    onChanged: (value) {
                                      _calculate();
                                    },
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            signed: true, decimal: true),
                                    cursorColor: Colors.white,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintStyle: const TextStyle(
                                          color: Colors.white70),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: ColorConstants
                                          .lightScaffoldBackgroundColor,
                                      labelText: 'Mixed Air Temp',
                                      hintText: 'Enter °C',
                                      focusColor: Colors.white,
                                      labelStyle:
                                          const TextStyle(color: Colors.white),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            // ignore: unnecessary_const
                                            color: Colors.white60),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                90.0, 8.0, 90.0, 10.0),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^-?\d*\.?\d{0,2}')),
                              ],
                              controller: _outsideAirTemp,
                              onChanged: (value) {
                                _calculate();
                              },
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              cursorColor: Colors.white,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintStyle:
                                    const TextStyle(color: Colors.white70),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor:
                                    ColorConstants.lightScaffoldBackgroundColor,
                                labelText: 'OA Temp °C',
                                hintText: 'Enter °C',
                                focusColor: Colors.white,
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      // ignore: unnecessary_const
                                      color: Colors.white60),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
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
                            'Calculated Outside Air Percentage: ',
                            style: TextStyle(color: Color(0xFFffffff)),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
                          child: AbsorbPointer(
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: _tempAnswer,
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

                  // enthalpy
                  Visibility(
                    visible: !standard,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 10.0, 10.0, 10.0),
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^-?\d*\.?\d{0,2}')),
                                    ],
                                    controller: _enthRa,
                                    onChanged: (value) {
                                      _calculate();
                                    },
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            signed: true, decimal: true),
                                    cursorColor: Colors.white,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintStyle: const TextStyle(
                                          color: Colors.white70),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: ColorConstants
                                          .lightScaffoldBackgroundColor,
                                      labelText: 'RA Enthalpy (kJ/kg)',
                                      hintText: 'Enter kJ/kg',
                                      focusColor: Colors.white,
                                      labelStyle:
                                          const TextStyle(color: Colors.white),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            // ignore: unnecessary_const
                                            color: Colors.white60),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                // optional flex property if flex is 1 because the default flex is 1
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10.0, 10.0, 20.0, 10.0),
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^-?\d*\.?\d{0,2}')),
                                    ],
                                    controller: _enthMixed,
                                    onChanged: (value) {
                                      _calculate();
                                    },
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            signed: true, decimal: true),
                                    cursorColor: Colors.white,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintStyle: const TextStyle(
                                          color: Colors.white70),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: ColorConstants
                                          .lightScaffoldBackgroundColor,
                                      labelText: 'Mixed Enthalpy (kJ/kg)',
                                      hintText: 'Enter kJ/kg',
                                      focusColor: Colors.white,
                                      labelStyle:
                                          const TextStyle(color: Colors.white),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            // ignore: unnecessary_const
                                            color: Colors.white60),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                90.0, 8.0, 90.0, 10.0),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^-?\d*\.?\d{0,2}')),
                              ],
                              controller: _enthOutside,
                              onChanged: (value) {
                                _calculate();
                              },
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              cursorColor: Colors.white,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintStyle:
                                    const TextStyle(color: Colors.white70),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor:
                                    ColorConstants.lightScaffoldBackgroundColor,
                                labelText: 'OA Enthalpy (kJ/kg)',
                                hintText: 'Enter (kJ/kg)',
                                focusColor: Colors.white,
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      // ignore: unnecessary_const
                                      color: Colors.white60),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !standard,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Calculated Outside Air Percentage: ',
                            style: TextStyle(color: Color(0xFFffffff)),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
                          child: AbsorbPointer(
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: _enthAnswer,
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
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Math.tex(
                        r'\%_oa = \frac{(T_ra - T_ma)}{(T_ra - T_oa)} \times 100',
                        mathStyle: MathStyle.display,
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  void _calculate() {
    String? str1 = ' %';

    if (_raTemp.text.trim().isNotEmpty &&
        _mixAirTemp.text.trim().isNotEmpty &&
        _outsideAirTemp.text.trim().isNotEmpty) {
      final rat = double.parse(_raTemp.text);
      final mat = double.parse(_mixAirTemp.text);
      final oat = double.parse(_outsideAirTemp.text);
      final mix = (rat - mat) / (rat - oat);
      _tempAnswer.text = (mix * 100).toStringAsFixed(2) + str1;
    }
    if (_enthRa.text.trim().isNotEmpty &&
        _enthMixed.text.trim().isNotEmpty &&
        _enthOutside.text.trim().isNotEmpty &&
        !standard) {
      final enthRa = double.parse(_enthRa.text);
      final enthMa = double.parse(_enthMixed.text);
      final enthOa = double.parse(_enthOutside.text);
      final mix = (enthRa - enthMa) / (enthRa - enthOa);

      _enthAnswer.text = (mix * 100).toStringAsFixed(2) + str1;
    }
  }
}
