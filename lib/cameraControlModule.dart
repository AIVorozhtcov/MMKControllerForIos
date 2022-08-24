import 'package:flutter/material.dart';
import 'package:multimedia_demo/my_libraries/globals.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:http/http.dart' as http;

import 'my_functions/hardwareFunctions.dart';
import 'my_functions/internalFunctions.dart';

import 'vksPage.dart';
import 'main.dart';
import 'commonWidgets.dart';

class CameraControlBlock extends StatefulWidget {
  const CameraControlBlock({
    Key? key,
  }) : super(key: key);

  @override
  State<CameraControlBlock> createState() => _CameraControlBlockState();
}

class _CameraControlBlockState extends State<CameraControlBlock> {
  String _passwordNumber = '';

  onNumberChanged(String newNumberString) {
    setState(() {
      _passwordNumber = _passwordNumber + newNumberString;
    });
  }

  onNumberDeleted() {
    setState(() {
      _passwordNumber =
          _passwordNumber.substring(0, _passwordNumber.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
            alignment: Alignment(-0.5, 0.0),
            child: SizedBox(
                height: 13.3 * SizeConfig.blockSizeDiagonal,
                width: 13.3 * SizeConfig.blockSizeDiagonal,
                child: cameraControlCircle())),
        Align(
            alignment: Alignment(0.7, 0.0),
            child: SizedBox(
                height: 20 * SizeConfig.blockSizeVertical,
                width: 4 * SizeConfig.blockSizeHorizontal,
                child: zoomPanel())),
        /*Align(
          alignment: Alignment(-0.6, 0.67),
          child: SizedBox(
            width: 7.5 * SizeConfig.blockSizeHorizontal,
            height: 15 * SizeConfig.blockSizeVertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 10 * SizeConfig.blockSizeVertical,
                  width: 5 * SizeConfig.blockSizeHorizontal,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 1)),
                  child: IconButton(
                      icon: Icon(Icons.password,
                          size: 7 * SizeConfig.blockSizeVertical),
                      onPressed: () {
                        setState(() {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                onNumberChanged(String newNumberString) {
                                  setState(() {
                                    _passwordNumber =
                                        _passwordNumber + newNumberString;
                                  });
                                }

                                onNumberDeleted() {
                                  setState(() {
                                    _passwordNumber = _passwordNumber.substring(
                                        0, _passwordNumber.length - 1);
                                  });
                                }

                                return AlertDialog(
                                    content: Column(children: [
                                  Text(_passwordNumber.toString()),
                                  KeyboardBlock(
                                    numberTapCallback: onNumberChanged,
                                    numberDeleteCallback: onNumberDeleted,
                                  )
                                ]));
                              });
                        });
                      }),
                ),
                Align(
                    alignment: Alignment(-0.5, 1.0),
                    child: Text(
                      'Пароль',
                      style:
                          TextStyle(fontSize: 2 * SizeConfig.blockSizeVertical),
                    ))
              ],
            ),
          ),
        ),*/
        Align(
          alignment: Alignment(0.1, 0.7),
          child: SizedBox(
            width: 6.5 * SizeConfig.blockSizeDiagonal,
            height: 6.5 * SizeConfig.blockSizeDiagonal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 4.5 * SizeConfig.blockSizeDiagonal,
                  width: 4.5 * SizeConfig.blockSizeDiagonal,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 1)),
                  child: IconButton(
                      icon: Icon(Icons.smart_screen,
                          size: 3 * SizeConfig.blockSizeDiagonal),
                      onPressed: () {
                        setState(() {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: CameraViews(),
                                );
                              });
                        });
                      }),
                ),
                Align(
                  alignment: Alignment(-0.7, 0.8),
                  child: Text('''Пресеты''',
                      style: TextStyle(fontSize: SizeConfig.blockSizeDiagonal)),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CameraViews extends StatefulWidget {
  const CameraViews({
    Key? key,
  }) : super(key: key);

  @override
  State<CameraViews> createState() => _CameraViewsState();
}

class _CameraViewsState extends State<CameraViews> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            OutlinedButton(
                child: Text('1'),
                onPressed: () {
                  final requestResponse = useCameraPreset("1");
                  print(requestResponse);

                  setState(() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text('Первый вид камеры'),
                          );
                        });
                  });
                }),
            OutlinedButton(
                child: Text('2'),
                onPressed: () {
                  final requestResponse = useCameraPreset("2");
                  print(requestResponse);

                  setState(() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text('Второй вид камеры'),
                          );
                        });
                  });
                })
          ],
        ),
        Row(
          children: [
            OutlinedButton(
                child: Text('3'),
                onPressed: () {
                  final requestResponse = useCameraPreset("3");
                  print(requestResponse);

                  setState(() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text('Третий вид камеры'),
                          );
                        });
                  });
                }),
            OutlinedButton(
                child: Text('4'),
                onPressed: () {
                  final requestResponse = useCameraPreset("4");
                  print(requestResponse);

                  setState(() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text('Четвертый вид камеры'),
                          );
                        });
                  });
                })
          ],
        )
      ],
    );
  }
}
