import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:multimedia_demo/tvPage.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:http/http.dart' as http;

import 'my_libraries/globals.dart' as globals;

import 'my_functions/hardwareFunctions.dart';
import 'my_functions/internalFunctions.dart';

import 'loadingPage.dart';
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
                size: globals.SizeConfig.blockSizeDiagonal,
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
  bool isMute = false;
  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      IconButton(
          icon: isMute
              ? Icon(Icons.volume_off,
                  size: 3 * globals.SizeConfig.blockSizeDiagonal)
              : Icon(Icons.volume_up_rounded,
                  size: 3 * globals.SizeConfig.blockSizeDiagonal),
          onPressed: () {
            if (isMute) {
              setState(() {
                isMute = false;
                String volumeChangeRequest =
                    "http://10.176.252.105:8080/Videocom/Test/Model/22/AudioOut?param1=1&param2=" +
                        globals.volumeValue.toString();
                sendRequest(volumeChangeRequest);
              });
            } else {
              setState(() {
                isMute = true;
                String volumeChangeRequest =
                    "http://10.176.252.105:8080/Videocom/Test/Model/22/AudioOut?param1=1&param2=" +
                        "0";
                sendRequest(volumeChangeRequest);
              });
            }
          }),
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 0.5 * globals.SizeConfig.blockSizeHorizontal),
        child: SizedBox(
          height: 1.5 * globals.SizeConfig.blockSizeVertical,
          child: Slider(
            value: globals.volumeValue,
            max: 100,
            onChanged: (double value) {
              setState(() {
                globals.volumeValue = value;
              });
            },
            onChangeEnd: (double value) {
              globals.volumeValue = value.roundToDouble();
              String volumeChangeRequest =
                  "http://10.176.252.105:8080/Videocom/Test/Model/22/AudioOut?param1=1&param2=" +
                      globals.volumeValue.toString();
              sendRequest(volumeChangeRequest);
            },
          ),
        ),
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
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.5 * globals.SizeConfig.blockSizeHorizontal),
                child: Container(
                  height: 8.5 * globals.SizeConfig.blockSizeVertical,
                  width: 11 * globals.SizeConfig.blockSizeHorizontal,
                  decoration: BoxDecoration(),
                  child: OutlinedButton(
                    style: ButtonStyle(
                        backgroundColor: checkPage('Content')
                            ? MaterialStateProperty.all(Colors.purple[400])
                            : MaterialStateProperty.all(Colors.transparent),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(18.0)))),
                    child: Center(
                        child: Text('Контент',
                            style: TextStyle(
                                color: Colors.black,
                                //fontWeight: FontWeight.bold,
                                fontSize: 1.5 *
                                    globals.SizeConfig.blockSizeDiagonal))),
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
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.5 * globals.SizeConfig.blockSizeHorizontal),
                child: Container(
                  height: 8.5 * globals.SizeConfig.blockSizeVertical,
                  width: 11 * globals.SizeConfig.blockSizeHorizontal,
                  decoration: BoxDecoration(),
                  child: OutlinedButton(
                      style: ButtonStyle(
                          backgroundColor: checkPage('VKS')
                              ? MaterialStateProperty.all(Colors.purple[400])
                              : MaterialStateProperty.all(Colors.transparent),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0)))),
                      child: Text(
                        'ВКС',
                        style: TextStyle(
                            color: Colors.black,
                            //fontWeight: FontWeight.bold,
                            fontSize:
                                1.5 * globals.SizeConfig.blockSizeDiagonal),
                      ),
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
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.5 * globals.SizeConfig.blockSizeHorizontal),
                child: Container(
                  height: 8.5 * globals.SizeConfig.blockSizeVertical,
                  width: 11 * globals.SizeConfig.blockSizeHorizontal,
                  decoration: BoxDecoration(

                      /*border: Border(
                          left: BorderSide(width: 1.0, color: Colors.blue)),
                      borderRadius: BorderRadius.all(Radius.circular(45))*/
                      ),
                  child: OutlinedButton(
                    style: ButtonStyle(
                        backgroundColor: checkPage('TV')
                            ? MaterialStateProperty.all(Colors.purple[400])
                            : MaterialStateProperty.all(Colors.transparent),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(18.0)))),
                    child: Center(
                        child: Text('ТВ',
                            style: TextStyle(
                                color: Colors.black,
                                //fontWeight: FontWeight.bold,
                                fontSize: 1.5 *
                                    globals.SizeConfig.blockSizeDiagonal))),
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
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment(0.9, 0.9),
          child: IconButton(
              icon: Icon(
                Icons.exit_to_app,
                size: 3 * globals.SizeConfig.blockSizeDiagonal,
              ),
              onPressed: () {
                setState(() {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: SizedBox(
                            height: 16.5 * globals.SizeConfig.blockSizeVertical,
                            width:
                                12.5 * globals.SizeConfig.blockSizeHorizontal,
                            child: Stack(
                              children: [
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: Text('Выключить панель?')),
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
                                            sendRequest(
                                                "http://10.176.252.105:8080/Api_TV/TVpanel/1/cmd/Power?param1=Off&param2=0");
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const loadingPage()),
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
      child: Opacity(
        opacity: 0.7,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.blue[700],
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(60)),
            //color: Colors.blue,
            child: Stack(children: [
              Align(
                alignment: Alignment(0.0, -0.8),
                child: InkWell(
                    child: Ink(
                      child: Icon(Icons.zoom_in,
                          size: 3.5 * globals.SizeConfig.blockSizeDiagonal),
                    ),
                    onTapDown: (TapDownDetails) {
                      final requestResponse = zoomCamera("Zoom_plus");
                      print(requestResponse);
                    },
                    onTapUp: (TapUpDetails) {
                      final requestResponse = zoomCamera("Stop");
                      print(requestResponse);

                      /*setState(() {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  content:
                                      Text('Камера перестала приближаться'));
                            });
                      });*/
                    }),
              ),
              Center(
                  child: Text(
                "ZOOM",
                style: TextStyle(
                    fontSize: 1 * globals.SizeConfig.blockSizeDiagonal),
              )),
              Align(
                alignment: Alignment(0.0, 0.8),
                child: InkWell(
                    child: Ink(
                      child: Icon(Icons.zoom_out,
                          size: 3.5 * globals.SizeConfig.blockSizeDiagonal),
                    ),
                    onTapDown: (TapDownDetails) {
                      final requestResponse = zoomCamera("Zoom_minus");
                      print(requestResponse);
                    },
                    onTapUp: (TapUpDetails) {
                      final requestResponse = zoomCamera("Stop");
                      print(requestResponse);

                      /*setState(() {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  content: Text('Камера перестала отдаляться'));
                            });
                      });*/
                    }),
              ),
            ])),
      ),
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
      child: Opacity(
        opacity: 0.7,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blue[700],
              border: Border.all(width: 1),
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
                    child: Icon(Icons.keyboard_arrow_up,
                        size: 3 *
                            globals.SizeConfig
                                .blockSizeDiagonal /*Icons.arrow_drop_up  Icons.arrow_circle_up_outlined*/),
                  ),
                  onTapDown: (TapDownDetails) {
                    final requestResponse = moveCamera("Up");
                  },
                  onTapUp: (TapUpDetails) {
                    final requestResponse = moveCamera("Stop");

                    /*setState(() {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                content:
                                    Text('Камера перестала двигаться вверх'));
                          });
                    });*/
                  }),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                  highlightColor: Colors.transparent,
                  enableFeedback: false,
                  splashFactory: NoSplash.splashFactory,
                  child: Ink(
                    child: Icon(Icons.keyboard_arrow_down,
                        size: 3 * globals.SizeConfig.blockSizeDiagonal),
                  ),
                  onTapDown: (TapDownDetails) {
                    final requestResponse = moveCamera("Down");
                  },
                  onTapUp: (TapUpDetails) {
                    final requestResponse = moveCamera("Stop");

                    /*setState(() {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                content:
                                    Text('Камера перестала двигаться вниз'));
                          });
                    });*/
                  }),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                  highlightColor: Colors.transparent,
                  enableFeedback: false,
                  splashFactory: NoSplash.splashFactory,
                  child: Ink(
                    child: Icon(Icons.keyboard_arrow_left,
                        size: 3 * globals.SizeConfig.blockSizeDiagonal),
                  ),
                  onTapDown: (TapDownDetails) {
                    final requestResponse = moveCamera("Left");
                  },
                  onTapUp: (TapUpDetails) {
                    final requestResponse = moveCamera("Stop");

                    /*setState(() {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                content:
                                    Text('Камера перестала двигаться влево'));
                          });
                    });*/
                  }),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                  highlightColor: Colors.transparent,
                  enableFeedback: false,
                  splashFactory: NoSplash.splashFactory,
                  child: Ink(
                    child: Icon(Icons.keyboard_arrow_right,
                        size: 3 * globals.SizeConfig.blockSizeDiagonal),
                  ),
                  onTapDown: (TapDownDetails) {
                    final requestResponse = moveCamera("Right");
                  },
                  onTapUp: (TapUpDetails) {
                    final requestResponse = moveCamera("Stop");

                    /*setState(() {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                content:
                                    Text('Камера перестала двигаться вправо'));
                          });
                    });*/
                  }),
            ),
            Center(
              child: ClipOval(
                child: Container(
                  height: 4 * globals.SizeConfig.blockSizeDiagonal,
                  width: 4 * globals.SizeConfig.blockSizeDiagonal,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: OutlinedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      child: Text(
                        'OK',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize:
                                0.75 * globals.SizeConfig.blockSizeDiagonal),
                      ),
                      onPressed: () async {
                        final numberInfo = await numberRequest(dialNumber);
                        print(numberInfo);
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(content: Text(numberInfo));
                            });
                      }),
                ),
              ),
            )
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
                    }))*/
          ]),
        ),
      ),
    );
  }
}

class commutationRow extends StatefulWidget {
  final commutationAddress;
  const commutationRow({
    this.commutationAddress,
    Key? key,
  }) : super(key: key);

  @override
  State<commutationRow> createState() => _commutationRowState();
}

class _commutationRowState extends State<commutationRow> {
  String commutationInput = '';
  String commutationOutput = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16.5 * globals.SizeConfig.blockSizeVertical,
      width: 83 * globals.SizeConfig.blockSizeHorizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("INPUT:"),
          Container(
            width: 12.5 * globals.SizeConfig.blockSizeHorizontal,
            child: TextField(
              onChanged: (String inputValue) {
                commutationInput = inputValue;
              },
            ),
          ),
          Text("OUTPUT:"),
          Container(
            width: 12.5 * globals.SizeConfig.blockSizeHorizontal,
            child: TextField(
              onChanged: (String outputValue) {
                commutationOutput = outputValue;
              },
            ),
          ),
          OutlinedButton(
            child: Text("Отправить запрос"),
            onPressed: () {
              String commutationRequest = widget.commutationAddress +
                  "param1=" +
                  commutationInput +
                  "&param2=" +
                  commutationOutput;
              sendRequest(commutationRequest);
              setState(() {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(content: Text(commutationRequest));
                    });
              });
            },
          )
        ],
      ),
    );
  }
}

class volumeCommutationRow extends StatefulWidget {
  final commutationAddress;
  const volumeCommutationRow({
    this.commutationAddress,
    Key? key,
  }) : super(key: key);

  @override
  State<volumeCommutationRow> createState() => _volumeCommutationRowState();
}

class _volumeCommutationRowState extends State<volumeCommutationRow> {
  double volumeCommutationValue = 44;

  String commutationInput = '';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16.5 * globals.SizeConfig.blockSizeVertical,
      width: 83 * globals.SizeConfig.blockSizeHorizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("INPUT:"),
          Container(
            width: 12.5 * globals.SizeConfig.blockSizeHorizontal,
            child: TextField(
              onChanged: (String inputValue) {
                commutationInput = inputValue;
              },
            ),
          ),
          SizedBox(
            height: 3.5 * globals.SizeConfig.blockSizeVertical,
            child: Slider(
                value: volumeCommutationValue,
                min: -12,
                max: 100,
                onChanged: (double value) {
                  setState(() {
                    volumeCommutationValue = value;
                  });
                }),
          ),
          OutlinedButton(
            child: Text("Отправить запрос"),
            onPressed: () {
              String commutationRequest = widget.commutationAddress +
                  commutationInput +
                  "&vol=" +
                  volumeCommutationValue.toString();
              sendRequest(commutationRequest);
              setState(() {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(content: Text(commutationRequest));
                    });
              });
            },
          )
        ],
      ),
    );
  }
}

class tvControlRow extends StatefulWidget {
  final commutationAddress;
  const tvControlRow({
    this.commutationAddress,
    Key? key,
  }) : super(key: key);

  @override
  State<tvControlRow> createState() => _tvControlRowState();
}

class _tvControlRowState extends State<tvControlRow> {
  String commutationInput = '';
  String commutationOutput = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16.5 * globals.SizeConfig.blockSizeVertical,
      width: 83 * globals.SizeConfig.blockSizeHorizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("param1:"),
          Container(
            width: 12.5 * globals.SizeConfig.blockSizeHorizontal,
            child: TextField(
              onChanged: (String inputValue) {
                commutationInput = inputValue;
              },
            ),
          ),
          Text("param2:"),
          Container(
            width: 12.5 * globals.SizeConfig.blockSizeHorizontal,
            child: TextField(
              onChanged: (String outputValue) {
                commutationOutput = outputValue;
              },
            ),
          ),
          OutlinedButton(
            child: Text("Отправить запрос"),
            onPressed: () {
              String commutationRequest = widget.commutationAddress +
                  commutationInput +
                  "&param2=" +
                  commutationOutput;
              sendRequest(commutationRequest);
              setState(() {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(content: Text(commutationRequest));
                    });
              });
            },
          )
        ],
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
            'assets/images/freepik2.jpg',
            fit: BoxFit.fill,
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
            'assets/images/StepLogo.jpg',
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
