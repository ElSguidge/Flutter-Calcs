import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calcs/pages/air_temp/bloc/mixed_air/mixed_air_bloc.dart';
import 'package:flutter_calcs/widgets/answer_field.dart';
import 'package:flutter_calcs/widgets/text_fields.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import 'package:flutter_calcs/constants/color_constants.dart';
import 'package:flutter_calcs/database/db.dart';
import 'package:flutter_calcs/widgets/add_button.dart';
import 'package:flutter_calcs/widgets/custom_drawer.dart';

import '../../widgets/formula_button.dart';
import '../../widgets/header.dart';
import '../../widgets/pagination.dart';

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
    context.read<MixedAirTempBloc>().add(InitialMixedAirEvent());
    _raTemp.addListener(_calculate);
    _oaPercent.addListener(_calculate);
    _oaTemp.addListener(_calculate);
    _raPercent.addListener(_calculate);
  }

  @override
  void dispose() {
    _raTemp.removeListener(_calculate);
    _oaPercent.removeListener(_calculate);
    _oaTemp.removeListener(_calculate);
    _raPercent.removeListener(_calculate);
    _mixedAirTempAnswer.dispose();
    super.dispose();
  }

  _calculate() {
    if (_oaTemp.text.trim().isNotEmpty &&
        _oaPercent.text.trim().isNotEmpty &&
        _raPercent.text.trim().isNotEmpty &&
        _raTemp.text.trim().isNotEmpty) {
      context.read<MixedAirTempBloc>().add(MixedAirCalc(
          raPercent: double.parse(_raPercent.text),
          rat: double.parse(_raTemp.text),
          oaPercent: double.parse(_oaPercent.text),
          oat: double.parse(_oaTemp.text)));
    }
    if (_oaTemp.text.isEmpty ||
        _oaPercent.text.isEmpty ||
        _raPercent.text.isEmpty ||
        _raTemp.text.isEmpty) {
      _mixedAirTempAnswer.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MixedAirTempBloc, MixedAirState>(
      listener: (BuildContext context, MixedAirState state) {
        if (state is MixedAirDataState) {
          _mixedAirTempAnswer.text = state.answer1.toStringAsFixed(1) + ' °C';
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
                    title: 'Mixed Air Temp',
                    nav: 'mixedAirTemp',
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
                const Header(title: 'Mixed Air Temperature'),
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
                                        child: CustomTextField(
                                          controller: _raPercent,
                                          regExp: RegExp(r'^\d+\.?\d{0,1}'),
                                          hintText: 'Enter % of RA',
                                          labelText: 'Return Air %',
                                          keyboardType: const TextInputType
                                                  .numberWithOptions(
                                              signed: true, decimal: true),
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
                                        child: CustomTextField(
                                          controller: _raTemp,
                                          regExp: RegExp(r'^\d+\.?\d{0,1}'),
                                          hintText: 'Enter RA temp',
                                          labelText: 'RA Temp °C',
                                          keyboardType: const TextInputType
                                                  .numberWithOptions(
                                              signed: true, decimal: true),
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
                                        child: CustomTextField(
                                          controller: _oaPercent,
                                          regExp: RegExp(r'^\d+\.?\d{0,1}'),
                                          hintText: 'Enter % OA',
                                          labelText: 'Outside Air %',
                                          keyboardType: const TextInputType
                                                  .numberWithOptions(
                                              signed: true, decimal: true),
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
                                        child: CustomTextField(
                                          controller: _oaTemp,
                                          regExp: RegExp(r'^\d+\.?\d{0,1}'),
                                          hintText: 'Enter OA Temp',
                                          labelText: 'OA Temp °C',
                                          keyboardType: const TextInputType
                                                  .numberWithOptions(
                                              signed: true, decimal: true),
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
                            child: AnswerField(
                              controller: _mixedAirTempAnswer,
                            ),
                          ),
                        ),
                      ],
                    ))),
          ],
        ),
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

  // void _calculate() {
  //   var str = ' °C';
  //   if (_oaTemp.text.trim().isNotEmpty &&
  //       _oaPercent.text.trim().isNotEmpty &&
  //       _raPercent.text.trim().isNotEmpty &&
  //       _raTemp.text.trim().isNotEmpty) {
  //     final outsideT = double.parse(_oaTemp.text);
  //     final outsideP = double.parse(_oaPercent.text);
  //     final returnT = double.parse(_raTemp.text);
  //     final returnP = double.parse(_raPercent.text);

  //     final oa = (outsideP / 100) * outsideT;
  //     final ra = (returnP / 100) * returnT;

  //     _mixedAirTempAnswer.text = (oa + ra).toStringAsFixed(1) + str;
  //   }
  // }
}
