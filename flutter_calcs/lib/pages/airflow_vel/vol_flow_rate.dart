import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calcs/constants/color_constants.dart';
import 'package:flutter_calcs/widgets/add_button.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'dart:math' as math;
import 'package:flutter_calcs/constants/constants.dart';
import 'package:flutter_calcs/widgets/custom_drawer.dart';

import '../../database/db.dart';

class VolFlowRate extends StatefulWidget {
  const VolFlowRate({Key? key}) : super(key: key);

  @override
  State<VolFlowRate> createState() => _VolFlowRateState();
}

class _VolFlowRateState extends State<VolFlowRate> {
  FirebaseServices firebaseServices = FirebaseServices();

  String title = 'Volumetric Flow Rate (Q)';
  late PageController _pageController;

  final TextEditingController _rectWidthController = TextEditingController();
  final TextEditingController _rectHeightController = TextEditingController();
  final TextEditingController _rectCalcController = TextEditingController();
  final TextEditingController _rectCalcControllerQ = TextEditingController();

  final TextEditingController _roundController = TextEditingController();
  final TextEditingController _roundCalcController = TextEditingController();
  final TextEditingController _roundCalcControllerQ = TextEditingController();

  final TextEditingController _flatWidthController = TextEditingController();
  final TextEditingController _flatHeightController = TextEditingController();
  final TextEditingController _flatCalcController = TextEditingController();
  final TextEditingController _flatCalcControllerQ = TextEditingController();

  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _areaCalcController = TextEditingController();

  final TextEditingController _velController = TextEditingController();
  final TextEditingController _velCalcController = TextEditingController();

  bool _displayAreaTextField = true;
  bool _displayRecTextField = false;
  bool _displayRoundTextField = false;
  bool _displayFlatTextField = false;

  @override
  void initState() {
    _pageController = PageController();
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
                    child: const Text('Airflow &..'),
                    onPressed: () => {Navigator.pushNamed(context, airflowVel)},
                    splashColor: const Color(0xFFa78bfa),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(3.0, 5.0, 0.0, 5.0),
                  child: MaterialButton(
                    minWidth: 5,
                    color: ColorConstants.messageColor,
                    textColor: Colors.white,
                    child: const Text('Vol. Flow..'),
                    onPressed: () =>
                        {Navigator.pushNamed(context, volFlowRate)},
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
                  'VOLUMETRIC FLOW RATE (Q)',
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
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: ColorConstants.secondaryDarkAppColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,3}')),
                        ],
                        controller: _velController,
                        onChanged: (value) {
                          _calculate();
                        },
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          filled: true,
                          fillColor:
                              ColorConstants.lightScaffoldBackgroundColor,
                          labelText: 'Enter  Air Velocity (V)',
                          hintText: 'Enter velocity [in m/s]',
                          focusColor: Colors.white,
                          labelStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              // ignore: unnecessary_const
                              color: Colors.white60,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),

                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Expanded(
                            child: MaterialButton(
                          onPressed: () async {
                            setState(() {
                              _displayAreaTextField = true;
                              _displayRecTextField = false;
                              _displayRoundTextField = false;
                              _displayFlatTextField = false;
                            });
                          },
                          child: const Text("Area"),
                          color: _displayAreaTextField
                              ? Color(0xFF3b82f6)
                              : ColorConstants.secondaryDarkAppColor,
                          textColor: Colors.white,
                        )),
                        Expanded(
                            child: MaterialButton(
                          onPressed: () async {
                            setState(() {
                              _displayRecTextField = true;
                              _displayAreaTextField = false;
                              _displayRoundTextField = false;
                              _displayFlatTextField = false;
                            });
                          },
                          child: const Text("Rect"),
                          color: _displayRecTextField
                              ? Color(0xFF3b82f6)
                              : ColorConstants.secondaryDarkAppColor,
                          textColor: Colors.white,
                        )),
                        Expanded(
                            child: MaterialButton(
                          onPressed: () async {
                            setState(() {
                              _displayRecTextField = false;
                              _displayRoundTextField = true;
                              _displayFlatTextField = false;
                              _displayAreaTextField = false;
                            });
                          },
                          child: const Text("Round"),
                          color: _displayRoundTextField
                              ? Color(0xFF3b82f6)
                              : ColorConstants.secondaryDarkAppColor,
                          textColor: Colors.white,
                        )),
                        Expanded(
                            child: MaterialButton(
                          onPressed: () async {
                            setState(() {
                              _displayRecTextField = false;
                              _displayRoundTextField = false;
                              _displayFlatTextField = true;
                              _displayAreaTextField = false;
                            });
                          },
                          child: const Text("Oval"),
                          color: _displayFlatTextField
                              ? Color(0xFF3b82f6)
                              : ColorConstants.secondaryDarkAppColor,
                          textColor: Colors.white,
                        )),
                      ],
                    ),
                  ),
                  //Area known
                  Visibility(
                    visible: _displayAreaTextField,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,4}')),
                            ],
                            controller: _areaController,
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
                              labelText: 'Enter known area (m²)',
                              hintText: 'Enter area [in m²]',
                              focusColor: Colors.white,
                              labelStyle: const TextStyle(
                                color: Colors.white,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  // ignore: unnecessary_const
                                  color: Colors.white60,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Calculated Flow Rate (Q): ",
                          style: TextStyle(color: Colors.white),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
                          child: AbsorbPointer(
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: _velCalcController,
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

                  //Rectangle with height added
                  Visibility(
                    visible: _displayRecTextField,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+\.?\d{0,1}')),
                                  ],
                                  controller: _rectWidthController,
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
                                    fillColor: ColorConstants
                                        .lightScaffoldBackgroundColor,
                                    labelText: 'Width(mm)',
                                    hintText: 'Width [in mm]',
                                    focusColor: Colors.white,
                                    labelStyle:
                                        const TextStyle(color: Colors.white),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          // ignore: unnecessary_const
                                          color: Colors.white60),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20.0),
                            Expanded(
                              // optional flex property if flex is 1 because the default flex is 1
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+\.?\d{0,1}')),
                                  ],
                                  controller: _rectHeightController,
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
                                    fillColor: ColorConstants
                                        .lightScaffoldBackgroundColor,
                                    labelText: 'Height(mm)',
                                    hintText: 'Height [in mm]',
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
                        const Text(
                          "Calculated area (A): ",
                          style: TextStyle(color: Colors.white),
                        ),
                        //here
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
                          child: AbsorbPointer(
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: _rectCalcController,
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
                        const Text(
                          "Calculated Flow Rate (Q): ",
                          style: TextStyle(color: Colors.white),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
                          child: AbsorbPointer(
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: _rectCalcControllerQ,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintStyle:
                                    const TextStyle(color: Colors.white70),
                                border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white60),
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

                  //Round
                  Visibility(
                    visible: _displayRoundTextField,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,1}')),
                            ],
                            controller: _roundController,
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
                              labelText: 'Diameter (mm)',
                              hintText: 'Enter Diameter [in mm]',
                              focusColor: Colors.white,
                              labelStyle: const TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    // ignore: unnecessary_const
                                    color: Colors.white60),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                        //here
                        const Text(
                          "Calculated area (A): ",
                          style: TextStyle(color: Colors.white),
                        ),
                        //here
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
                          child: AbsorbPointer(
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: _roundCalcController,
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
                        const Text(
                          "Calculated Flow Rate (Q): ",
                          style: TextStyle(color: Colors.white),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
                          child: AbsorbPointer(
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: _roundCalcControllerQ,
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
                  //  Flat oval duct with height added
                  Visibility(
                    visible: _displayFlatTextField,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+\.?\d{0,1}')),
                                  ],
                                  controller: _flatWidthController,
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
                                    fillColor: ColorConstants
                                        .lightScaffoldBackgroundColor,
                                    labelText: 'Width(mm)',
                                    hintText: 'Width [in mm]',
                                    focusColor: Colors.white,
                                    labelStyle:
                                        const TextStyle(color: Colors.white),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          // ignore: unnecessary_const
                                          color: Colors.white60),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20.0),
                            Expanded(
                              // optional flex property if flex is 1 because the default flex is 1
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+\.?\d{0,1}')),
                                  ],
                                  controller: _flatHeightController,
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
                                    fillColor: ColorConstants
                                        .lightScaffoldBackgroundColor,
                                    labelText: 'Height(mm)',
                                    hintText: 'Height [in mm]',
                                    focusColor: Colors.white,
                                    labelStyle:
                                        const TextStyle(color: Colors.white),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          // ignore: unnecessary_const
                                          color: Colors.white60),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          "Calculated area (A): ",
                          style: TextStyle(color: Colors.white),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
                          child: AbsorbPointer(
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: _flatCalcController,
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
                        const Text(
                          "Calculated Flow Rate (Q): ",
                          style: TextStyle(color: Colors.white),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
                          child: AbsorbPointer(
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: _flatCalcControllerQ,
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
          child: Container(
            height: 100.0, // Change as per your requirement
            width: 500.0, // Change as per your requirement
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Math.tex(
                    r'Q = V \times A',
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
    String? str1 = 'm²';
    // String? str2 = 'Q = ';

    if (_rectWidthController.text.trim().isNotEmpty &&
        _rectHeightController.text.trim().isNotEmpty) {
      final firstValue = double.parse(_rectWidthController.text);
      final secondValue = double.parse(_rectHeightController.text);
      _rectCalcController.text =
          (firstValue * secondValue / 1000000).toStringAsFixed(4) + ' ' + str1;
      if (_rectCalcController.text.isNotEmpty &&
          _velController.text.trim().isNotEmpty) {
        final findQ = double.parse(_velController.text);
        _rectCalcControllerQ.text =
            ((firstValue * secondValue * findQ) / 1000).toStringAsFixed(1) +
                ' ' +
                'l/s';
      }
    }
    if (_roundController.text.trim().isNotEmpty) {
      final firstValue = double.parse(_roundController.text);
      final divide = (firstValue / 2);
      final power = math.pow(divide, 2) * math.pi;
      _roundCalcController.text =
          (power / 1000000).toStringAsFixed(4) + ' ' + str1;
      if (_roundController.text.isNotEmpty &&
          _velController.text.trim().isNotEmpty) {
        final findQ = double.parse(_velController.text);
        _roundCalcControllerQ.text =
            (power / 1000 * findQ).toStringAsFixed(2) + ' ' + 'l/s';
      }
    }
    if (_areaController.text.trim().isNotEmpty) {
      _areaCalcController.text = _areaController.text + str1;
      if (_areaController.text.trim().isNotEmpty &&
          _velController.text.trim().isNotEmpty) {
        final firstValue = double.parse(_areaController.text);
        final second = double.parse(_velController.text);
        final findQ = (firstValue * 1000) * second;
        _velCalcController.text = findQ.toStringAsFixed(1) + ' ' + 'l/s';
      }
    }
    if (_flatHeightController.text.trim().isNotEmpty &&
        _flatWidthController.text.trim().isNotEmpty) {
      final firstValue = double.parse(_flatHeightController.text);
      final secondValue = double.parse(_flatWidthController.text);
      final divide = (firstValue / 2);
      final power = math.pow(divide, 2) * math.pi;
      final subtract = (secondValue - firstValue) * firstValue;
      final addition = (subtract + power) / 1000000;
      _flatCalcController.text = addition.toStringAsFixed(4) + ' ' + str1;
      if (_flatCalcController.text.isNotEmpty &&
          _velController.text.trim().isNotEmpty) {
        final findQ = double.parse(_velController.text);
        _flatCalcControllerQ.text =
            ((addition * findQ) * 1000).toStringAsFixed(1) + ' ' + 'l/s';
      }
    }
  }
}
