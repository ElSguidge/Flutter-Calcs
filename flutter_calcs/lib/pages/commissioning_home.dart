import 'package:flutter/material.dart';
import 'package:flutter_calcs/constants/color_constants.dart';
import 'package:flutter_calcs/constants/constants.dart';
import 'package:flutter_calcs/widgets/app_buttons.dart';
import 'package:flutter_calcs/widgets/custom_drawer.dart';

import '../widgets/list_buttons.dart';

class Menu {
  final String menuButton;
  final String nav;
  const Menu({required this.menuButton, required this.nav});
}

// ignore: must_be_immutable
class CommissioningPage extends StatelessWidget {
  List<Menu> items = [
    const Menu(menuButton: 'TAB Calculators', nav: calculators),
    const Menu(menuButton: 'Conversions', nav: conversions),
    const Menu(menuButton: 'Abbreviations', nav: homeRoute),
    const Menu(menuButton: 'Favourites', nav: favoritePage),
    const Menu(menuButton: 'Procedures', nav: homeRoute),
    const Menu(menuButton: 'Instructional', nav: homeRoute),
  ];

  CommissioningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Commissioning',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: ColorConstants.darkScaffoldBackgroundColor,
      ),
      drawer: const CustomDrawer(),
      backgroundColor: ColorConstants.lightScaffoldBackgroundColor,
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 3.0, 0.0),
                child: MaterialButton(
                  minWidth: 5,
                  color: ColorConstants.messageColor,
                  textColor: Colors.white,
                  child: const Icon(Icons.home),
                  onPressed: () =>
                      {Navigator.pushNamed(context, commissioningHome)},
                  splashColor: const Color(0xFFa78bfa),
                ),
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final calculations = items[index];
              return InkWell(
                splashColor: const Color(0xFFa78bfa),
                onTap: () {
                  Navigator.pushNamed(context, calculations.nav);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListButtons(
                    textColor: Colors.white,
                    backgroundColor: ColorConstants.darkScaffoldBackgroundColor,
                    borderColor: Colors.grey[900]!,
                    text: calculations.menuButton,
                    size: 21,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
