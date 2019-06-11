import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'login.dart';
import 'home.dart';

void main() => runApp(MyApp());

@override

class MyApp extends StatelessWidget {
  
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'UTP Info Demo',
      home: new Login(),
      //initialRoute: '/',
      routes: {
        '/Login': (context) => new Login(),
        '/Home': (context) => new Home(),
      },
    ); 
  }
}