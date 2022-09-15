import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calcs/database/db.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:math' as math;

import '../constants/color_constants.dart';
import '../constants/constants.dart';
import '../widgets/add_button.dart';
import '../widgets/custom_drawer.dart';

class Equations {
  final String eq;
  final String eqTitle;

  const Equations({required this.eq, required this.eqTitle});
}

class AirTempConvert extends StatefulWidget {
  const AirTempConvert({Key? key}) : super(key: key);

  @override
  State<AirTempConvert> createState() => _AirTempConvertState();
}

class _AirTempConvertState extends State<AirTempConvert> {
  FirebaseServices firebaseServices = FirebaseServices();

  List<Equations> eqs = [
    const Equations(
        eqTitle: 'Celsius', eq: r'\degree C = (\degree F - 32) \div 1.8'),
    const Equations(
        eqTitle: 'Fahrenheit', eq: r'\degree F = (\degree C \times 1.8) + 32'),
    const Equations(eqTitle: 'Rankine', eq: r'\degree R = (\degree F + 460)'),
    const Equations(eqTitle: 'Kelvin', eq: r'K = (\degree C + 273)')
  ];

  String title = 'Convert (°F, °C, R, K)';
  late PageController _pageController;

  final TextEditingController _tempInputController = TextEditingController();
  final TextEditingController _tempAnswerController = TextEditingController();

  bool _isCelcius = true;
  bool _isFahrenheit = false;
  bool _isR = false;
  bool _isK = false;

  bool _isCelcius1 = true;
  bool _isFahrenheit1 = false;
  bool _isR1 = false;
  bool _isK1 = false;

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
                    child: const Text('Air Temp.'),
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
                    child: const Text('Convert..'),
                    onPressed: () =>
                        {Navigator.pushNamed(context, airTempConvert)},
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
                  'CONVERT \n(°F, °C, R, K)',
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
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
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
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Expanded(
                            child: MaterialButton(
                          onPressed: () async {
                            setState(() {
                              _isCelcius = true;
                              _isFahrenheit = false;
                              _isR = false;
                              _isK = false;
                              _calculate();
                            });
                          },
                          child: const Text("°C"),
                          color: _isCelcius
                              ? const Color(0xFF3b82f6)
                              : ColorConstants.secondaryDarkAppColor,
                          textColor: Colors.white,
                        )),
                        Expanded(
                            child: MaterialButton(
                          onPressed: () async {
                            setState(() {
                              _isFahrenheit = true;
                              _isCelcius = false;
                              _isR = false;
                              _isK = false;
                              _calculate();
                            });
                          },
                          child: const Text("°F"),
                          color: _isFahrenheit
                              ? const Color(0xFF3b82f6)
                              : ColorConstants.secondaryDarkAppColor,
                          textColor: Colors.white,
                        )),
                        Expanded(
                            child: MaterialButton(
                          onPressed: () async {
                            setState(() {
                              _isCelcius = false;
                              _isR = true;
                              _isK = false;
                              _isFahrenheit = false;
                              _calculate();
                            });
                          },
                          child: const Text("R"),
                          color: _isR
                              ? const Color(0xFF3b82f6)
                              : ColorConstants.secondaryDarkAppColor,
                          textColor: Colors.white,
                        )),
                        Expanded(
                            child: MaterialButton(
                          onPressed: () async {
                            setState(() {
                              _isCelcius = false;
                              _isFahrenheit = false;
                              _isK = true;
                              _isR = false;
                              _calculate();
                            });
                          },
                          child: const Text("K"),
                          color: _isK
                              ? const Color(0xFF3b82f6)
                              : ColorConstants.secondaryDarkAppColor,
                          textColor: Colors.white,
                        )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,3}')),
                      ],
                      controller: _tempInputController,
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
                        labelText: 'Enter  temp',
                        hintText: 'Temperature',
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
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Expanded(
                            child: MaterialButton(
                          onPressed: () async {
                            setState(() {
                              _isCelcius1 = true;
                              _isFahrenheit1 = false;
                              _isR1 = false;
                              _isK1 = false;
                              _calculate();
                            });
                          },
                          child: const Text("°C"),
                          color: _isCelcius1
                              ? const Color(0xFF3b82f6)
                              : ColorConstants.secondaryDarkAppColor,
                          textColor: Colors.white,
                        )),
                        Expanded(
                            child: MaterialButton(
                          onPressed: () async {
                            setState(() {
                              _isFahrenheit1 = true;
                              _isCelcius1 = false;
                              _isR1 = false;
                              _isK1 = false;
                              _calculate();
                            });
                          },
                          child: const Text("°F"),
                          color: _isFahrenheit1
                              ? const Color(0xFF3b82f6)
                              : ColorConstants.secondaryDarkAppColor,
                          textColor: Colors.white,
                        )),
                        Expanded(
                            child: MaterialButton(
                          onPressed: () async {
                            setState(() {
                              _isCelcius1 = false;
                              _isR1 = true;
                              _isK1 = false;
                              _isFahrenheit1 = false;
                              _calculate();
                            });
                          },
                          child: const Text("R"),
                          color: _isR1
                              ? const Color(0xFF3b82f6)
                              : ColorConstants.secondaryDarkAppColor,
                          textColor: Colors.white,
                        )),
                        Expanded(
                            child: MaterialButton(
                          onPressed: () async {
                            setState(() {
                              _isCelcius1 = false;
                              _isFahrenheit1 = false;
                              _isK1 = true;
                              _isR1 = false;
                              _calculate();
                            });
                          },
                          child: const Text("K"),
                          color: _isK1
                              ? const Color(0xFF3b82f6)
                              : ColorConstants.secondaryDarkAppColor,
                          textColor: Colors.white,
                        )),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 20.0, 20.0, 5.0),
                    child: Text(
                      "Converted temperature: ",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
                    child: AbsorbPointer(
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: _tempAnswerController,
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
    if (_tempInputController.text.trim().isNotEmpty) {
      final tempInput = double.parse(_tempInputController.text);
      if (_isCelcius == true && _isCelcius1 == true) {
        final celcius = tempInput;
        _tempAnswerController.text = celcius.toStringAsFixed(1) + ' °C';
      }
      if (_isCelcius == true && _isFahrenheit1 == true) {
        final celcius = (tempInput * 1.8) + 32;
        _tempAnswerController.text = celcius.toStringAsFixed(1) + ' °F';
      }
      if (_isCelcius == true && _isR1 == true) {
        final fahrenheit = (tempInput * 1.8) + 32;
        final r = fahrenheit + 460;
        _tempAnswerController.text = r.toStringAsFixed(1) + ' °R';
      }
      if (_isCelcius == true && _isK1 == true) {
        final k = tempInput + 273;
        _tempAnswerController.text = k.toStringAsFixed(1) + ' K';
      }
      if (_isFahrenheit == true && _isFahrenheit1 == true) {
        final f = tempInput;
        _tempAnswerController.text = f.toStringAsFixed(1) + ' °F';
      }
      if (_isFahrenheit == true && _isCelcius1 == true) {
        final celcius1 = (tempInput - 32) / 1.8;
        _tempAnswerController.text = celcius1.toStringAsFixed(1) + ' °C';
      }
      if (_isFahrenheit == true && _isR1 == true) {
        final r1 = tempInput + 460;
        _tempAnswerController.text = r1.toStringAsFixed(1) + ' °R';
      }
      if (_isFahrenheit == true && _isK1 == true) {
        final c = (tempInput - 32) / 1.8;
        final k1 = c + 273;
        _tempAnswerController.text = k1.toStringAsFixed(1) + ' K';
      }
      if (_isR == true && _isR1 == true) {
        final rR = tempInput;
        _tempAnswerController.text = rR.toStringAsFixed(1) + ' °R';
      }
      if (_isR == true && _isCelcius1 == true) {
        final rC = (tempInput - 491.67) * 5 / 9;
        _tempAnswerController.text = rC.toStringAsFixed(1) + ' °C';
      }
      if (_isR == true && _isFahrenheit1 == true) {
        final rF = tempInput - 459.67;
        _tempAnswerController.text = rF.toStringAsFixed(1) + ' °F';
      }
      if (_isR == true && _isK1 == true) {
        final rK = tempInput * 5 / 9;
        _tempAnswerController.text = rK.toStringAsFixed(1) + ' K';
      }
      if (_isK == true && _isK1 == true) {
        final kK = tempInput;
        _tempAnswerController.text = kK.toStringAsFixed(1) + ' K';
      }

      if (_isK == true && _isCelcius1 == true) {
        final kC = (tempInput - 273.15);
        _tempAnswerController.text = kC.toStringAsFixed(1) + ' °C';
      }
      if (_isK == true && _isFahrenheit1 == true) {
        final kF = (tempInput - 273.15) * 9 / 5 + 32;
        _tempAnswerController.text = kF.toStringAsFixed(1) + ' °F';
      }
      if (_isK == true && _isR1 == true) {
        final rK = tempInput * 1.8;
        _tempAnswerController.text = rK.toStringAsFixed(1) + ' °R';
      }
    }
  }
}
