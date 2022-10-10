import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calcs/pages/airflow_vel/bloc/area/area_bloc.dart';
import 'package:flutter_calcs/providers/area_button_state.dart';
import 'package:flutter_calcs/widgets/add_button.dart';
import 'package:flutter_calcs/widgets/answer_field.dart';
import 'package:flutter_calcs/widgets/formula_button.dart';
import 'package:flutter_calcs/widgets/header.dart';
import 'package:flutter_calcs/widgets/main_buttons.dart';
import 'package:flutter_calcs/widgets/text_fields.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_calcs/widgets/custom_drawer.dart';

import '../../constants/color_constants.dart';
import '../../database/db.dart';
import '../../widgets/pagination.dart';

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

  @override
  void initState() {
    super.initState();
    context.read<AreaBloc>().add(InitialAreaEvent());
    _rectWidthController.addListener(_changed);
    _rectHeightController.addListener(_changed);
    _roundController.addListener(_changed);
    _flatWidthController.addListener(_changed);
    _flatHeightController.addListener(_changed);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _rectCalcController.dispose();
    _roundCalcController.dispose();
    _flatCalcController.dispose();
    _rectWidthController.removeListener(_changed);
    _rectHeightController.removeListener(_changed);
    _roundController.removeListener(_changed);
    _flatWidthController.removeListener(_changed);
    _flatHeightController.removeListener(_changed);
    super.dispose();
  }

  _changed() {
    if (_rectWidthController.text.trim().isNotEmpty &&
        _rectHeightController.text.trim().isNotEmpty) {
      context.read<AreaBloc>().add(RectangleArea(
          height: double.parse(_rectHeightController.text),
          width: double.parse(_rectWidthController.text)));
    }
    if (_roundController.text.isNotEmpty) {
      context
          .read<AreaBloc>()
          .add(RoundArea(diameter: double.parse(_roundController.text)));
    }
    if (_flatHeightController.text.trim().isNotEmpty &&
        _flatWidthController.text.trim().isNotEmpty) {
      context.read<AreaBloc>().add(FlatArea(
          flatHeight: double.parse(_flatHeightController.text),
          flatWidth: double.parse(_flatWidthController.text)));
    }
    if (_rectHeightController.text.isEmpty ||
        _rectWidthController.text.isEmpty) {
      _rectCalcController.text = '';
    }
    if (_flatHeightController.text.isEmpty ||
        _flatWidthController.text.isEmpty) {
      _flatCalcController.text = '';
    }
    if (_roundController.text.isEmpty) {
      _roundCalcController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    AreaButtonProvider area =
        Provider.of<AreaButtonProvider>(context, listen: false);
    AreaButtonProvider active = Provider.of<AreaButtonProvider>(context);

    return BlocListener<AreaBloc, AreaState>(
      listener: (BuildContext context, AreaState state) {
        if (state is AreaDataState) {
          if (state.answer1 != null) {
            _rectCalcController.text =
                state.answer1!.toStringAsFixed(4) + ' m²';
          }
          if (state.answer2 != null) {
            _roundCalcController.text =
                state.answer2!.toStringAsFixed(4) + ' m²';
          }
          if (state.answer3 != null) {
            _flatCalcController.text =
                state.answer3!.toStringAsFixed(4) + ' m²';
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
                    title: 'Duct Area',
                    nav: 'ductArea',
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
                const Header(title: 'DUCT AREA'),
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
                          MainButtons(
                              onPressed: () => area.closeRect(),
                              name: 'Rect',
                              textColor: Colors.white,
                              active: active.displayRect),
                          MainButtons(
                              onPressed: () => area.closeRound(),
                              name: 'Round',
                              textColor: Colors.white,
                              active: active.displayRound),
                          MainButtons(
                            onPressed: () => area.closeFlat(),
                            name: 'Flat',
                            textColor: Colors.white,
                            active: active.displayFlat,
                          ),
                        ],
                      ),
                    ),

                    //Rectangle
                    Visibility(
                      visible: active.displayRect,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: CustomTextField(
                              controller: _rectWidthController,
                              regExp: RegExp(r'^\d+\.?\d{0,1}'),
                              hintText: 'Enter width [in mm]',
                              labelText: 'Height (mm)',
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: CustomTextField(
                                controller: _rectHeightController,
                                regExp: RegExp(r'^\d+\.?\d{0,1}'),
                                hintText: 'Enter height [in mm]',
                                labelText: 'Width (mm)',
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: true, decimal: true),
                              )),
                          const Text(
                            "Calculated area (A): ",
                            style: TextStyle(color: Colors.white),
                          ),
                          //here
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 0.0, 20.0, 30.0),
                            child: AbsorbPointer(
                              child: AnswerField(
                                controller: _rectCalcController,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //  Round duct
                    Visibility(
                      visible: active.displayRound,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: CustomTextField(
                              controller: _roundController,
                              regExp: RegExp(r'^\d+\.?\d{0,1}'),
                              hintText: 'Enter Diameter [in mm]',
                              labelText: 'Diameter (mm)',
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                            ),
                          ),
                          const Text(
                            "Calculated area (A): ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 0.0, 20.0, 30.0),
                            child: AbsorbPointer(
                              child: AnswerField(
                                controller: _roundCalcController,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //  Flat oval duct

                    Visibility(
                      visible: active.displayFlat,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 20.0, 20.0, 30.0),
                            child: CustomTextField(
                              controller: _flatWidthController,
                              regExp: RegExp(r'^\d+\.?\d{0,1}'),
                              hintText: 'Enter width [in mm]',
                              labelText: 'Width (mm)',
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 0.0, 20.0, 30.0),
                            child: CustomTextField(
                              controller: _flatHeightController,
                              regExp: RegExp(r'^\d+\.?\d{0,1}'),
                              hintText: 'Enter height [in mm]',
                              labelText: 'Height (mm)',
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                            ),
                          ),
                          const Text(
                            "Calculated area (A): ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 0.0, 20.0, 30.0),
                            child: AbsorbPointer(
                              child: AnswerField(
                                controller: _flatCalcController,
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
