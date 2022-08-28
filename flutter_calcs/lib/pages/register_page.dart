import 'package:flutter/material.dart';
import 'package:flutter_calcs/pages/homepage.dart';
import 'package:flutter_calcs/firestore/functions.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Functions func = Functions();

  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
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
          TextField(
            onChanged: (value) {
              password = value;
            },
            obscureText: true,
            decoration: const InputDecoration(hintText: "confirm password"),
          ),
          ElevatedButton(
              onPressed: () async {
                if (await func.register(email, password)) {
                  await func.getItems();
                  print(func.bookmarks);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      (route) => false);
                } else {
                  print("Error in Registration");
                }
              },
              child: const Text("Register")),
        ],
      ),
    );
  }
}
