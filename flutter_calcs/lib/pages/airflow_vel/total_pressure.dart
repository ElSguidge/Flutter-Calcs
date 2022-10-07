import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calcs/constants/color_constants.dart';
import 'package:flutter_calcs/database/db.dart';
import 'package:flutter_calcs/pages/airflow_vel/bloc/total_pressure/total_p_bloc.dart';
import 'package:flutter_calcs/widgets/add_button.dart';
import 'package:flutter_calcs/widgets/answer_field.dart';
import 'package:flutter_calcs/widgets/custom_drawer.dart';
import 'package:flutter_calcs/widgets/header.dart';
import 'package:flutter_calcs/widgets/text_fields.dart';
import 'package:flutter_calcs/widgets/formula_button.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import '../../widgets/pagination.dart';

class TotalPressure extends StatefulWidget {
  const TotalPressure({Key? key}) : super(key: key);

  @override
  State<TotalPressure> createState() => _TotalPressureState();
}

class _TotalPressureState extends State<TotalPressure> {
  FirebaseServices firebaseServices = FirebaseServices();

  String title = 'Total Pressure';
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  final TextEditingController _thirdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TotalPressureBloc>().add(InitialTotalPressureEvent());
    _firstController.addListener(_changed);
    _secondController.addListener(_changed);
  }

  @override
  void dispose() {
    _firstController.removeListener(_changed);
    _secondController.removeListener(_changed);
    _thirdController.dispose();
    super.dispose();
  }

  _changed() {
    if (_firstController.text.trim().isNotEmpty &&
        _secondController.text.trim().isNotEmpty) {
      context.read<TotalPressureBloc>().add(AddPressureEvent(
          velocityPressure: double.parse(_firstController.text),
          staticPressure: double.parse(_secondController.text)));
    }
    if (_firstController.text.isEmpty || _secondController.text.isEmpty) {
      _thirdController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TotalPressureBloc, TotalPressureCalcState>(
        listener: (BuildContext context, TotalPressureCalcState state) {
          if (state is TotalPressureDataState) {
            _thirdController.text = state.answer.toStringAsFixed(0) + ' Pa';
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
                      title: 'Total Pres...',
                      nav: 'totalPressure',
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
                  const Header(title: "TOTAL PRESSURE"),
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
                              controller: _firstController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              labelText: 'Velocity Pressure (VP)')),
                      Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CustomTextField(
                            controller: _secondController,
                            labelText: 'Static Pressure (SP)',
                            hintText: 'Enter static pressure [in Pa]',
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            regExp: RegExp(r'^\d+\.?\d{0,1}'),
                          )),
                      const Text(
                        'Calculated Total Pressure: ',
                        style: TextStyle(color: Colors.white70),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 30.0),
                        child: AnswerField(
                          controller: _thirdController,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
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
                    r'TP(Pa) = VP + SP',
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
