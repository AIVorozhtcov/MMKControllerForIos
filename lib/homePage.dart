import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:http/http.dart' as http;

import 'my_libraries/globals.dart' as globals;

import 'my_functions/hardwareFunctions.dart';

import 'loadingPage.dart';
import 'main.dart';
import 'landingPage.dart';
import 'vksPage.dart';
import 'tvPage.dart';
import 'contentPage.dart';
import 'commonWidgets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

String currentPage = 'Home';

class _MyHomePageState extends State<MyHomePage> {
  /*static const List<Widget> _pages = <Widget>[
    KeyboardBlock(),
    VolumePage(),
  ];*/

  @override
  Widget build(BuildContext context) {
    globals.currentPage = 'Home';

    return Scaffold(
      appBar: AppBar(
        title: Text('Управление ММК'),
      ),
      body: Stack(children: [
        Positioned.fill(child: backgroundImage()),

        Align(alignment: Alignment(-1.0, 0.9), child: VolumeSlider()),
        Align(
          alignment: Alignment(0.0, 0.2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 75,
                  width: 150,
                  child: OutlinedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0)))),
                      child: Text(
                        "Контент",
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ContentPage()),
                        );
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 75,
                  width: 150,
                  child: OutlinedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0)))),
                      child: Text(
                        "ВКС",
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VKSPage()),
                        );
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 75,
                  width: 150,
                  child: OutlinedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(18.0)))),
                      child: Text("ТВ",
                          style: TextStyle(color: Colors.black, fontSize: 30)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TVPage()),
                        );
                      }),
                ),
              ),
              /*OutlinedButton(onPressed: onPressed, child: Text("ВКС")),
          OutlinedButton(onPressed: onPressed, child: Text("ТВ")),*/
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
        //BottomBar()
      ]),

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
