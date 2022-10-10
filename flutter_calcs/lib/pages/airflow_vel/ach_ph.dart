import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calcs/constants/color_constants.dart';
import 'package:flutter_calcs/database/db.dart';
import 'package:flutter_calcs/pages/airflow_vel/bloc/ach/ach_bloc.dart';
import 'package:flutter_calcs/widgets/add_button.dart';
import 'package:flutter_calcs/widgets/answer_field.dart';
import 'package:flutter_calcs/widgets/custom_drawer.dart';
import 'package:flutter_calcs/widgets/formula_button.dart';
import 'package:flutter_calcs/widgets/text_fields.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:provider/provider.dart';

import '../../providers/airflow_button_state.dart';
import '../../widgets/header.dart';
import '../../widgets/pagination.dart';

class AirChangesPh extends StatefulWidget {
  const AirChangesPh({Key? key}) : super(key: key);

  @override
  State<AirChangesPh> createState() => _AirChangesPhState();
}

class _AirChangesPhState extends State<AirChangesPh> {
  FirebaseServices firebaseServices = FirebaseServices();

  String title = 'Air Changes Per Hour (ACH)';

  final TextEditingController _knownRoomVolume = TextEditingController();
  final TextEditingController _knownRoomVolumeAirflow = TextEditingController();
  final TextEditingController _knownRoomVolumeACH = TextEditingController();

  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _calculatedAreaAirflow = TextEditingController();
  final TextEditingController _calculatedVolumeACH = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AchBloc>().add(InitialAchEvent());
    _knownRoomVolume.addListener(_changed);
    _knownRoomVolumeAirflow.addListener(_changed);
    _lengthController.addListener(_changed);
    _widthController.addListener(_changed);
    _heightController.addListener(_changed);
    _calculatedAreaAirflow.addListener(_changed);
  }

  @override
  void dispose() {
    _knownRoomVolumeACH.dispose();
    _calculatedVolumeACH.dispose();
    _knownRoomVolume.removeListener(_changed);
    _knownRoomVolumeAirflow.removeListener(_changed);
    _lengthController.removeListener(_changed);
    _widthController.removeListener(_changed);
    _heightController.removeListener(_changed);
    _calculatedAreaAirflow.removeListener(_changed);
    super.dispose();
  }

  _changed() {
    if (_knownRoomVolume.text.trim().isNotEmpty &&
        _knownRoomVolumeAirflow.text.trim().isNotEmpty) {
      context.read<AchBloc>().add(VolumeKnown(
          roomVolume: double.parse(_knownRoomVolume.text),
          airflow: double.parse(_knownRoomVolumeAirflow.text)));
    }
    if (_heightController.text.trim().isNotEmpty &&
        _widthController.text.trim().isNotEmpty &&
        _lengthController.text.trim().isNotEmpty &&
        _calculatedAreaAirflow.text.trim().isNotEmpty) {
      context.read<AchBloc>().add(CalculateVolume(
          length: double.parse(_lengthController.text),
          height: double.parse(_heightController.text),
          width: double.parse(_widthController.text),
          airflow: double.parse(_calculatedAreaAirflow.text)));
    }
    if (_knownRoomVolume.text.isEmpty || _knownRoomVolumeAirflow.text.isEmpty) {
      _knownRoomVolumeACH.text = '';
    }
    if (_lengthController.text.isEmpty ||
        _heightController.text.isEmpty ||
        _widthController.text.isEmpty ||
        _calculatedAreaAirflow.text.isEmpty) {
      _calculatedVolumeACH.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    AirFlowButtonProvider airflow =
        Provider.of<AirFlowButtonProvider>(context, listen: false);
    AirFlowButtonProvider active = Provider.of<AirFlowButtonProvider>(context);

    return BlocListener<AchBloc, AchState>(
      listener: (BuildContext context, AchState state) {
        if (state is AchDataState) {
          if (state.answer1 != null) {
            _knownRoomVolumeACH.text = state.answer1!.toStringAsFixed(1);
          }
          if (state.answer2 != null) {
            _calculatedVolumeACH.text = state.answer2!.toStringAsFixed(1);
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
                    title: 'Air Change...',
                    nav: 'airChange',
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
                  formula: r'\sqrt{abc}',
                  onPressed: () => openDialog(),
                ),
                const Header(title: 'Air Changes Per Hour'),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          active.isKnownAirChange
                              ? "Known room volume (m³)"
                              : "Calculate volume",
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: CupertinoSwitch(
                            // This bool value toggles the switch.
                            value: active.isKnownAirChange,
                            thumbColor: Colors.white,
                            trackColor: ColorConstants.borderColor,
                            activeColor: ColorConstants.lightGreen,
                            onChanged: (bool value) {
                              airflow.knownACH(value);
                            },
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Enter room volume in metres",
                        style: TextStyle(color: Colors.white60),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Enter airflow rate in l/s",
                        style: TextStyle(color: Colors.white60),
                      ),
                    ),

                    // Known room volume
                    Visibility(
                      visible: active.isKnownAirChange,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 10.0, 10.0, 10.0),
                                  child: CustomTextField(
                                    controller: _knownRoomVolume,
                                    regExp: RegExp(r'^\d+\.?\d{0,1}'),
                                    hintText: 'Enter room volume [in m³]',
                                    labelText: 'Room volume (m³)',
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
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
                                    controller: _knownRoomVolumeAirflow,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            signed: true, decimal: true),
                                    regExp: RegExp(r'^\d+\.?\d{0,1}'),
                                    labelText: 'Airflow rate (Q)',
                                    hintText: 'Airflow [l/s]',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: !active.isKnownAirChange,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 10.0, 5.0, 10.0),
                                  child: CustomTextField(
                                    controller: _lengthController,
                                    labelText: 'Length',
                                    hintText: '[in m]',
                                    regExp: RegExp(r'^\d+\.?\d{0,1}'),
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
                                  padding: const EdgeInsets.fromLTRB(
                                      10.0, 10.0, 5.0, 10.0),
                                  child: CustomTextField(
                                    controller: _widthController,
                                    regExp: RegExp(r'^\d+\.?\d{0,1}'),
                                    labelText: 'Width',
                                    hintText: '[in m]',
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
                                  padding: const EdgeInsets.fromLTRB(
                                      5.0, 10.0, 20.0, 10.0),
                                  child: CustomTextField(
                                    controller: _heightController,
                                    regExp: RegExp(r'^\d+\.?\d{0,1}'),
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            signed: true, decimal: true),
                                    labelText: 'Height',
                                    hintText: '[in m]',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 15.0, 20.0, 10.0),
                            child: CustomTextField(
                              controller: _calculatedAreaAirflow,
                              regExp: RegExp(r'^\d+\.?\d{0,1}'),
                              hintText: 'Enter Airflow [l/s]',
                              labelText: 'Airflow l/s',
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Calculated Air Changes Per Hour: ',
                              style: TextStyle(color: Color(0xFFffffff)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 0.0, 20.0, 30.0),
                            child: AbsorbPointer(
                              child:
                                  AnswerField(controller: _calculatedVolumeACH),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: active.isKnownAirChange,
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Calculated Air Changes Per Hour: ',
                              style: TextStyle(color: Color(0xFFffffff)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 0.0, 20.0, 30.0),
                            child: AbsorbPointer(
                                child: AnswerField(
                                    controller: _knownRoomVolumeACH)),
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
            height: 300.0, // Change as per your requirement
            width: 500.0, // Change as per your requirement
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Math.tex(
                    r'ACHPH = \frac{3.6 \times Q}{L \times W \times H}',
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
