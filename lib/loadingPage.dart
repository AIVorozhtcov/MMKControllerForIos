import 'package:flutter/material.dart';
import 'package:multimedia_demo/commonWidgets.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'dart:async';

import 'my_libraries/globals.dart' as globals;

import 'main.dart';
import 'my_functions/hardwareFunctions.dart';
import 'homePage.dart';
import 'landingPage.dart';

class loadingPage extends StatefulWidget {
  const loadingPage({
    Key? key,
  }) : super(key: key);

  @override
  State<loadingPage> createState() => _loadingPageState();
}

class _loadingPageState extends State<loadingPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      if (globals.currentPage == "Landing") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const landingPage()),
        );
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned.fill(child: backgroundImage()),
        Center(
            child: Text(
          'Загрузка',
          style: TextStyle(fontSize: 80),
        )),
      ]),
    );
  }
}
