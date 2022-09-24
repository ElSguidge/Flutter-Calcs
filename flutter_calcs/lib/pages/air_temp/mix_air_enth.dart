import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import 'package:flutter_calcs/constants/color_constants.dart';
import 'package:flutter_calcs/database/db.dart';
import 'package:flutter_calcs/widgets/add_button.dart';
import 'package:flutter_calcs/widgets/custom_drawer.dart';

import '../../widgets/pagination.dart';

class MixedAirEnthalpy extends StatefulWidget {
  const MixedAirEnthalpy({Key? key}) : super(key: key);

  @override
  State<MixedAirEnthalpy> createState() => _MixedAirEnthalpyState();
}

class _MixedAirEnthalpyState extends State<MixedAirEnthalpy> {
  bool standard = true;
  FirebaseServices firebaseServices = FirebaseServices();

  String title = 'Enthalpy of Mixed Air';

  final TextEditingController _oaPercent = TextEditingController();
  final TextEditingController _oaEnth = TextEditingController();
  final TextEditingController _raPercent = TextEditingController();
  final TextEditingController _raEnth = TextEditingController();
  final TextEditingController _mixedAirEnthAnswer = TextEditingController();
  final TextEditingController _enthTempCalc = TextEditingController();
  final TextEditingController _enthTotalAnswer = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _oaPercent.dispose();
    _oaEnth.dispose();
    _raPercent.dispose();
    _raEnth.dispose();
    _mixedAirEnthAnswer.dispose();
    _enthTempCalc.dispose();
    _enthTotalAnswer.dispose();
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
                    title: 'Mixed Air Enth..',
                    nav: 'mixedAirTempEnthalpy',
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
                    'Enthalpy of Mixed Air',
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
                            padding: const EdgeInsets.only(top: 15.0),
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
                                                RegExp(r'^\d+\.?\d{0,1}')),
                                          ],
                                          controller: _raEnth,
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
                                            labelText: 'RA Enthalpy (kJ/kg)',
                                            hintText: 'RA enthalpy',
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15.0, bottom: 15.0),
                                  child: Row(
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
                                            inputFormatters: <
                                                TextInputFormatter>[
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
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'^\d+\.?\d{0,1}')),
                                            ],
                                            controller: _oaEnth,
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
                                              labelText: 'OA Enthalpy (kJ/kg)',
                                              hintText: 'OA Enthalpy',
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
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            minWidth: 5,
                            color: ColorConstants.lightBlue,
                            textColor: Colors.white,
                            child: const Text(
                                'Help me calculate the enthalpy of air'),
                            onPressed: () => showModalBottomSheet<void>(
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) {
                                return FractionallySizedBox(
                                  heightFactor: 0.8,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(27.0),
                                        topLeft: Radius.circular(27.0)),
                                    child: Container(
                                      // height:
                                      //     MediaQuery.of(context).size.height,
                                      color:
                                          ColorConstants.secondaryDarkAppColor,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // mainAxisAlignment:
                                              //     MainAxisAlignment.spaceAround,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                    top: 30.0,
                                                    left: 60.0,
                                                    right: 60.0,
                                                  ),
                                                ),
                                                const Center(
                                                  child: Text(
                                                    'Calculate the enthalpy of air',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                                Row(
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  children: [
                                                    Flexible(
                                                      // optional flex property if flex is 1 because the default flex is 1
                                                      flex: 1,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                80.0,
                                                                15.0,
                                                                80.0,
                                                                20.0),
                                                        child: TextFormField(
                                                          textAlign:
                                                              TextAlign.center,
                                                          inputFormatters: <
                                                              TextInputFormatter>[
                                                            FilteringTextInputFormatter
                                                                .allow(RegExp(
                                                                    r'^-?\d*\.?\d{0,2}')),
                                                          ],
                                                          controller:
                                                              _enthTempCalc,
                                                          onChanged: (value) {
                                                            _calculateEnth();
                                                          },
                                                          keyboardType:
                                                              const TextInputType
                                                                      .numberWithOptions(
                                                                  signed: true,
                                                                  decimal:
                                                                      true),
                                                          cursorColor:
                                                              Colors.white,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          decoration:
                                                              InputDecoration(
                                                            hintStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white70),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            filled: true,
                                                            fillColor:
                                                                ColorConstants
                                                                    .lightScaffoldBackgroundColor,
                                                            labelText:
                                                                'Enter Temp °C',
                                                            hintText:
                                                                'Enter temperature',
                                                            focusColor:
                                                                Colors.white,
                                                            labelStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      // ignore: unnecessary_const
                                                                      color: Colors
                                                                          .white60),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Center(
                                                  child: Text(
                                                    'Total atmospheric enthalpy: ',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFffffff)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          80.0,
                                                          15.0,
                                                          80.0,
                                                          30.0),
                                                  child: AbsorbPointer(
                                                    child: TextField(
                                                      textAlign:
                                                          TextAlign.center,
                                                      controller:
                                                          _enthTotalAnswer,
                                                      keyboardType:
                                                          const TextInputType
                                                                  .numberWithOptions(
                                                              signed: true,
                                                              decimal: true),
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                      decoration:
                                                          InputDecoration(
                                                        hintStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white70),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .white),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        filled: true,
                                                        fillColor: ColorConstants
                                                            .lightScaffoldBackgroundColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // ElevatedButton(
                                          //   child: const Text('Close BottomSheet'),
                                          //   onPressed: () => Navigator.pop(context),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            splashColor: const Color(0xFFa78bfa),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Calculated Enthalpy of Mixed Air: ',
                            style: TextStyle(color: Color(0xFFffffff)),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
                          child: AbsorbPointer(
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: _mixedAirEnthAnswer,
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
                        r'h_ma = (\%_oa \times h_oa) + (\%_ra \times h_ra)',
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
    var str = ' kJ/kg';
    if (_raEnth.text.trim().isNotEmpty &&
        _oaPercent.text.trim().isNotEmpty &&
        _raPercent.text.trim().isNotEmpty &&
        _oaEnth.text.trim().isNotEmpty) {
      final outsideT = double.parse(_oaEnth.text);
      final outsideP = double.parse(_oaPercent.text);
      final returnT = double.parse(_raEnth.text);
      final returnP = double.parse(_raPercent.text);

      final oa = (outsideP / 100) * outsideT;
      final ra = (returnP / 100) * returnT;

      _mixedAirEnthAnswer.text = (oa + ra).toStringAsFixed(2) + str;
    }
  }

  void _calculateEnth() {
    var str = ' kJ/kg';
    print(_enthTempCalc.text);
    // final enthTempInputCalc = double.parse(_enthTempCalc.text);
    if (_enthTempCalc.text.trim().isNotEmpty) {
      final enthTempInputCalc = double.parse(_enthTempCalc.text);
      final airEnth = (1.007 * enthTempInputCalc) - 0.026;

      final vapor = (2501 + 1.84 * enthTempInputCalc) * 0.01;
      _enthTotalAnswer.text = (airEnth + vapor).toStringAsFixed(3) + str;
    }
  }
}
