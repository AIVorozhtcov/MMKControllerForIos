import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:multimedia_demo/adressBook.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:http/http.dart' as http;

import '../my_libraries/globals.dart' as globals;

callAlertDialog(Widget alertContent) {
  return AlertDialog(content: alertContent);
}

Future<String> moveCamera(String command_value) async {
  String fullRequest = polycomCameraMoveAdress + command_value;

  final response = await http.post(Uri.parse(fullRequest));
  //print(response.body);
  String decodedResponse = jsonDecode(response.body).toString();
  print(decodedResponse);
  return decodedResponse;
}

Future<String> zoomCamera(String command_value) async {
  String fullRequest = polycomCameraZoomAdress + command_value;

  final response = await http.post(Uri.parse(fullRequest));
  //print(response.body);
  String decodedResponse = jsonDecode(response.body).toString();
  print(decodedResponse);
  return decodedResponse;
}

Future<String> useCameraPreset(String command_value) async {
  String fullRequest = polycomCameraPresetAdress + command_value;

  final response = await http.post(Uri.parse(fullRequest));
  //print(response.body);
  String decodedResponse = jsonDecode(response.body).toString();
  print(decodedResponse);
  return decodedResponse;
}

Future<String> emulateIR(String command_value) async {
  String fullRequest = polycomIREmulationAdress + command_value;

  final response = await http.post(Uri.parse(fullRequest));
  //print(response.body);
  String decodedResponse = jsonDecode(response.body).toString();
  print(decodedResponse);
  return decodedResponse;
}

Future<String> polycomHangup(String command_value) async {
  String fullRequest = polycomHangupAdress + command_value;

  final response = await http.post(Uri.parse(fullRequest));
  //print(response.body);
  String decodedResponse = jsonDecode(response.body).toString();
  print(decodedResponse);
  return decodedResponse;
}

Future<String> customRequest(String equipment_type, String equipment_model,
    String equipment_id, String command_name, String command_value) async {
  String fullRequest = pashutaAdress +
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
  //print(response.body);
  String decodedResponse = jsonDecode(response.body).toString();
  print(decodedResponse);
  return decodedResponse;
}

Future<String> sendRequest(String fullRequest) async {
  final response = await http.post(Uri.parse(fullRequest));
  //print(response.body);
  String decodedResponse = jsonDecode(response.body).toString();
  print(decodedResponse);
  return decodedResponse;
}

Future<String> makeCall(String command_value) async {
  String fullRequest = polycomCallAdress + command_value;

  final response = await http.post(Uri.parse(fullRequest));
  String decodedResponse = jsonDecode(response.body);
  print(decodedResponse);
  return decodedResponse;
}
