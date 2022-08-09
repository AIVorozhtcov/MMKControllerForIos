import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:http/http.dart' as http;

import 'my_libraries/globals.dart' as globals;

import 'main.dart';
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

String dialNumber = globals.SizeConfig.screenHeight.toString();

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

  Future<String> contentSwitchResponse = sendRequest(
      "http://10.176.105:8080/Videocom/Test/Model/22/VideoSwitch?param1=3&param2=2");

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
                  height: 50 * globals.SizeConfig.blockSizeVertical,
                  width: 34 * globals.SizeConfig.blockSizeHorizontal,
                  child: Opacity(
                    opacity: 0.7,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue[700],
                          borderRadius: BorderRadius.all(Radius.circular(45)),
                          border: Border.all(width: 1)),
                      child: KeyboardBlock(
                        numberTapCallback: onNumberChanged,
                        numberDeleteCallback: onNumberDeleted,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 42 * globals.SizeConfig.blockSizeHorizontal,
                top: 9 * globals.SizeConfig.blockSizeVertical,
                child: SizedBox(
                    width: 25 * globals.SizeConfig.blockSizeHorizontal,
                    height: 100 * globals.SizeConfig.blockSizeVertical,
                    child: CallInitiationModule()),
              ),
              Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                    width: 34 * globals.SizeConfig.blockSizeHorizontal,
                    height: 100 * globals.SizeConfig.blockSizeVertical,
                    child: CameraControlBlock()),
              ),
              BottomBar()
            ],
          ),
        ));
  }
}
