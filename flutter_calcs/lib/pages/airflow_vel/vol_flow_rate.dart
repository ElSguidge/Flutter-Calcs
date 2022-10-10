import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calcs/constants/color_constants.dart';
import 'package:flutter_calcs/pages/airflow_vel/bloc/vol_flow/vol_flow_bloc.dart';
import 'package:flutter_calcs/widgets/add_button.dart';
import 'package:flutter_calcs/widgets/answer_field.dart';
import 'package:flutter_calcs/widgets/formula_button.dart';
import 'package:flutter_calcs/widgets/main_buttons.dart';
import 'package:flutter_calcs/widgets/pagination.dart';
import 'package:flutter_calcs/widgets/text_fields.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_calcs/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

import '../../database/db.dart';
import '../../providers/airflow_button_state.dart';
import '../../widgets/header.dart';

class VolFlowRate extends StatefulWidget {
  const VolFlowRate({Key? key}) : super(key: key);

  @override
  State<VolFlowRate> createState() => _VolFlowRateState();
}

class _VolFlowRateState extends State<VolFlowRate> {
  FirebaseServices firebaseServices = FirebaseServices();

  String title = 'Volumetric Flow Rate (Q)';

  final _rectWidthController = TextEditingController();
  final _rectHeightController = TextEditingController();
  final _rectCalcController = TextEditingController();
  final _rectCalcControllerQ = TextEditingController();

  final _roundController = TextEditingController();
  final _roundCalcController = TextEditingController();
  final _roundCalcControllerQ = TextEditingController();

  final _flatWidthController = TextEditingController();
  final _flatHeightController = TextEditingController();
  final _flatCalcController = TextEditingController();
  final _flatCalcControllerQ = TextEditingController();

  final _areaController = TextEditingController();

  final _velController = TextEditingController();
  final _velCalcController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<VolumeBloc>().add(InitialVolumeEvent());
    _rectWidthController.addListener(_changed);
    _rectHeightController.addListener(_changed);

    _roundController.addListener(_changed);

    _flatWidthController.addListener(_changed);
    _flatHeightController.addListener(_changed);

    _areaController.addListener(_changed);

    _velController.addListener(_changed);
  }

  @override
  void dispose() {
    _rectWidthController.removeListener(_changed);
    _rectHeightController.removeListener(_changed);
    _rectCalcController.dispose();
    _rectCalcControllerQ.dispose();

    _roundController.removeListener(_changed);
    _roundCalcController.dispose();
    _roundCalcControllerQ.dispose();

    _flatWidthController.removeListener(_changed);
    _flatCalcController.dispose();
    _flatHeightController.removeListener(_changed);
    _flatCalcControllerQ.dispose();

    _areaController.removeListener(_changed);

    _velController.removeListener(_changed);
    _velCalcController.dispose();
    super.dispose();
  }

  _changed() {
    if (_areaController.text.trim().isNotEmpty &&
        _velController.text.trim().isNotEmpty) {
      context.read<VolumeBloc>().add(AreaKnown(
          velocity: double.parse(_velController.text),
          area: double.parse(_areaController.text)));
    }
    if (_rectWidthController.text.trim().isNotEmpty &&
        _rectHeightController.text.trim().isNotEmpty &&
        _velController.text.trim().isNotEmpty) {
      context.read<VolumeBloc>().add(RectangleArea(
          velocity: double.parse(_velController.text),
          height: double.parse(_rectHeightController.text),
          width: double.parse(_rectWidthController.text)));
    }
    if (_roundController.text.isNotEmpty &&
        _velController.text.trim().isNotEmpty) {
      context.read<VolumeBloc>().add(RoundArea(
          velocity: double.parse(_velController.text),
          diameter: double.parse(_roundController.text)));
    }
    if (_flatHeightController.text.trim().isNotEmpty &&
        _flatWidthController.text.trim().isNotEmpty) {
      context.read<VolumeBloc>().add(FlatArea(
          velocity: double.parse(_velController.text),
          flatHeight: double.parse(_flatHeightController.text),
          flatWidth: double.parse(_flatWidthController.text)));
    }
    if (_areaController.text.isEmpty || _velCalcController.text.isEmpty) {
      _velCalcController.text = '';
    }
    if (_rectHeightController.text.isEmpty ||
        _rectWidthController.text.isEmpty ||
        _velController.text.isEmpty) {
      _rectCalcController.text = '';
      _rectCalcControllerQ.text = '';
    }
    if (_flatHeightController.text.isEmpty ||
        _flatWidthController.text.isEmpty ||
        _velController.text.isEmpty) {
      _flatCalcController.text = '';
      _flatCalcControllerQ.text = '';
    }
    if (_roundController.text.isEmpty || _velCalcController.text.isEmpty) {
      _roundCalcController.text = '';
      _roundCalcControllerQ.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    AirFlowButtonProvider airflow =
        Provider.of<AirFlowButtonProvider>(context, listen: false);
    AirFlowButtonProvider active = Provider.of<AirFlowButtonProvider>(context);
    return BlocListener<VolumeBloc, VolumeState>(
      listener: (BuildContext context, VolumeState state) {
        if (state is VolumeDataState) {
          if (state.answer1 != null) {
            _velCalcController.text =
                state.answer1!.toStringAsFixed(2) + ' l/s';
          }
          if (state.answer2A != null) {
            _rectCalcController.text =
                state.answer2A!.toStringAsFixed(4) + ' m²';
          }
          if (state.answer2 != null) {
            _rectCalcControllerQ.text =
                state.answer2!.toStringAsFixed(2) + ' l/s';
          }
          if (state.answer3 != null) {
            _roundCalcController.text =
                state.answer3!.toStringAsFixed(4) + ' m²';
          }
          if (state.answer3A != null) {
            _roundCalcControllerQ.text =
                state.answer3A!.toStringAsFixed(2) + ' l/s';
          }
          if (state.answer4 != null) {
            _flatCalcController.text =
                state.answer4!.toStringAsFixed(4) + ' m²';
          }
          if (state.answer4A != null) {
            _flatCalcControllerQ.text =
                state.answer4A!.toStringAsFixed(2) + ' l/s';
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
                    title: 'Vol. Flow..',
                    nav: 'volFlowRate',
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
                const Header(title: 'VOLUMETRIC FLOW RATE (Q)'),
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
                          padding: const EdgeInsets.all(20.0),
                          child: CustomTextField(
                            // onChanged: _calculate,
                            controller: _velController,
                            regExp: RegExp(r'^\d+\.?\d{0,3}'),
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            hintText: 'Enter velocity [in m/s]',
                            labelText: 'Enter  Air Velocity (V)',
                          )),
                    ),
                    ListTile(
                      title: Row(
                        children: <Widget>[
                          MainButtons(
                              onPressed: () => airflow.closeArea(),
                              name: 'Area',
                              textColor: Colors.white,
                              active:
                                  Provider.of<AirFlowButtonProvider>(context)
                                      .displayArea),
                          MainButtons(
                              onPressed: () => airflow.closeRect(),
                              name: 'Rect',
                              textColor: Colors.white,
                              active: active.displayRect),
                          MainButtons(
                              onPressed: () => airflow.closeRound(),
                              name: 'Round',
                              textColor: Colors.white,
                              active: active.displayRound),
                          MainButtons(
                              onPressed: () => airflow.closeFlat(),
                              name: 'Flat',
                              textColor: Colors.white,
                              active: active.displayFlat),
                        ],
                      ),
                    ),
                    //Area known
                    Visibility(
                      visible: active.displayArea,
                      child: Column(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: CustomTextField(
                                  // onChanged: () => _calculate,
                                  hintText: 'Enter area [in m²]',
                                  regExp: RegExp(r'^\d+\.?\d{0,4}'),
                                  controller: _areaController,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          signed: true, decimal: true),
                                  labelText: 'Enter known area (m²)')),
                          const SizedBox(height: 20),
                          const Text(
                            "Calculated Flow Rate (Q): ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 0.0, 20.0, 30.0),
                            child: AbsorbPointer(
                                child: AnswerField(
                              controller: _velCalcController,
                            )),
                          ),
                        ],
                      ),
                    ),

                    //Rectangle with height added
                    Visibility(
                      visible: active.displayRect,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: CustomTextField(
                                        // onChanged: _calculate,
                                        hintText: 'Width [in mm]',
                                        regExp: RegExp(r'^\d+\.?\d{0,1}'),
                                        controller: _rectWidthController,
                                        keyboardType: const TextInputType
                                                .numberWithOptions(
                                            signed: true, decimal: true),
                                        labelText: 'Width(mm)')),
                              ),
                              const SizedBox(width: 20.0),
                              Expanded(
                                // optional flex property if flex is 1 because the default flex is 1
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: CustomTextField(
                                      // onChanged: _calculate,
                                      hintText: 'Height [in mm]',
                                      regExp: RegExp(r'^\d+\.?\d{0,1}'),
                                      controller: _rectHeightController,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              signed: true, decimal: true),
                                      labelText: 'Height(mm)'),
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
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 0.0, 20.0, 30.0),
                            child: AbsorbPointer(
                                child: AnswerField(
                                    controller: _rectCalcController)),
                          ),
                          const Text(
                            "Calculated Flow Rate (Q): ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 0.0, 20.0, 30.0),
                            child: AbsorbPointer(
                                child: AnswerField(
                                    controller: _rectCalcControllerQ)),
                          ),
                        ],
                      ),
                    ),

                    //Round
                    Visibility(
                      visible: active.displayRound,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: CustomTextField(
                                // onChanged: _calculate,
                                hintText: 'Enter Diameter [in mm]',
                                regExp: RegExp(r'^\d+\.?\d{0,1}'),
                                controller: _roundController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: true, decimal: true),
                                labelText: 'Diameter (mm)'),
                          ),
                          //here
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
                                    controller: _roundCalcController)),
                          ),
                          const Text(
                            "Calculated Flow Rate (Q): ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 0.0, 20.0, 30.0),
                            child: AbsorbPointer(
                                child: AnswerField(
                                    controller: _roundCalcControllerQ)),
                          ),
                        ],
                      ),
                    ),
                    //  Flat oval duct with height added
                    Visibility(
                      visible: active.displayFlat,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: CustomTextField(
                                    controller: _flatWidthController,
                                    regExp: RegExp(r'^\d+\.?\d{0,1}'),
                                    hintText: 'Width [in mm]',
                                    labelText: 'Width(mm)',
                                    // onChanged: _calculate,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            signed: true, decimal: true),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20.0),
                              Expanded(
                                // optional flex property if flex is 1 because the default flex is 1
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: CustomTextField(
                                    controller: _flatHeightController,
                                    // onChanged: _calculate,
                                    regExp: RegExp(r'^\d+\.?\d{0,1}'),
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            signed: true, decimal: true),
                                    hintText: 'Height [in mm]',
                                    labelText: 'Height(mm)',
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
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 0.0, 20.0, 30.0),
                            child: AbsorbPointer(
                              child:
                                  AnswerField(controller: _flatCalcController),
                            ),
                          ),
                          const Text(
                            "Calculated Flow Rate (Q): ",
                            style: TextStyle(color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 0.0, 20.0, 30.0),
                            child: AbsorbPointer(
                              child:
                                  AnswerField(controller: _flatCalcControllerQ),
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
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: ColorConstants.lightScaffoldBackgroundColor,
          child: SizedBox(
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
}
