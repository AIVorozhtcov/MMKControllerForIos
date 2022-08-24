import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:http/http.dart' as http;

import 'my_libraries/globals.dart' as globals;

import 'main.dart';
import 'Numpad.dart';
import 'contentPage.dart';
import 'commonWidgets.dart';
import 'my_functions/hardwareFunctions.dart';
import 'callInitiationModule.dart';
import 'cameraControlModule.dart';

class VKSPage extends StatefulWidget {
  const VKSPage({
    Key? key,
  }) : super(key: key);

  @override
  State<VKSPage> createState() => _VKSPageState();
}

/*String dialNumber = 'h' +
    globals.SizeConfig.screenHeight.toString() +
    'v' +
    globals.SizeConfig.screenWidth.toString() +
    'd' +
    globals.SizeConfig.screenDiagonal.toString();*/
String dialNumber = '';

class _VKSPageState extends State<VKSPage> {
  onNumberChanged(String newNumberString) {
    setState(() {
      dialNumber = newNumberString;
      //dialNumber = dialNumber + newNumberString;
    });
  }

  onNumberDeleted() {
    setState(() {
      dialNumber = dialNumber.substring(0, dialNumber.length - 1);
    });
  }

  Future<String> contentSwitchResponse = sendRequest(
      "http://10.176.252.105:8080/Videocom/Test/Model/22/VideoSwitch?param1=3&param2=2");

  @override
  Widget build(BuildContext context) {
    globals.SizeConfig().init(context);
    globals.currentPage = 'VKS';

    String dialNumber = globals.SizeConfig.screenHeight.toString();

    return Scaffold(
        appBar: AppBar(
          title: Text('ВКС'),
        ),
        body: Container(
          /*decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/pexels-2.jpg"),
              fit: BoxFit.cover,
            ),
          ),*/
          child: Stack(
            children: [
              Positioned.fill(child: backgroundImage()),
              Positioned(
                top: 25 * globals.SizeConfig.blockSizeVertical,
                left: 2 * globals.SizeConfig.blockSizeHorizontal,
                child: SizedBox(
                  height: 55 * globals.SizeConfig.blockSizeVertical,
                  width: 35 * globals.SizeConfig.blockSizeHorizontal,
                  child: Opacity(
                    opacity: 0.7,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue[700],
                          borderRadius: BorderRadius.all(Radius.circular(45)),
                          border: Border.all(width: 1)),
                      child: Numpad(
                          length: 20,
                          onChange:
                              onNumberChanged) /*KeyboardBlock(
                        numberTapCallback: onNumberChanged,
                        numberDeleteCallback: onNumberDeleted,
                      )*/
                      ,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 39 * globals.SizeConfig.blockSizeHorizontal,
                top: 9 * globals.SizeConfig.blockSizeVertical,
                child: SizedBox(
                    width: 27 * globals.SizeConfig.blockSizeHorizontal,
                    height: 100 * globals.SizeConfig.blockSizeVertical,
                    child: CallInitiationModule()),
              ),
              Positioned(
                left: 68 * globals.SizeConfig.blockSizeHorizontal,
                top: 1 * globals.SizeConfig.blockSizeVertical,
                child: SizedBox(
                    width: 31 * globals.SizeConfig.blockSizeHorizontal,
                    height: 100 * globals.SizeConfig.blockSizeVertical,
                    child: CameraControlBlock()),
              ),
              BottomBar()
            ],
          ),
        ));
  }
}
