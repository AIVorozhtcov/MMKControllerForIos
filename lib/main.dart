import 'dart:convert';

import 'my_libraries/globals.dart' as globals;

import 'package:flutter/material.dart';
import 'package:multimedia_demo/landingPage.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:http/http.dart' as http;

import 'my_functions/hardwareFunctions.dart';
import 'vksPage.dart';
import 'homePage.dart';
import 'contentPage.dart';
import 'commonWidgets.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  //Future<String> initVolumeResponse = sendRequest("http://localhost:5000/Videocom/Test/Model/22/AudioOut?param1=1&param2=50");

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //globals.SizeConfig().init(context);
    return MaterialApp(
      title: 'MMC Demo',
      /*builder: (context, widget) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, widget!),
        defaultScale: true,
        //breakpoints: const [
        //ResponsiveBreakpoint.autoScale(1, name: 'ONESIZE'),
        //ResponsiveBreakpoint.autoScale(10000, name: 'TWOSIZE'),
        //],
      ),*/
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const landingPage(),
    );
  }
}
