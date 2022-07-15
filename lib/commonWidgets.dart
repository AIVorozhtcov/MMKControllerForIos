import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:multimedia_demo/tvPage.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:http/http.dart' as http;
import 'package:joystick/joystick.dart';

import 'my_libraries/globals.dart' as globals;

import 'my_functions/hardwareFunctions.dart';
import 'my_functions/internalFunctions.dart';

import 'main.dart';
import 'vksPage.dart';
import 'landingPage.dart';
import 'contentPage.dart';

class KeyboardBlock extends StatefulWidget {
  final numberTapCallback;
  final numberDeleteCallback;
  const KeyboardBlock(
      {Key? key, this.numberTapCallback, this.numberDeleteCallback})
      : super(key: key);

  //final numberDeleteCallback;
  //const KeyboardBlock({this.numberTapCallback});

  @override
  State<KeyboardBlock> createState() => _KeyboardBlockState();
}

class _KeyboardBlockState extends State<KeyboardBlock> {
  numberTap(String value) {
    /*dialNumber = dialNumber + value;*/
    setState(() {
      dialNumber = dialNumber + value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          NumericKeyboard(
              onKeyboardTap: widget.numberTapCallback,
              rightButtonFn: widget.numberDeleteCallback,
              /*() {
                setState(() {
                  dialNumber =
                      dialNumber.substring(0, dialNumber.length - 1);
                });
              }*/
              rightIcon: Icon(
                Icons.backspace,
                color: Colors.red,
              ),
              leftButtonFn: () async {
                widget.numberTapCallback(".");
                /*final numberInfo = await numberRequest(dialNumber);
                print(numberInfo);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(content: Text(numberInfo));
                    });*/

                /*Center(
                    child: FutureBuilder(
                        future: numberInfo,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            print(snapshot);
                            return Text(snapshot.toString());
                          } else {
                            print('Ne udalos');
                            return Text(snapshot.toString());
                          }
                        }),
                  );*/
                /*print(numberInfo);*/
              },
              leftIcon: Icon(
                Icons.circle,
                size: 10,
                color: Colors.black,
              ),
              mainAxisAlignment: MainAxisAlignment.spaceEvenly),
        ],
      ),
    );
  }
}

class VolumeSlider extends StatefulWidget {
  const VolumeSlider({
    Key? key,
  }) : super(key: key);

  @override
  State<VolumeSlider> createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider> {
  double SliderValue = 50;
  bool isMute = false;
  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      IconButton(
          icon: isMute
              ? Icon(Icons.volume_off, size: 40)
              : Icon(Icons.volume_up_rounded, size: 40),
          onPressed: () {
            if (isMute) {
              setState(() {
                isMute = false;
              });
            } else {
              setState(() {
                isMute = true;
              });
            }
          }),
      SizedBox(
        height: 20,
        child: Slider(
            value: SliderValue,
            max: 100,
            onChanged: (double value) {
              setState(() {
                SliderValue = value;
              });
            }),
      ),
    ]);
  }
}

class BottomBar extends StatefulWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(alignment: Alignment(-1.0, 0.9), child: VolumeSlider()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      color: checkPage('Content')
                          ? Colors.grey[600]
                          : Colors.grey[300],
                      border: Border(
                          right: BorderSide(width: 4, color: Colors.blue)),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.content_paste_outlined),
                      onPressed: () {
                        if (!checkPage('Content')) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ContentPage()),
                          );
                        }
                      },
                    ),
                  ),
                  Text('Контент')
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      color: checkPage('VKS')
                          ? Colors.grey[600]
                          : Colors.grey[300],
                    ),
                    child: IconButton(
                        icon: Icon(Icons.phone),
                        onPressed: () {
                          if (!checkPage('VKS')) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const VKSPage()),
                            );
                          }
                        }),
                  ),
                  Text('ВКС')
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 60,
                    decoration: BoxDecoration(
                      color:
                          checkPage('TV') ? Colors.grey[600] : Colors.grey[300],
                      border: Border(
                          left: BorderSide(width: 4, color: Colors.blue)),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.tv),
                      onPressed: () {
                        if (!checkPage('TV')) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TVPage()),
                          );
                        }
                      },
                    ),
                  ),
                  Text('ТВ')
                ],
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment(0.9, 0.9),
          child: IconButton(
              icon: Icon(
                Icons.exit_to_app,
                size: 40,
              ),
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
                                    child: Text('Закрыть контроллер?')),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: ClipOval(
                                    child: Container(
                                      color: Colors.red,
                                      child: IconButton(
                                          icon: Icon(Icons.cancel),
                                          onPressed: () {
                                            Navigator.pop(context);
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
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const landingPage()),
                                            );
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
              }),
        )
      ],
    );
  }
}

class zoomPanel extends StatefulWidget {
  const zoomPanel({
    Key? key,
  }) : super(key: key);

  @override
  State<zoomPanel> createState() => _zoomPanelState();
}

class _zoomPanelState extends State<zoomPanel> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(60),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.blue,
              border: Border.all(width: 5),
              borderRadius: BorderRadius.circular(60)),
          //color: Colors.blue,
          child: Stack(children: [
            Align(
              alignment: Alignment(0.0, -0.8),
              child: InkWell(
                  child: Ink(
                    child: Icon(Icons.zoom_in, size: 40),
                  ),
                  onTapDown: (TapDownDetails) {
                    final requestResponse = zoomCamera("Zoom_plus");
                    print(requestResponse);
                  },
                  onTapUp: (TapUpDetails) {
                    final requestResponse = zoomCamera("Stop");
                    print(requestResponse);

                    setState(() {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                content: Text('Камера перестала приближаться'));
                          });
                    });
                  }),
            ),
            Align(
              alignment: Alignment(0.0, 0.8),
              child: InkWell(
                  child: Ink(
                    child: Icon(Icons.zoom_out, size: 40),
                  ),
                  onTapDown: (TapDownDetails) {
                    final requestResponse = zoomCamera("Zoom_minus");
                    print(requestResponse);
                  },
                  onTapUp: (TapUpDetails) {
                    final requestResponse = zoomCamera("Stop");
                    print(requestResponse);

                    setState(() {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                content: Text('Камера перестала отдаляться'));
                          });
                    });
                  }),
            ),
          ])),
    );
  }
}

class cameraControlCircle extends StatefulWidget {
  const cameraControlCircle({
    Key? key,
  }) : super(key: key);

  @override
  State<cameraControlCircle> createState() => _cameraControlCircleState();
}

class _cameraControlCircleState extends State<cameraControlCircle> {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(width: 5),
            shape: BoxShape.circle),
        //color: Colors.blue,
        child: Stack(children: [
          Align(
            alignment: Alignment.topCenter,
            child: InkWell(
                highlightColor: Colors.transparent,
                enableFeedback: false,
                splashFactory: NoSplash.splashFactory,
                child: Ink(
                  child: Icon(Icons.arrow_circle_up_outlined,
                      size:
                          40 /*Icons.arrow_drop_up  Icons.keyboard_arrow_up*/),
                ),
                onTapDown: (TapDownDetails) {
                  final requestResponse = moveCamera("Up");
                },
                onTapUp: (TapUpDetails) {
                  final requestResponse = moveCamera("Stop");

                  setState(() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              content:
                                  Text('Камера перестала двигаться вверх'));
                        });
                  });
                }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
                highlightColor: Colors.transparent,
                enableFeedback: false,
                splashFactory: NoSplash.splashFactory,
                child: Ink(
                  child: Icon(Icons.arrow_circle_down_outlined, size: 40),
                ),
                onTapDown: (TapDownDetails) {
                  final requestResponse = moveCamera("Down");
                },
                onTapUp: (TapUpDetails) {
                  final requestResponse = moveCamera("Stop");

                  setState(() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              content: Text('Камера перестала двигаться вниз'));
                        });
                  });
                }),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
                highlightColor: Colors.transparent,
                enableFeedback: false,
                splashFactory: NoSplash.splashFactory,
                child: Ink(
                  child: Icon(Icons.arrow_circle_left_outlined, size: 40),
                ),
                onTapDown: (TapDownDetails) {
                  final requestResponse = moveCamera("Left");
                },
                onTapUp: (TapUpDetails) {
                  final requestResponse = moveCamera("Stop");

                  setState(() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              content:
                                  Text('Камера перестала двигаться влево'));
                        });
                  });
                }),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
                highlightColor: Colors.transparent,
                enableFeedback: false,
                splashFactory: NoSplash.splashFactory,
                child: Ink(
                  child: Icon(Icons.arrow_circle_right_outlined, size: 40),
                ),
                onTapDown: (TapDownDetails) {
                  final requestResponse = moveCamera("Right");
                },
                onTapUp: (TapUpDetails) {
                  final requestResponse = moveCamera("Stop");

                  setState(() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              content:
                                  Text('Камера перестала двигаться вправо'));
                        });
                  });
                }),
          ),
          /*Center(
              child: OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey)),
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    final numberInfo = await numberRequest(dialNumber);
                    print(numberInfo);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(content: Text(numberInfo));
                        });
                  }))
        */
        ]),
      ),
    );
  }
}

Widget backgroundImage() => ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        color: Colors.black,
        child: Opacity(
          opacity: 0.8,
          child: Image.network(
            'https://images.unsplash.com/photo-1569317002804-ab77bcf1bce4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );

Widget stepLogo() => ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        color: Colors.black,
        child: Opacity(
          opacity: 0.8,
          child: Image.network(
            'assets/StepLogo.jpg',
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
