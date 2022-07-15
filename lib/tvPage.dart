import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:multimedia_demo/contentPage.dart';
import 'package:multimedia_demo/landingPage.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:http/http.dart' as http;
import 'package:joystick/joystick.dart';

import 'my_libraries/globals.dart' as globals;

import 'main.dart';
import 'vksPage.dart';
import 'homePage.dart';
import 'commonWidgets.dart';

class TVPage extends StatefulWidget {
  const TVPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TVPage> createState() => _TVPageState();
}

class _TVPageState extends State<TVPage> {
  @override
  Widget build(BuildContext context) {
    globals.currentPage = 'TV';

    return Scaffold(
      appBar: AppBar(
        title: Text('ТВ'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Container(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                    alignment: Alignment.center,
                    child: Center(child: Text('Тв'))),
              ),
              /*Expanded(
                child: Container(),
              ),*/
              BottomBar(), /*
              Align(alignment: Alignment.bottomLeft, child: VolumeSlider()),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.content_paste_outlined),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ContentPage()),
                            );
                          },
                        ),
                        Text('Контент')
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            icon: Icon(Icons.phone),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const VKSPage()),
                              );
                            }),
                        Text('ВКС')
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.tv),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ContentPage()),
                            );
                          },
                        ),
                        Text('ТВ')
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () {
                      setState(() {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Column(
                                  children: [
                                    Text('Закрыть контроллер?'),
                                    Row(
                                      children: [
                                        IconButton(
                                            icon: Icon(Icons.cancel),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }),
                                        IconButton(
                                            icon: Icon(Icons.check),
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const startingPage()),
                                              );
                                            })
                                      ],
                                    )
                                  ],
                                ),
                              );
                            });
                      });
                    }),
              )
            */
            ],
          ),
        ),
      ),
    );
  }
}
