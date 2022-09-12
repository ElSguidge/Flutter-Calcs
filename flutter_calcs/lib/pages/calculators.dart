import 'package:flutter/material.dart';
import 'package:flutter_calcs/constants/color_constants.dart';
import 'package:flutter_calcs/constants/constants.dart';
import 'package:flutter_calcs/widgets/custom_drawer.dart';
import 'package:flutter_calcs/widgets/list_buttons.dart';

class Menu {
  final String menuButton;
  final String nav;
  const Menu({required this.menuButton, required this.nav});
}

// ignore: must_be_immutable
class CalculatorsHome extends StatelessWidget {
  List<Menu> items = [
    const Menu(menuButton: 'Air', nav: air),
    const Menu(menuButton: 'Hydronic', nav: hydronic),
    const Menu(menuButton: 'Electrical', nav: electrical),
  ];
  CalculatorsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TAB Calculators',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorConstants.darkScaffoldBackgroundColor,
      ),
      drawer: const CustomDrawer(),
      backgroundColor: ColorConstants.lightScaffoldBackgroundColor,

      // ignore: avoid_unnecessary_containers
      body: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 5.0, 3.0, 5.0),
                child: MaterialButton(
                  minWidth: 5,
                  color: ColorConstants.secondaryDarkAppColor,
                  textColor: Colors.white,
                  child: const Icon(Icons.home),
                  onPressed: () =>
                      {Navigator.pushNamed(context, commissioningHome)},
                  splashColor: const Color(0xFFa78bfa),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                child: MaterialButton(
                  minWidth: 5,
                  color: ColorConstants.messageColor,
                  textColor: Colors.white,
                  child: const Text('TAB'),
                  onPressed: () => {Navigator.pushNamed(context, calculators)},
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
                splashColor: const Color(0xFFa78bfa),

                // padding: const EdgeInsets.fromLTRB(10, 20, 10, 40),
                onTap: () {
                  Navigator.pushNamed(context, buttons.nav);
                },
                child: ListButtons(
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
