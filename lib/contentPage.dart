import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:http/http.dart' as http;
import 'package:joystick/joystick.dart';

import 'my_libraries/globals.dart' as globals;

import 'main.dart';
import 'vksPage.dart';
import 'homePage.dart';

import 'commonWidgets.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    globals.currentPage = 'Content';
    return Scaffold(
      appBar: AppBar(
        title: Text('Контент'),
      ),
      body: Stack(children: [
        //Center(child: backgroundImage()),
        Center(child: Text('Контент')),
        BottomBar()
      ]),
    );
  }
}
