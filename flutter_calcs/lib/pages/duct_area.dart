import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calcs/widgets/add_button.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'dart:math' as math;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_calcs/constants/constants.dart';
import 'package:flutter_calcs/widgets/custom_drawer.dart';

import '../constants/color_constants.dart';
import '../database/db.dart';

class Equations {
  final String eq;
  final String eqTitle;

  const Equations({required this.eq, required this.eqTitle});
}

class DuctArea extends StatefulWidget {
  const DuctArea({
    Key? key,
  }) : super(key: key);

  @override
  State<DuctArea> createState() => _DuctAreaState();
}

class _DuctAreaState extends State<DuctArea> {
  FirebaseServices firebaseServices = FirebaseServices();

  String title = 'Duct Area';
  late PageController _pageController;

  List<Equations> eqs = [
    const Equations(
        eqTitle: 'Rectangle/Square Area', eq: r'Area = HT \times WD'),
    const Equations(
        eqTitle: 'Round Area', eq: r'Area = \pi\times(\frac{d}{2})^2'),
    const Equations(
        eqTitle: 'Flat Oval Area',
        eq: r'Area = (HT\times(WD-HT)+(\pi\times(\frac{HT}{2})^2))')
  ];
  final TextEditingController _rectWidthController = TextEditingController();
  final TextEditingController _rectHeightController = TextEditingController();
  final TextEditingController _rectCalcController = TextEditingController();
  final TextEditingController _roundController = TextEditingController();
  final TextEditingController _roundCalcController = TextEditingController();
  final TextEditingController _flatWidthController = TextEditingController();
  final TextEditingController _flatHeightController = TextEditingController();
  final TextEditingController _flatCalcController = TextEditingController();
  bool _displayRecTextField = true;
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
                    child: const Text('Duct Area'),
                    onPressed: () => {Navigator.pushNamed(context, ductArea)},
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
                  'DUCT AREA',
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
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Expanded(
                            child: MaterialButton(
                          onPressed: () async {
                            setState(() {
                              _displayRecTextField = true;
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
                            });
                          },
                          child: const Text("Flat Oval"),
                          color: _displayFlatTextField
                              ? Color(0xFF3b82f6)
                              : ColorConstants.secondaryDarkAppColor,
                          textColor: Colors.white,
                        )),
                      ],
                    ),
                  ),

                  //Rectangle
                  Visibility(
                    visible: _displayRecTextField,
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
                            controller: _rectWidthController,
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
                              labelText: 'Width (mm)',
                              hintText: 'Enter width [in mm]',
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
                            controller: _rectHeightController,
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
                              labelText: 'Height (mm)',
                              hintText: 'Enter height [in mm]',
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

                  //  Round duct
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
                                    color: const Color(0xFFcbd5e1)),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
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
                              controller: _roundCalcController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
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

                  //  Flat oval duct

                  Visibility(
                    visible: _displayFlatTextField,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
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
                              labelText: 'Width (mm)',
                              hintText: 'Enter width [in mm]',
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
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
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
                              labelText: 'Height (mm)',
                              hintText: 'Enter height [in mm]',
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
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor: ColorConstants.lightScaffoldBackgroundColor,
            child: Container(
              height: 300.0, // Change as per your requirement
              width: 500.0, // Change as per your requirement
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      pageSnapping: true,
                      itemCount: eqs.length,
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        final titles = eqs[index];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    titles.eqTitle,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Math.tex(
                                    titles.eq,
                                    mathStyle: MathStyle.display,
                                    textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SmoothPageIndicator(
                      controller: _pageController, // PageController
                      count: eqs.length,
                      effect: const WormEffect(
                          activeDotColor: ColorConstants
                              .messageColor), // your preferred effect
                      onDotClicked: (index) {})
                ],
              ),
            ),
          ));

  void _calculate() {
    String? str1 = ' m²';

    if (_rectWidthController.text.trim().isNotEmpty &&
        _rectHeightController.text.trim().isNotEmpty) {
      final firstValue = double.parse(_rectWidthController.text);
      final secondValue = double.parse(_rectHeightController.text);
      _rectCalcController.text =
          (firstValue * secondValue / 1000000).toStringAsFixed(4) + str1;
    }
    if (_roundController.text.trim().isNotEmpty) {
      final firstValue = double.parse(_roundController.text);
      final divide = (firstValue / 2);
      final power = math.pow(divide, 2) * math.pi;
      _roundCalcController.text = (power / 1000000).toStringAsFixed(4) + str1;
    }
    if (_flatHeightController.text.trim().isNotEmpty &&
        _flatWidthController.text.trim().isNotEmpty) {
      final firstValue = double.parse(_flatHeightController.text);
      final secondValue = double.parse(_flatWidthController.text);
      final divide = (firstValue / 2);
      final power = math.pow(divide, 2) * math.pi;
      final subtract = (secondValue - firstValue) * firstValue;
      final addition = (subtract + power) / 1000000;
      _flatCalcController.text = addition.toStringAsFixed(4) + str1;
    }
  }
}
