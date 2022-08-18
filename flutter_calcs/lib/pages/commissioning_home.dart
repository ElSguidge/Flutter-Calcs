import 'package:flutter/material.dart';
import 'package:flutter_calcs/constants/constants.dart';
import 'package:flutter_calcs/widgets/app_buttons.dart';

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
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        backgroundColor: const Color(0xFF111827),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              const DrawerHeader(
                child: Center(
                  child: Image(
                    image: AssetImage('lib/icons/cropped-AGC_Logo_2022.png'),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pushNamed(context, homeRoute);
                },
              ),
              ListTile(
                leading: const Icon(Icons.build),
                title: const Text('Install'),
                onTap: () {
                  Navigator.pushNamed(context, installHome);
                },
              ),
              ListTile(
                leading: const Icon(Icons.assignment_turned_in_sharp),
                title: const Text('Commissioning'),
                onTap: () {
                  Navigator.pushNamed(context, commissioningHome);
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFF111827),

      // ignore: avoid_unnecessary_containers
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
                  color: const Color(0xFF22c55e),
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
                  backgroundColor: const Color(0xFF6b7280),
                  borderColor: Colors.grey[200]!,
                  text: buttons.menuButton,
                  size: 17,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
