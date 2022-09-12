import 'package:flutter/material.dart';
import 'package:flutter_calcs/constants/color_constants.dart';
import 'package:flutter_calcs/constants/constants.dart';
import 'package:flutter_calcs/widgets/app_buttons.dart';
import 'package:flutter_calcs/widgets/custom_drawer.dart';

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
          GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: items.length,
            itemBuilder: (BuildContext ctx, index) {
              final buttons = items[index];

              return InkWell(
                // padding: const EdgeInsets.fromLTRB(10, 20, 10, 40),
                onTap: () {
                  Navigator.pushNamed(context, buttons.nav);
                },
                child: AppButtons(
                  textColor: Colors.white,
                  backgroundColor: ColorConstants.darkScaffoldBackgroundColor,
                  borderColor: Colors.grey[900]!,
                  text: buttons.menuButton,
                  size: 20,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
