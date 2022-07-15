import 'package:flutter/material.dart';
import 'package:multimedia_demo/commonWidgets.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:http/http.dart' as http;
import 'package:joystick/joystick.dart';

import 'my_libraries/globals.dart' as globals;

import 'main.dart';
import 'homePage.dart';

class landingPage extends StatefulWidget {
  const landingPage({
    Key? key,
  }) : super(key: key);

  @override
  State<landingPage> createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {
  @override
  Widget build(BuildContext context) {
    globals.currentPage = "Landing";
    return Scaffold(
        body: Stack(
      children: [
        Center(child: stepLogo()),
        Center(
          child: OutlinedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              child: Text(
                "Начать",
                style: TextStyle(
                    backgroundColor: Colors.blue,
                    color: Colors.black,
                    fontSize: 30),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              }),
        ),
      ],
    ));
  }
}
