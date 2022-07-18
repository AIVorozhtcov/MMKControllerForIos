import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:http/http.dart' as http;
import 'package:joystick/joystick.dart';
import 'vksPage.dart';
import 'main.dart';
import 'my_functions/hardwareFunctions.dart';
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
          alignment: Alignment(-0.2, -1.0),
          child: SizedBox(
              height: 75,
              width: 225,
              child: Container(
                child: Center(
                    child: Text(
                  dialNumber,
                  style: TextStyle(fontSize: 32),
                )),
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(width: 5, color: Colors.black)),
                ),
              )),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
                  size: 35.0,
                ),
                padding: EdgeInsets.all(15.0),
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
                padding: EdgeInsets.all(15.0),
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
                              height: 100,
                              width: 150,
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
                  size: 35.0,
                ),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: OutlinedButton(
              child: Text("Контент"),
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
