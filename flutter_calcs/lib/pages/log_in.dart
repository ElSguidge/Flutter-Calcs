// import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_calcs/pages/homepage.dart';
import 'package:flutter_calcs/pages/register_page.dart';

import '../firestore/functions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Functions func = Functions();

  String email = "";
  String password = "";

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              email = value;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "email"),
          ),
          TextField(
            onChanged: (value) {
              password = value;
            },
            obscureText: true,
            decoration: const InputDecoration(hintText: "password"),
          ),
          ElevatedButton(
              onPressed: () async {
                if (await func.signin(email, password)) {
                  await func.getItemsLogin();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      (route) => false);
                } else {
                  print("Error in Login");
                }
              },
              child: const Text("Login")),
          RichText(
              text: TextSpan(
                  text: "Not a member ? ",
                  style: const TextStyle(color: Colors.black),
                  children: [
                TextSpan(
                    text: "Join now !",
                    style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()),
                          ))
              ])),
        ],
      ),
    );
  }
}
