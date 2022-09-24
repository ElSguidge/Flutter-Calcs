import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calcs/constants/color_constants.dart';
import 'package:flutter_calcs/database/db.dart';
import 'package:flutter_calcs/widgets/add_button.dart';
import 'package:flutter_calcs/widgets/custom_drawer.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import '../../widgets/pagination.dart';

class AirChangesPh extends StatefulWidget {
  const AirChangesPh({Key? key}) : super(key: key);

  @override
  State<AirChangesPh> createState() => _AirChangesPhState();
}

class _AirChangesPhState extends State<AirChangesPh> {
  bool standard = true;
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
  }

  @override
  void dispose() {
    _knownRoomVolume.dispose();
    _knownRoomVolumeAirflow.dispose();
    _knownRoomVolumeACH.dispose();
    _lengthController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    _calculatedAreaAirflow.dispose();
    _calculatedVolumeACH.dispose();
    super.dispose();
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
      drawer: CustomDrawer(),
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
                  'Air Changes Per Hour',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        standard == true
                            ? "Known room volume (m³)"
                            : "Calculate volume",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CupertinoSwitch(
                          // This bool value toggles the switch.
                          value: standard,
                          thumbColor: Colors.white,
                          trackColor: ColorConstants.borderColor,
                          activeColor: ColorConstants.lightGreen,
                          onChanged: (bool? value) {
                            // This is called when the user toggles the switch.
                            setState(() {
                              standard = value!;
                            });
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
                    visible: standard,
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
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+\.?\d{0,1}')),
                                  ],
                                  controller: _knownRoomVolume,
                                  onChanged: (value) {
                                    _calculate();
                                  },
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          signed: true, decimal: true),
                                  cursorColor: Colors.white,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintStyle:
                                        const TextStyle(color: Colors.white70),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    filled: true,
                                    fillColor: ColorConstants
                                        .lightScaffoldBackgroundColor,
                                    labelText: 'Room volume (m³)',
                                    hintText: 'Enter room volume [in m³]',
                                    focusColor: Colors.white,
                                    labelStyle:
                                        const TextStyle(color: Colors.white),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          // ignore: unnecessary_const
                                          color: Colors.white60),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
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
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+\.?\d{0,1}')),
                                  ],
                                  controller: _knownRoomVolumeAirflow,
                                  onChanged: (value) {
                                    _calculate();
                                  },
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          signed: true, decimal: true),
                                  cursorColor: Colors.white,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintStyle:
                                        const TextStyle(color: Colors.white70),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    filled: true,
                                    fillColor: ColorConstants
                                        .lightScaffoldBackgroundColor,
                                    labelText: 'Airflow rate (Q)',
                                    hintText: 'Airflow [l/s]',
                                    focusColor: Colors.white,
                                    labelStyle:
                                        const TextStyle(color: Colors.white),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          // ignore: unnecessary_const
                                          color: Colors.white60),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !standard,
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
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+\.?\d{0,1}')),
                                  ],
                                  controller: _lengthController,
                                  onChanged: (value) {
                                    _calculate();
                                  },
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          signed: true, decimal: true),
                                  cursorColor: Colors.white,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintStyle:
                                        const TextStyle(color: Colors.white70),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    filled: true,
                                    fillColor: ColorConstants
                                        .lightScaffoldBackgroundColor,
                                    labelText: 'Length',
                                    hintText: 'Length [in m]',
                                    focusColor: Colors.white,
                                    labelStyle:
                                        const TextStyle(color: Colors.white),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          // ignore: unnecessary_const
                                          color: Colors.white60),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
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
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+\.?\d{0,1}')),
                                  ],
                                  controller: _widthController,
                                  onChanged: (value) {
                                    _calculate();
                                  },
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          signed: true, decimal: true),
                                  cursorColor: Colors.white,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintStyle:
                                        const TextStyle(color: Colors.white70),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    filled: true,
                                    fillColor: ColorConstants
                                        .lightScaffoldBackgroundColor,
                                    labelText: 'Width',
                                    hintText: 'Width [in m]',
                                    focusColor: Colors.white,
                                    labelStyle:
                                        const TextStyle(color: Colors.white),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          // ignore: unnecessary_const
                                          color: Colors.white60),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
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
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+\.?\d{0,1}')),
                                  ],
                                  controller: _heightController,
                                  onChanged: (value) {
                                    _calculate();
                                  },
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          signed: true, decimal: true),
                                  cursorColor: Colors.white,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    hintStyle:
                                        const TextStyle(color: Colors.white70),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    filled: true,
                                    fillColor: ColorConstants
                                        .lightScaffoldBackgroundColor,
                                    labelText: 'Height',
                                    hintText: 'Height [in m]',
                                    focusColor: Colors.white,
                                    labelStyle:
                                        const TextStyle(color: Colors.white),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          // ignore: unnecessary_const
                                          color: Colors.white60),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,1}')),
                            ],
                            controller: _calculatedAreaAirflow,
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
                              labelText: 'Airflow l/s',
                              hintText: 'Airflow [l/s]',
                              focusColor: Colors.white,
                              labelStyle: const TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    // ignore: unnecessary_const
                                    color: Colors.white60),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
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
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
                          child: AbsorbPointer(
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: _calculatedVolumeACH,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintStyle:
                                    const TextStyle(color: Colors.white70),
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
                  Visibility(
                    visible: standard,
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
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
                          child: AbsorbPointer(
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: _knownRoomVolumeACH,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintStyle:
                                    const TextStyle(color: Colors.white70),
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

  void _calculate() {
    if (_knownRoomVolume.text.trim().isNotEmpty &&
        _knownRoomVolumeAirflow.text.trim().isNotEmpty) {
      final volume = double.parse(_knownRoomVolume.text);
      final airflow = double.parse(_knownRoomVolumeAirflow.text);

      _knownRoomVolumeACH.text = (airflow * 3.6 / volume).toStringAsFixed(1);
    }
    if (_heightController.text.trim().isNotEmpty &&
        _widthController.text.trim().isNotEmpty &&
        _lengthController.text.trim().isNotEmpty &&
        _calculatedAreaAirflow.text.trim().isNotEmpty) {
      final height = double.parse(_heightController.text);
      final length = double.parse(_lengthController.text);
      final width = double.parse(_widthController.text);
      final airflow = double.parse(_calculatedAreaAirflow.text);
      final area = height * length * width;

      _calculatedVolumeACH.text = (airflow * 3.6 / area).toStringAsFixed(1);
    }
  }
}
