import 'package:flutter/material.dart';
import 'package:flutter_calcs/constants/color_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_calcs/constants/constants.dart';

class OpeningView extends StatefulWidget {
  const OpeningView({Key? key}) : super(key: key);

  @override
  OpeningViewState createState() => OpeningViewState();
}

class OpeningViewState extends State<OpeningView> {
  OpeningViewState();

  String? word;

  @override
  void initState() {
    super.initState();
    retrieve();
  }

  retrieve() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      word = prefs.getString("displayName");
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    final logo = Image.asset(
      "lib/icons/agc-logo-white.png",
      // height: mq.size.height / 6,
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(8.0),
      color: ColorConstants.darkScaffoldBackgroundColor,
      child: MaterialButton(
        minWidth: mq.size.width / 1.2,
        padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: const Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, logIn);
        },
      ),
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(8.0),
      color: ColorConstants.darkScaffoldBackgroundColor,
      child: MaterialButton(
        minWidth: mq.size.width / 1.2,
        padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: const Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, registerPage);
        },
      ),
    );

    final buttons = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        loginButton,
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 70),
          child: registerButton,
        ),
      ],
    );

    display() {
      if (word != null) {
        return Text(
          "Welcome back $word!",
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        );
      } else {
        return const Text(
          "Welcome!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: ColorConstants.lightScaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: logo,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 50),
              child: display(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 50),
              child: buttons,
            )
          ],
        ),
      ),
    );
  }
}
