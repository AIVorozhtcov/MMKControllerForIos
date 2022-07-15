import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:multimedia_demo/adressBook.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:http/http.dart' as http;
import 'package:joystick/joystick.dart';

import '../my_libraries/globals.dart' as globals;

Future<String> numberRequest(String requestedNumber) async {
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

bool checkPage(String comparedPage) {
  if (comparedPage == globals.currentPage) {
    return true;
  } else
    return false;
}
