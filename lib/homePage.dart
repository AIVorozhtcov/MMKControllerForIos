import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:http/http.dart' as http;
import 'package:joystick/joystick.dart';

import 'my_libraries/globals.dart' as globals;

import 'main.dart';
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
                              MaterialStateProperty.all(Colors.blue)),
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
                              MaterialStateProperty.all(Colors.blue)),
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
                              MaterialStateProperty.all(Colors.blue)),
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
        BottomBar()
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