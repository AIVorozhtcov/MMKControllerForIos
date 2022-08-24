import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:multimedia_demo/my_libraries/globals.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:http/http.dart' as http;
import 'vksPage.dart';
import 'main.dart';
import 'my_functions/hardwareFunctions.dart';
import 'my_functions/internalFunctions.dart';
import 'contentPage.dart';

class CallInitiationModule extends StatefulWidget {
  const CallInitiationModule({
    Key? key,
  }) : super(key: key);

  @override
  State<CallInitiationModule> createState() => _CallInitiationModuleState();
}

class _CallInitiationModuleState extends State<CallInitiationModule> {
  bool _micMute = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment(-0.1, -0.4),
          child: OutlinedButton(
            style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(
                    13 * SizeConfig.blockSizeHorizontal,
                    8 * SizeConfig.blockSizeVertical)),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0)))),
            child: Text(
              'Контент',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 1.5 * SizeConfig.blockSizeDiagonal),
            ),
            onPressed: () {
              if (!checkPage('Content')) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ContentPage()),
                );
              }
            },
          ),
        ),
        Align(
          alignment: Alignment(-0.2, -1.0),
          child: SizedBox(
              height: 8 * SizeConfig.blockSizeVertical,
              width: 22.9 * SizeConfig.blockSizeHorizontal,
              child: Container(
                child: Center(
                    child: Text(
                  dialNumber,
                  style: TextStyle(
                      fontSize: 1.75 * SizeConfig.blockSizeDiagonal,
                      fontWeight: FontWeight.bold),
                )),
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width:
                          2) /*Border(bottom: BorderSide(width: 5, color: Colors.black))*/,
                ),
              )),
        ),
        Align(
          alignment: Alignment(0.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RawMaterialButton(
                onPressed: () {
                  final requestResponse = makeCall(dialNumber.toString());
                  print(requestResponse);
                  setState(() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              content: Text('Звонок по номеру ' + dialNumber));
                        });
                  });
                },
                elevation: 2.0,
                fillColor: Colors.green,
                child: Icon(
                  Icons.call,
                  color: Colors.white,
                  size: /*(SizeConfig.screenHeight > 800)
                      ? 50
                      : 30*/
                      3 * SizeConfig.blockSizeDiagonal,
                ),
                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal),
                shape: CircleBorder(),
              ),
              RawMaterialButton(
                onPressed: () {
                  String tempResponse = '';
                  if (_micMute) {
                    () {};
                    setState(() {
                      final requestResponse = emulateIR("Mute");
                      print(requestResponse);
                      //tempResponse = requestResponse;
                      _micMute = false;
                    });
                  } else {
                    final requestResponse = emulateIR("Mute");
                    print(requestResponse);

                    setState(() {
                      _micMute = true;
                    });
                  }
                },
                elevation: 2.0,
                fillColor: _micMute ? Colors.grey : Colors.white,
                child: _micMute ? Icon(Icons.mic_off) : Icon(Icons.mic),
                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal),
                shape: CircleBorder(),
              ),
              RawMaterialButton(
                onPressed: () {
                  setState(() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SizedBox(
                              height: 16.5 * SizeConfig.blockSizeVertical,
                              width: 12.5 * SizeConfig.blockSizeHorizontal,
                              child: Stack(
                                children: [
                                  Align(
                                      alignment: Alignment.topCenter,
                                      child: Text('Завершить звонок?')),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: ClipOval(
                                      child: Container(
                                        color: Colors.red,
                                        child: IconButton(
                                            icon: Icon(Icons.cancel),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              setState(() {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                          content: Text(
                                                              'Завершение вызова отменено'));
                                                    });
                                              });
                                            }),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: ClipOval(
                                      child: Container(
                                        color: Colors.green,
                                        child: IconButton(
                                            icon: Icon(Icons.check),
                                            onPressed: () {
                                              final requestResponse =
                                                  polycomHangup("All");

                                              print(requestResponse);

                                              Navigator.pop(context);

                                              setState(() {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                          content: Text(
                                                              'Звонок завершен'));
                                                    });
                                              });
                                            }),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  });
                },
                elevation: 2.0,
                fillColor: Colors.red,
                child: Icon(
                  Icons.call_end,
                  color: Colors.white,
                  size: 3.0 * SizeConfig.blockSizeDiagonal,
                ),
                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal),
                shape: CircleBorder(),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: OutlinedButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(
                    10 * SizeConfig.blockSizeHorizontal,
                    3 * SizeConfig.blockSizeVertical)),
              ),
              child: Text("Контfgент"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContentPage()),
                );
              }),
        ),
      ],
    );
  }
}
