import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calcs/constants/constants.dart'; // import 'package:provider/provider.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'dart:math' as math;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Equations {
  final String eq;
  final String eqTitle;

  const Equations({required this.eq, required this.eqTitle});
}

// class Calculator {
//   final String name;
//   final String subtitle;
//   final String route;

//   const Calculator({required this.name, required this.subtitle, required this.route});
// }

class DuctArea extends StatefulWidget {
  const DuctArea({
    Key? key,
  }) : super(key: key);

  @override
  State<DuctArea> createState() => _DuctAreaState();
}

class _DuctAreaState extends State<DuctArea> {
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
  int get index => 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    // var favoritePage = context.watch<FavoritePageModel>();

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
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              const DrawerHeader(
                child: Center(
                  child: Image(
                    image: AssetImage('lib/icons/cropped-AGC_Logo_2022.png'),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pushNamed(context, homeRoute);
                },
              ),
              ListTile(
                leading: const Icon(Icons.build),
                title: const Text('Install'),
                onTap: () {
                  Navigator.pushNamed(context, installHome);
                },
              ),
              ListTile(
                leading: const Icon(Icons.assignment_turned_in_sharp),
                title: const Text('Commissioning'),
                onTap: () {
                  Navigator.pushNamed(context, commissioningHome);
                },
              ),
            ],
          ),
        ),
      ),
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
                  // favoritePage.items[index].name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Expanded(child: AddButton(calculator:calculator)),
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
                          color:
                              _displayRecTextField ? Colors.blue : Colors.black,
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
                              ? Colors.blue
                              : Colors.black,
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
                              ? Colors.blue
                              : Colors.black,
                          textColor: Colors.white,
                        )),
                      ],
                    ),
                  ),

                  //Rectangle
                  Visibility(
                    visible: _displayRecTextField,
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
                      child: Container(
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
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            filled: true,
                            fillColor: const Color(0xFF64748b),
                            labelText: 'Width',
                            hintText: 'Enter width [in mm]',
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
                  ),
                  Visibility(
                    visible: _displayRecTextField,
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
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
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF64748b),
                          labelText: 'Height',
                          hintText: 'Enter height [in mm]',
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

                  //  Round duct
                  Visibility(
                    visible: _displayRoundTextField,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
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
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF64748b),
                          labelText: 'Diameter',
                          hintText: 'Enter Diameter [in mm]',
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

                  //  Flat oval duct

                  Visibility(
                    visible: _displayFlatTextField,
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
                      child: Container(
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
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            filled: true,
                            fillColor: const Color(0xFF64748b),
                            labelText: 'Width',
                            hintText: 'Enter width [in mm]',
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
                  ),
                  Visibility(
                    visible: _displayFlatTextField,
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
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
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF64748b),
                          labelText: 'Height',
                          hintText: 'Enter height [in mm]',
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
                  Container(
                    child: const Text(
                      'Calculated Duct Area: ',
                      style: TextStyle(color: Color(0xFFffffff)),
                    ),
                  ),
                  Visibility(
                    visible: _displayRecTextField,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 30.0),
                      child: AbsorbPointer(
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: _rectCalcController,
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
                  ),
                  Visibility(
                    visible: _displayRoundTextField,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 30.0),
                      child: AbsorbPointer(
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: _roundCalcController,
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
                  ),
                  Visibility(
                    visible: _displayFlatTextField,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 30.0),
                      child: AbsorbPointer(
                        child: TextField(
                          textAlign: TextAlign.center,
                          controller: _flatCalcController,
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
            backgroundColor: const Color(0xFF64748b),
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
                      effect: const WormEffect(), // your preferred effect
                      onDotClicked: (index) {})
                ],
              ),
            ),
          ));

  void _calculate() {
    String? str1 = ' m2';

    if (_rectWidthController.text.trim().isNotEmpty &&
        _rectHeightController.text.trim().isNotEmpty) {
      final firstValue = double.parse(_rectWidthController.text);
      final secondValue = double.parse(_rectHeightController.text);
      _rectCalcController.text =
          (firstValue * secondValue / 1000000).toString() + str1;
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
