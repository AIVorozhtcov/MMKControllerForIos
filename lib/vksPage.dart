import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:http/http.dart' as http;
import 'package:joystick/joystick.dart';

import 'my_libraries/globals.dart' as globals;

import 'main.dart';
import 'contentPage.dart';
import 'commonWidgets.dart';
import 'callInitiationModule.dart';
import 'cameraControlModule.dart';

class VKSPage extends StatefulWidget {
  const VKSPage({
    Key? key,
  }) : super(key: key);

  @override
  State<VKSPage> createState() => _VKSPageState();
}

String dialNumber = '';

class _VKSPageState extends State<VKSPage> {
  onNumberChanged(String newNumberString) {
    setState(() {
      dialNumber = dialNumber + newNumberString;
    });
  }

  onNumberDeleted() {
    setState(() {
      dialNumber = dialNumber.substring(0, dialNumber.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    globals.currentPage = 'VKS';

    return Scaffold(
        appBar: AppBar(
          title: Text('ВКС'),
        ),
        body: Stack(
          children: [
            Positioned(
              top: 150,
              left: 20,
              child: SizedBox(
                height: 300,
                width: 400,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300], border: Border.all(width: 1)),
                  child: KeyboardBlock(
                    numberTapCallback: onNumberChanged,
                    numberDeleteCallback: onNumberDeleted,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 500,
              top: 50,
              child: SizedBox(
                  width: 300, height: 600, child: CallInitiationModule()),
            ),
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                  width: 400, height: 600, child: CameraControlBlock()),
            ),
            BottomBar()
          ],
        ));
  }
}
