import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import 'package:flutter_calcs/constants/color_constants.dart';
import 'package:flutter_calcs/constants/constants.dart';
import 'package:flutter_calcs/database/db.dart';
import 'package:flutter_calcs/widgets/add_button.dart';
import 'package:flutter_calcs/widgets/custom_drawer.dart';

class MixedAir extends StatefulWidget {
  const MixedAir({Key? key}) : super(key: key);

  @override
  State<MixedAir> createState() => _MixedAirState();
}

class _MixedAirState extends State<MixedAir> {
  bool standard = true;
  FirebaseServices firebaseServices = FirebaseServices();

  String title = 'Mixed Air Temperature';

  final TextEditingController _oaPercent = TextEditingController();
  final TextEditingController _oaTemp = TextEditingController();
  final TextEditingController _raPercent = TextEditingController();
  final TextEditingController _raTemp = TextEditingController();
  final TextEditingController _mixedAirTempAnswer = TextEditingController();
  @override
  void initState() {
    super.initState();
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
                      onPressed: () =>
                          {Navigator.pushNamed(context, calculators)},
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
                      minWidth: 1,
                      color: ColorConstants.secondaryDarkAppColor,
                      textColor: Colors.white,
                      child: const Text('Air Temp'),
                      onPressed: () => {Navigator.pushNamed(context, airTemp)},
                      splashColor: const Color(0xFFa78bfa),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(3.0, 5.0, 0.0, 5.0),
                    child: MaterialButton(
                      minWidth: 5,
                      color: ColorConstants.messageColor,
                      textColor: Colors.white,
                      child: const Text('Mixed Air..'),
                      onPressed: () =>
                          {Navigator.pushNamed(context, mixedAirTemp)},
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
                    'Mixed Air Temperature',
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
                        // Known room volume
                        Visibility(
                          visible: standard,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                                RegExp(r'^\d+\.?\d{0,1}')),
                                          ],
                                          controller: _raPercent,
                                          onChanged: (value) {
                                            _calculate();
                                          },
                                          keyboardType: const TextInputType
                                                  .numberWithOptions(
                                              signed: true, decimal: true),
                                          cursorColor: Colors.white,
                                          style: const TextStyle(
                                              color: Colors.white),
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
                                            labelText: 'Return Air %',
                                            hintText: 'Enter % of RA',
                                            focusColor: Colors.white,
                                            labelStyle: const TextStyle(
                                                color: Colors.white),
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
                                                RegExp(r'^-?\d*\.?\d{0,1}')),
                                          ],
                                          controller: _raTemp,
                                          onChanged: (value) {
                                            _calculate();
                                          },
                                          keyboardType: const TextInputType
                                                  .numberWithOptions(
                                              signed: true, decimal: true),
                                          cursorColor: Colors.white,
                                          style: const TextStyle(
                                              color: Colors.white),
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
                                            hintText: 'Enter RA temp',
                                            focusColor: Colors.white,
                                            labelStyle: const TextStyle(
                                                color: Colors.white),
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                                RegExp(r'^\d+\.?\d{0,1}')),
                                          ],
                                          controller: _oaPercent,
                                          onChanged: (value) {
                                            _calculate();
                                          },
                                          keyboardType: const TextInputType
                                                  .numberWithOptions(
                                              signed: true, decimal: true),
                                          cursorColor: Colors.white,
                                          style: const TextStyle(
                                              color: Colors.white),
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
                                            labelText: 'Outside Air %',
                                            hintText: 'Enter % OA',
                                            focusColor: Colors.white,
                                            labelStyle: const TextStyle(
                                                color: Colors.white),
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
                                                RegExp(r'^-?\d*\.?\d{0,1}')),
                                          ],
                                          controller: _oaTemp,
                                          onChanged: (value) {
                                            _calculate();
                                          },
                                          keyboardType: const TextInputType
                                                  .numberWithOptions(
                                              signed: true, decimal: true),
                                          cursorColor: Colors.white,
                                          style: const TextStyle(
                                              color: Colors.white),
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
                                            labelText: 'OA Temp °C',
                                            hintText: 'Enter OA Temp',
                                            focusColor: Colors.white,
                                            labelStyle: const TextStyle(
                                                color: Colors.white),
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
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Calculated Mixed Air Temperature: ',
                            style: TextStyle(color: Color(0xFFffffff)),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
                          child: AbsorbPointer(
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: _mixedAirTempAnswer,
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
                    ))),
          ],
        ));
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: ColorConstants.lightScaffoldBackgroundColor,
          child: Container(
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
                        r'T_ma = (\%_oa \times T_oa) + (\%_ra \times T_ra)',
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
    var str = ' °C';
    if (_oaTemp.text.trim().isNotEmpty &&
        _oaPercent.text.trim().isNotEmpty &&
        _raPercent.text.trim().isNotEmpty &&
        _raTemp.text.trim().isNotEmpty) {
      final outsideT = double.parse(_oaTemp.text);
      final outsideP = double.parse(_oaPercent.text);
      final returnT = double.parse(_raTemp.text);
      final returnP = double.parse(_raPercent.text);

      final oa = (outsideP / 100) * outsideT;
      final ra = (returnP / 100) * returnT;

      _mixedAirTempAnswer.text = (oa + ra).toStringAsFixed(1) + str;
    }
  }
}
