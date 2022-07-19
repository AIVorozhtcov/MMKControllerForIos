import 'package:flutter/material.dart';
import 'package:multimedia_demo/commonWidgets.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:http/http.dart' as http;
import 'package:joystick/joystick.dart';

import 'my_libraries/globals.dart' as globals;

import 'main.dart';
import 'my_functions/hardwareFunctions.dart';
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
        Positioned.fill(child: backgroundImage()),
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
                sendRequest(
                    "http://127.0.0.1:5000/Api_TV/TVpanel/1/cmd/Power?param1=On&param2=0");
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
