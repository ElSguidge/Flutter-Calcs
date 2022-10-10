import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calcs/constants/color_constants.dart';
import 'package:flutter_calcs/database/db.dart';
import 'package:flutter_calcs/providers/airflow_button_state.dart';
import 'package:flutter_calcs/widgets/add_button.dart';
import 'package:flutter_calcs/widgets/answer_field.dart';
import 'package:flutter_calcs/widgets/custom_drawer.dart';
import 'package:flutter_calcs/widgets/formula_button.dart';
import 'package:flutter_calcs/widgets/header.dart';
import 'package:flutter_calcs/widgets/text_fields.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:provider/provider.dart';

import '../../widgets/pagination.dart';
import 'bloc/velocity_of_air/vel_air_bloc.dart';

class VelocityAir extends StatefulWidget {
  const VelocityAir({Key? key}) : super(key: key);

  @override
  State<VelocityAir> createState() => _VelocityAirState();
}

class _VelocityAirState extends State<VelocityAir> {
  FirebaseServices firebaseServices = FirebaseServices();
  String title = 'Velocity of Air';
  final TextEditingController _velocityController = TextEditingController();
  final TextEditingController _airDensity = TextEditingController();
  final TextEditingController _velocityControllerAnswer =
      TextEditingController();
  final TextEditingController _airDensityControllerAnswer =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<VelBloc>().add(InitialVelocityEvent());
    _velocityController.addListener(_changed);
    _airDensity.addListener(_changed);
  }

  @override
  void dispose() {
    _velocityController.removeListener(_changed);
    _airDensity.removeListener(_changed);
    _velocityControllerAnswer.dispose();
    _airDensityControllerAnswer.dispose();
    super.dispose();
  }

  _changed() {
    if (_velocityController.text.trim().isNotEmpty) {
      context.read<VelBloc>().add(
          StandardAirEvent(velocity: double.parse(_velocityController.text)));
    }
    if (_velocityController.text.trim().isNotEmpty &&
        _airDensity.text.trim().isNotEmpty) {
      context.read<VelBloc>().add(AirDensityEvent(
          velocity: double.parse(_velocityController.text),
          airDensity: double.parse(_airDensity.text)));
    }
    if (_velocityController.text.isEmpty) {
      _velocityControllerAnswer.text = '';
    }
    if (_velocityController.text.isEmpty || _airDensity.text.isEmpty) {
      _airDensityControllerAnswer.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    AirFlowButtonProvider airflow =
        Provider.of<AirFlowButtonProvider>(context, listen: false);
    AirFlowButtonProvider active = Provider.of<AirFlowButtonProvider>(context);

    return BlocListener<VelBloc, VelocityState>(
      listener: (BuildContext context, VelocityState state) {
        if (state is VelocityDataState) {
          _velocityControllerAnswer.text =
              state.answer1.toStringAsFixed(2) + ' m/s';
          _airDensityControllerAnswer.text =
              state.answer2.toStringAsFixed(2) + ' m/s';
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
                    title: 'Vel. of Air',
                    nav: 'velOfAir',
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
                  onPressed: () => openDialog(),
                  formula: r'\sqrt{abc}',
                ),
                const Header(title: "Velocity of Air (V)"),
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
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CustomTextField(
                          hintText: 'Enter velocity pressure [in Pa]',
                          regExp: RegExp(r'^\d+\.?\d{0,1}'),
                          controller: _velocityController,
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          labelText: 'Velocity Pressure (VP)'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Text(
                          "Standard Air?",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            active.isStandardAir ? "Yes" : "No",
                            style: TextStyle(
                                color: active.isStandardAir
                                    ? CupertinoColors.activeGreen
                                    : CupertinoColors.destructiveRed,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CupertinoSwitch(
                            // This bool value toggles the switch.
                            value: active.isStandardAir,
                            thumbColor: Colors.white,
                            trackColor: ColorConstants.borderColor,
                            activeColor: ColorConstants.lightGreen,
                            onChanged: (bool value) {
                              airflow.standardAir(value);
                            },
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: !active.isStandardAir,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: CustomTextField(
                              controller: _airDensity,
                              regExp: RegExp(r'^\d+\.?\d{0,5}'),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              labelText: 'Air Density (p)',
                              hintText: 'Enter air density [kg/m³]',
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Calculated Velocity of Air (V): ',
                              style: TextStyle(color: Color(0xFFffffff)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 0.0, 20.0, 30.0),
                            child: AbsorbPointer(
                              child: AnswerField(
                                controller: _airDensityControllerAnswer,
                              ),
                            ),
                            // Text(
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: active.isStandardAir,
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Calculated Velocity of Air (V): ',
                              style: TextStyle(color: Color(0xFFffffff)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 0.0, 20.0, 30.0),
                            child: AbsorbPointer(
                                child: AnswerField(
                                    controller: _velocityControllerAnswer)),
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
                    r'V_{(stdair)} = 1.225 \times \sqrt{VP}',
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
