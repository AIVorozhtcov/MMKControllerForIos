import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:http/http.dart' as http;
import 'package:joystick/joystick.dart';

void main() {
  runApp(const MyApp());
}

/*
class LaunchPage extends StatefulWidget {
  const LaunchPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          OutlinedButton(
              child: Text("Контент"),
              onPressed: () {
                setState(() {
                  _selectedIndex = 2;
                });
              }),
          /*OutlinedButton(onPressed: onPressed, child: Text("ВКС")),
          OutlinedButton(onPressed: onPressed, child: Text("ТВ")),*/
        ],
      ),
    );
  }
}
*/

class TVPage extends StatelessWidget {
  const TVPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Управление ММК'),
      ),
      body: Center(child: Text('Тв')),
    );
  }
}

class ContentPage extends StatelessWidget {
  const ContentPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Управление ММК'),
      ),
      body: Center(child: Text('Контент')),
    );
  }
}

class VKSPage extends StatefulWidget {
  const VKSPage({
    Key? key,
  }) : super(key: key);

  @override
  State<VKSPage> createState() => _VKSPageState();
}

String _dialNumber = '';

class _VKSPageState extends State<VKSPage> {
  onNumberChanged(String newNumberString) {
    setState(() {
      _dialNumber = _dialNumber + newNumberString;
    });
  }

  onNumberDeleted() {
    setState(() {
      _dialNumber = _dialNumber.substring(0, _dialNumber.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Управление ММК'),
        ),
        body: Row(
          children: [
            KeyboardBlock(
              numberTapCallback: onNumberChanged,
              numberDeleteCallback: onNumberDeleted,
            ),
            VKSCenterBlock(),
            CameraControlBlock(),
          ],
        ));
  }
}

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

Future<String> _numberRequest(String requestedNumber) async {
  String fullRequest = "http://numbersapi.com/" + requestedNumber;

  final response = await http.get(Uri.parse(fullRequest));
  /*print(response.body);*/
  return response.body;
  /*Uri requestURI = Uri.parse(fullRequest);
  http.get(requestURI).then((response) {
    return (response.body);
  });*/

  /*String requestResult = http.get(Uri.parse(requestURI));
  return requestResult;*/
}

Future<String> _cameraRequest(String equipment_type, String equipment_model,
    String equipment_id, String command_name, String command_value) async {
  String fullRequest = "localhost:5000/" +
      equipment_type +
      "/" +
      equipment_model +
      "/" +
      equipment_id +
      "/" +
      command_name +
      "?value=" +
      command_value;

  final response = await http.post(Uri.parse(fullRequest));
  print(response.body);
  return response.body;
}

Future<String> _phoneRequest(String equipment_type, String equipment_model,
    String equipment_id, String command_value) async {
  String fullRequest = "localhost:5000/" +
      equipment_type +
      "/" +
      equipment_model +
      "/" +
      equipment_id +
      "/Hook?value=" +
      command_value;

  final response = await http.post(Uri.parse(fullRequest));
  print(response.body);
  return response.body;
}

class _KeyboardBlockState extends State<KeyboardBlock> {
  _numberTap(String value) {
    /*_dialNumber = _dialNumber + value;*/
    setState(() {
      _dialNumber = _dialNumber + value;
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
                  _dialNumber =
                      _dialNumber.substring(0, _dialNumber.length - 1);
                });
              }*/
              rightIcon: Icon(
                Icons.backspace,
                color: Colors.red,
              ),
              leftButtonFn: () async {
                final numberInfo = await _numberRequest(_dialNumber);
                print(numberInfo);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(content: Text(numberInfo));
                    });

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
                Icons.check,
                color: Colors.red,
              ),
              mainAxisAlignment: MainAxisAlignment.spaceEvenly),
        ],
      ),
    );
  }
}

class VKSCenterBlock extends StatefulWidget {
  const VKSCenterBlock({
    Key? key,
  }) : super(key: key);

  @override
  State<VKSCenterBlock> createState() => _VKSCenterBlockState();
}

class _VKSCenterBlockState extends State<VKSCenterBlock> {
  bool _micMute = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: Text(_dialNumber)),
        Row(
          children: [
            IconButton(
                icon: Icon(
                  Icons.phone_in_talk,
                  color: Colors.green[700],
                ),
                onPressed: /* PASHUTA () async {
                  final requestResponse = await _phoneRequest(
                      "VideoConf",
                      "RealPresence%20Group%20700",
                      "1",
                      _dialNumber.toString());
                  print(requestResponse);                  
                }*/
                    () {
                  setState(() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              content: Text('Звонок по номеру ' + _dialNumber));
                        });
                  });
                }),
            IconButton(
                icon: _micMute ? Icon(Icons.mic) : Icon(Icons.mic_off),
                onPressed: () {
                  if (_micMute) {
                    /* PASHUTA () async {
                      final requestResponse = await _cameraRequest(
                          "VideoConf",
                          "RealPresence%20Group%20700",
                          "1",
                          "IREmulation",
                          "Mute");
                      print(requestResponse);
                    };*/
                    setState(() {
                      _micMute = false;
                    });
                  } else {
                    /* PASHUTA () async {
                      final requestResponse = await _cameraRequest(
                          "VideoConf",
                          "RealPresence%20Group%20700",
                          "1",
                          "IREmulation",
                          "Mute");
                      print(requestResponse);
                    };*/
                    setState(() {
                      _micMute = true;
                    });
                  }
                }),
            IconButton(
                icon: Icon(
                  Icons.phone_disabled,
                  color: Colors.red[900],
                ),
                onPressed: () {
                  /* PASHUTA () async {
                    final requestResponse = await _cameraRequest(
                        "VideoConf",
                        "RealPresence%20Group%20700",
                        "1",
                        "Hangup",
                        "All");
                    print(requestResponse);
                  };*/
                  setState(() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(content: Text('Звонок завершен'));
                        });
                  });
                })
          ],
        ),
        OutlinedButton(
            child: Text("Контент"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContentPage()),
              );
            }),
      ],
    );
  }
}

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
    return Column(
      children: [
        Row(
          children: [
            Row(
              children: [
                InkWell(
                    child: Ink(
                      child: Icon(Icons.arrow_left),
                    ),
                    onTapDown: (TapDownDetails) {
                      /* PASHUTA () async {
                      final requestResponse = await _cameraRequest(
                          "VideoConf",
                          "RealPresence%20Group%20700",
                          "1",
                          "CameraNearPanTilt",
                          "Left");
                      print(requestResponse);
                    };*/
                      /*setState(() {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                content: Text('Камера двигается влево'));
                          });
                    });*/
                    },
                    onTapUp: (TapUpDetails) {
                      /* PASHUTA () async {
                      final requestResponse = await _cameraRequest(
                          "VideoConf",
                          "RealPresence%20Group%20700",
                          "1",
                          "CameraNearPanTilt",
                          "Stop");
                      print(requestResponse);
                    };*/
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
                Column(
                  children: [
                    InkWell(
                        child: Ink(
                          child: Icon(Icons.arrow_upward),
                        ),
                        onTapDown: (TapDownDetails) {
                          /* PASHUTA () async {
                      final requestResponse = await _cameraRequest(
                          "VideoConf",
                          "RealPresence%20Group%20700",
                          "1",
                          "CameraNearPanTilt",
                          "Up");
                      print(requestResponse);
                    };*/
                          /*setState(() {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                content: Text('Камера двигается вверх'));
                          });
                    });*/
                        },
                        onTapUp: (TapUpDetails) {
                          /* PASHUTA () async {
                          final requestResponse = await _cameraRequest(
                              "VideoConf",
                              "RealPresence%20Group%20700",
                              "1",
                              "CameraNearPanTilt",
                              "Stop");
                          print(requestResponse);
                        };*/
                          setState(() {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      content: Text(
                                          'Камера перестала двигаться вверх'));
                                });
                          });
                        }),
                    OutlinedButton(
                        child: Text('OK'),
                        onPressed: () {
                          setState(() {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(content: CameraViews());
                                });
                          });
                        }),
                    InkWell(
                        child: Ink(
                          child: Icon(Icons.arrow_downward),
                        ),
                        onTapDown: (TapDownDetails) {
                          /* PASHUTA () async {
                      final requestResponse = await _cameraRequest(
                          "VideoConf",
                          "RealPresence%20Group%20700",
                          "1",
                          "CameraNearPanTilt",
                          "Down");
                      print(requestResponse);
                    };*/
                          /*setState(() {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                content: Text('Камера двигается вниз'));
                          });
                    });*/
                        },
                        onTapUp: (TapUpDetails) {
                          /* PASHUTA () async {
                      final requestResponse = await _cameraRequest(
                          "VideoConf",
                          "RealPresence%20Group%20700",
                          "1",
                          "CameraNearPanTilt",
                          "Stop");
                      print(requestResponse);
                    };*/
                          setState(() {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      content: Text(
                                          'Камера перестала двигаться вниз'));
                                });
                          });
                        }),
                  ],
                ),
                InkWell(
                    child: Ink(
                      child: Icon(Icons.arrow_right),
                    ),
                    onTapDown: (TapDownDetails) {
                      /* PASHUTA () async {
                      final requestResponse = await _cameraRequest(
                          "VideoConf",
                          "RealPresence%20Group%20700",
                          "1",
                          "CameraNearPanTilt",
                          "Right");
                      print(requestResponse);
                    };*/
                      /*setState(() {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                content: Text('Камера двигается вправо'));
                          });
                    });*/
                    },
                    onTapUp: (TapUpDetails) {
                      /* PASHUTA () async {
                      final requestResponse = await _cameraRequest(
                          "VideoConf",
                          "RealPresence%20Group%20700",
                          "1",
                          "CameraNearPanTilt",
                          "Stop");
                      print(requestResponse);
                    };*/
                      setState(() {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  content: Text(
                                      'Камера перестала двигаться вправо'));
                            });
                      });
                    }),
                Column(
                  children: [
                    InkWell(
                        child: Ink(
                          child: Icon(Icons.zoom_in),
                        ),
                        onTapDown: (TapDownDetails) {
                          /* PASHUTA () async {
                          final requestResponse = await _cameraRequest(
                              "VideoConf",
                              "RealPresence%20Group%20700",
                              "1",
                              "CameraNearZoom",
                              "Zoom_plus");
                          print(requestResponse);
                        };*/
                          /*setState(() {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    content: Text('Камера двигается вправо'));
                              });
                        });*/
                        },
                        onTapUp: (TapUpDetails) {
                          /* PASHUTA () async {
                          final requestResponse = await _cameraRequest(
                              "VideoConf",
                              "RealPresence%20Group%20700",
                              "1",
                              "CameraNearZoom",
                              "Stop");
                          print(requestResponse);
                        };*/
                          setState(() {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      content: Text(
                                          'Камера перестала приближаться'));
                                });
                          });
                        }),
                    InkWell(
                        child: Ink(
                          child: Icon(Icons.zoom_out),
                        ),
                        onTapDown: (TapDownDetails) {
                          /* PASHUTA () async {
                          final requestResponse = await _cameraRequest(
                              "VideoConf",
                              "RealPresence%20Group%20700",
                              "1",
                              "CameraNearZoom",
                              "Zoom_minus");
                          print(requestResponse);
                        };*/
                          /*setState(() {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    content: Text('Камера двигается вправо'));
                              });
                        });*/
                        },
                        onTapUp: (TapUpDetails) {
                          /* PASHUTA () async {
                          final requestResponse = await _cameraRequest(
                              "VideoConf",
                              "RealPresence%20Group%20700",
                              "1",
                              "CameraNearZoom",
                              "Stop");
                          print(requestResponse);
                        };*/
                          setState(() {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      content:
                                          Text('Камера перестала отдаляться'));
                                });
                          });
                        }),
                  ],
                )
              ],
            )
          ],
        ),
        Row(
          children: [
            IconButton(
                icon: Icon(Icons.password),
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
            IconButton(
                icon: Icon(Icons.smart_screen),
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
                })
          ],
        )
      ],
    ); /*SizedBox(
      width: 200.0,
      height: 200.0,
      child: Joystick(
          size: 200,
          isDraggable: false,
          //icon: Icons.abc,
          iconColor: Colors.amber,
          backgroundColor: Colors.black,
          opacity: 0,
          joystickMode: JoystickModes.all,
          onUpPressed: () {
            setState(() {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(content: Text('Камера двигается вверх'));
                  });
            });
          },
          onLeftPressed: () {
            setState(() {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(content: Text('Камера двигается влево'));
                  });
            });
          },
          onRightPressed: () {
            setState(() {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        content: Text('Камера двигается вправо'));
                  });
            });
          },
          onDownPressed: () {
            setState(() {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(content: Text('Камера двигается влево'));
                  });
            });
          },
          onPressed: (_direction) {
            // print("pressed $_direction");
          }),
    );*/
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
                  /* PASHUTA () async {
                    final requestResponse = await _cameraRequest(
                        "VideoConf",
                        "RealPresence%20Group%20700",
                        "1",
                        "CameraPresetNearRecall",
                        "1");
                    print(requestResponse);
                  };*/
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
                  /* PASHUTA () async {
                    final requestResponse = await _cameraRequest(
                        "VideoConf",
                        "RealPresence%20Group%20700",
                        "1",
                        "CameraPresetNearRecall",
                        "2");
                    print(requestResponse);
                  };*/
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
                  /* PASHUTA () async {
                    final requestResponse = await _cameraRequest(
                        "VideoConf",
                        "RealPresence%20Group%20700",
                        "1",
                        "CameraPresetNearRecall",
                        "3");
                    print(requestResponse);
                  };*/
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
                  /* PASHUTA () async {
                    final requestResponse = await _cameraRequest(
                        "VideoConf",
                        "RealPresence%20Group%20700",
                        "1",
                        "CameraPresetNearRecall",
                        "4");
                    print(requestResponse);
                  };*/
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

class VolumePage extends StatefulWidget {
  const VolumePage({
    Key? key,
  }) : super(key: key);

  @override
  State<VolumePage> createState() => _VolumePageState();
}

class _VolumePageState extends State<VolumePage> {
  double _leftSliderValue = 50;
  double _rightSliderValue = 50;
  bool _leftMute = false;
  bool _rightMute = false;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      IconButton(
          icon: _leftMute
              ? Icon(Icons.volume_off)
              : Icon(Icons.volume_up_rounded),
          onPressed: () {
            if (_leftMute) {
              setState(() {
                _leftMute = false;
              });
            } else {
              setState(() {
                _leftMute = true;
              });
            }
          }),
      Slider(
          value: _leftSliderValue,
          max: 100,
          onChanged: (double value) {
            setState(() {
              _leftSliderValue = value;
            });
          }),
      IconButton(
          icon: _rightMute
              ? Icon(Icons.volume_off)
              : Icon(Icons.volume_up_rounded),
          onPressed: () {
            if (_rightMute) {
              setState(() {
                _rightMute = false;
              });
            } else {
              setState(() {
                _rightMute = true;
              });
            }
          }),
      Slider(
        value: _rightSliderValue,
        max: 100,
        onChanged: (double value) {
          setState(() {
            _rightSliderValue = value;
          });
        },
      )
    ]);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MMC Demo',
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*static const List<Widget> _pages = <Widget>[
    KeyboardBlock(),
    VolumePage(),
  ];*/

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Управление ММК'),
      ),
      body: Center(
        child: Row(
          children: [
            OutlinedButton(
                child: Text("Контент"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ContentPage()),
                  );
                }),
            OutlinedButton(
                child: Text("ВКС"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const VKSPage()),
                  );
                }),
            OutlinedButton(
                child: Text("ТВ"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TVPage()),
                  );
                }),
            /*OutlinedButton(onPressed: onPressed, child: Text("ВКС")),
        OutlinedButton(onPressed: onPressed, child: Text("ТВ")),*/
          ],
        ),
      ),
      /*body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),*/
      /*bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.volume_up_sharp),
            label: 'Аудио',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'Звонок'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),*/ // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
