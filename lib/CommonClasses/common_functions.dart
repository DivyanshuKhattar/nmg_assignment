import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonFunction{

  /// for light status bar color
  static lightStatusBarColor(Color color) async {
    try {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: color,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: color,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    } on PlatformException catch (e) {
      debugPrint(e.message.toString());
    }
  }

  /// for dark status bar color
  static darkStatusBarColor(Color color) async {
    try {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: color,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: color,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    } on PlatformException catch (e) {
      debugPrint(e.message.toString());
    }
  }

  /// checking network before calling api
  Future<bool> checkNetwork() async{
    final result = await InternetAddress.lookup('www.google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
    return false;
  }
}