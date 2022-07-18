import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:http/http.dart' as http;
import 'package:joystick/joystick.dart';

import 'my_libraries/globals.dart' as globals;

import 'main.dart';
import 'vksPage.dart';
import 'my_functions/hardwareFunctions.dart';
import 'homePage.dart';

import 'commonWidgets.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  String fullRequestText = '';

  @override
  Widget build(BuildContext context) {
    globals.currentPage = 'Content';
    return Scaffold(
      appBar: AppBar(
        title: Text('Контент'),
      ),
      body: Stack(children: [
        //Center(child: backgroundImage()),
        Center(
            child: Row(
          children: [
            Text("Текст запроса:"),
            Container(
              width: 500,
              child: TextField(
                onChanged: (String outputValue) {
                  fullRequestText = outputValue;
                },
              ),
            ),
            OutlinedButton(
              child: Text("Отправить запрос"),
              onPressed: () {
                sendRequest(fullRequestText);
                setState(() {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(content: Text(fullRequestText));
                      });
                });
              },
            )
          ],
        )),
        BottomBar()
      ]),
    );
  }
}
