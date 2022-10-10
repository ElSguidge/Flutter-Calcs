import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calcs/database/db.dart';
import 'package:flutter_calcs/providers/air_temp_buttons.dart';
import 'package:flutter_calcs/widgets/answer_field.dart';
import 'package:flutter_calcs/widgets/formula_button.dart';
import 'package:flutter_calcs/widgets/header.dart';
import 'package:flutter_calcs/widgets/main_buttons.dart';
import 'package:flutter_calcs/widgets/text_fields.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constants/color_constants.dart';
import '../../widgets/add_button.dart';
import '../../widgets/custom_drawer.dart';
import '../../widgets/pagination.dart';
import 'bloc/air_temp/air_temp_bloc.dart';

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

  @override
  void initState() {
    super.initState();
    context.read<AirTempBloc>().add(InitialAirTempEvent());
    _tempInputController.addListener(_tempConvert);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _tempInputController.removeListener(_tempConvert);
    _tempAnswerController.dispose();
    super.dispose();
  }

  _tempConvert() {
    AirTempButtons active = Provider.of<AirTempButtons>(context, listen: false);
    if (_tempInputController.text.trim().isNotEmpty) {
      context.read<AirTempBloc>().add(Conversion(
          temp: double.parse(_tempInputController.text),
          isCelcius: active.isCelcius,
          isCelcius1: active.isCelcius1,
          isFahrenheit: active.isFahrenheit,
          isFahrenheit1: active.isFahrenheit1,
          isR: active.isR,
          isR1: active.isR1,
          isK1: active.isK1,
          isK: active.isK));
    }
  }

  @override
  Widget build(BuildContext context) {
    AirTempButtons convert =
        Provider.of<AirTempButtons>(context, listen: false);
    AirTempButtons active = Provider.of<AirTempButtons>(context);

    return BlocListener<AirTempBloc, AirTempState>(
      listener: (BuildContext context, AirTempState state) {
        if (state is AirTempDataState) {
          if (state.answer1 != null) {
            _tempAnswerController.text =
                state.answer1!.toStringAsFixed(1) + ' °C';
          }
          if (state.answer2 != null) {
            _tempAnswerController.text =
                state.answer2!.toStringAsFixed(1) + ' °F';
          }
          if (state.answer3 != null) {
            _tempAnswerController.text =
                state.answer3!.toStringAsFixed(1) + ' °R';
          }
          if (state.answer4 != null) {
            _tempAnswerController.text =
                state.answer4!.toStringAsFixed(1) + ' K';
          }
          if (state.answer5 != null) {
            _tempAnswerController.text =
                state.answer5!.toStringAsFixed(1) + ' °F';
          }
          if (state.answer6 != null) {
            _tempAnswerController.text =
                state.answer6!.toStringAsFixed(1) + ' °C';
          }
          if (state.answer7 != null) {
            _tempAnswerController.text =
                state.answer7!.toStringAsFixed(1) + ' °R';
          }
          if (state.answer8 != null) {
            _tempAnswerController.text =
                state.answer8!.toStringAsFixed(1) + ' K';
          }
          if (state.answer9 != null) {
            _tempAnswerController.text =
                state.answer9!.toStringAsFixed(1) + ' °R';
          }
          if (state.answer10 != null) {
            _tempAnswerController.text =
                state.answer10!.toStringAsFixed(1) + ' °C';
          }
          if (state.answer11 != null) {
            _tempAnswerController.text =
                state.answer11!.toStringAsFixed(1) + ' F';
          }
          if (state.answer12 != null) {
            _tempAnswerController.text =
                state.answer12!.toStringAsFixed(1) + ' K';
          }
          if (state.answer13 != null) {
            _tempAnswerController.text =
                state.answer13!.toStringAsFixed(1) + ' K';
          }
          if (state.answer14 != null) {
            _tempAnswerController.text =
                state.answer14!.toStringAsFixed(1) + ' °C';
          }
          if (state.answer15 != null) {
            _tempAnswerController.text =
                state.answer15!.toStringAsFixed(1) + ' °F';
          }
          if (state.answer16 != null) {
            _tempAnswerController.text =
                state.answer16!.toStringAsFixed(1) + ' R';
          }
        }
      },
      child: Scaffold(
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
                    title: 'Convert (°F...',
                    nav: 'airTempConvert',
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
                FormulaButton(
                    onPressed: () => openDialog(), formula: r'\sqrt{abc}'),
                const Header(title: 'CONVERT \n(°F, °C, R, K)'),
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
                          MainButtons(
                              onPressed: () {
                                convert.isC();
                                setState(() {
                                  _tempConvert();
                                });
                              },
                              name: "°C",
                              textColor: Colors.white,
                              active: active.isCelcius),
                          MainButtons(
                              onPressed: () {
                                convert.isF();
                                setState(() {
                                  _tempConvert();
                                });
                              },
                              name: "°F",
                              textColor: Colors.white,
                              active: active.isFahrenheit),
                          MainButtons(
                              onPressed: () {
                                convert.isRankine();
                                setState(() {
                                  _tempConvert();
                                });
                              },
                              name: "R",
                              textColor: Colors.white,
                              active: active.isR),
                          MainButtons(
                              onPressed: () {
                                convert.isKelvin();
                                setState(() {
                                  _tempConvert();
                                });
                              },
                              name: "K",
                              textColor: Colors.white,
                              active: active.isK),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CustomTextField(
                        controller: _tempInputController,
                        regExp: RegExp(r'^-?\d*\.?\d{0,2}'),
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        hintText: 'Temperature',
                        labelText: 'Enter  temp',
                      ),
                    ),
                    ListTile(
                      title: Row(
                        children: <Widget>[
                          MainButtons(
                              onPressed: () {
                                convert.isLowerCelcius();
                                setState(() {
                                  _tempConvert();
                                });
                              },
                              name: "°C",
                              textColor: Colors.white,
                              active: active.isCelcius1),
                          MainButtons(
                              onPressed: () {
                                convert.isLowerFahrenhiet();
                                setState(() {
                                  _tempConvert();
                                });
                              },
                              name: "°F",
                              textColor: Colors.white,
                              active: active.isFahrenheit1),
                          MainButtons(
                              onPressed: () {
                                convert.isLowerRankine();
                                setState(() {
                                  _tempConvert();
                                });
                              },
                              name: "R",
                              textColor: Colors.white,
                              active: active.isR1),
                          MainButtons(
                              onPressed: () {
                                convert.isLowerKelvin();
                                setState(() {
                                  _tempConvert();
                                });
                              },
                              name: "K",
                              textColor: Colors.white,
                              active: active.isK1),
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
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
                      child: AbsorbPointer(
                        child: AnswerField(
                          controller: _tempAnswerController,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
          child: SizedBox(
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
        ),
      );
}
