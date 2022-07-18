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
              //Center(child: backgroundImage()),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                    alignment: Alignment.center,
                    child: Center(child: Text('Тв'))),
              ),
              Align(alignment: Alignment(-1.0, -1.0), child: Text('VIDEO')),
              Align(
                alignment: Alignment(-0.8, -1.0),
                child: commutationRow(
                    commutationAddress:
                        "http://127.0.0.1:5000/Videocom/VideoCom/1/cmd/VIDEO?"),
              ),
              Align(alignment: Alignment(-1.0, -0.8), child: Text('AUDIO')),
              Align(
                alignment: Alignment(-0.8, -0.8),
                child: commutationRow(
                    commutationAddress:
                        "http://127.0.0.1:5000/Videocom/VideoCom/1/cmd/AUDIO?"),
              ),
              Align(alignment: Alignment(-1.0, -0.6), child: Text('AV')),
              Align(
                alignment: Alignment(-0.8, -0.6),
                child: commutationRow(
                    commutationAddress:
                        "http://127.0.0.1:5000/Videocom/VideoCom/1/cmd/AV?"),
              ),
              Align(alignment: Alignment(-1.0, -0.4), child: Text('VOLIN')),
              Align(
                alignment: Alignment(-0.8, -0.4),
                child: volumeCommutationRow(
                    commutationAddress:
                        "http://127.0.0.1:5000/Videocom/VideoCom/1/cmd/VOLIN?input="),
              ),
              Align(alignment: Alignment(-1.0, -0.2), child: Text('VOLOUT')),
              Align(
                alignment: Alignment(-0.8, -0.2),
                child: volumeCommutationRow(
                    commutationAddress:
                        "http://127.0.0.1:5000/Videocom/VideoCom/1/cmd/VOLOUT?output="),
              ),
              Align(alignment: Alignment(-1.0, 0.4), child: Text('PWR')),
              Align(
                alignment: Alignment(-0.8, 0.4),
                child: tvControlRow(
                    commutationAddress:
                        "http://127.0.0.1:5000/Api_TV/TVpanel/1/cmd/Power?param1="),
              ),
              Align(alignment: Alignment(-1.0, 0.6), child: Text('INPUT')),
              Align(
                alignment: Alignment(-0.8, 0.6),
                child: tvControlRow(
                    commutationAddress:
                        "http://127.0.0.1:5000/Api_TV/TVpanel/1/cmd/Input?param1="),
              ),

              /*Expanded(
                child: Container(),
              ),*/
              BottomBar(),
            ],
          ),
        ),
      ),
    );
  }
}
