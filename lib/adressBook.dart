import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:http/http.dart' as http;
import 'package:joystick/joystick.dart';

String pashutaAdress = "http://127.0.0.1:5000/";
String polycomCameraMoveAdress = pashutaAdress +
    "VideoConf/RealPresence%20Group%20700/1/CameraNearPanTilt?value=";
String polycomCameraZoomAdress = pashutaAdress +
    "VideoConf/RealPresence%20Group%20700/1/CameraNearZoom?value=";
String polycomCameraPresetAdress = pashutaAdress +
    "VideoConf/RealPresence%20Group%20700/1/CameraPresetNearRecall?value=";
String polycomIREmulationAdress =
    pashutaAdress + "VideoConf/RealPresence%20Group%20700/1/IREmulation?value=";
String polycomHangupAdress =
    pashutaAdress + "VideoConf/RealPresence%20Group%20700/1/Hangup?value=";
String polycomCallAdress =
    pashutaAdress + "VideoConf/RealPresence%20Group%20700/1/Hook?value=";
