import 'package:flutter/material.dart';
import 'package:utpinfo/welcome.dart';
import 'login.dart';
import 'home.dart';
import 'welcome.dart';
import 'register.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTP Info Demo',
      //debugShowCheckedModeBanner: false,
      //home: new Welcome(),
      routes: {
        '/Login': (context) => new Login(),
        '/': (context) => new Home(),
        '/Welcome': (context) => new Welcome(),
        '/Register': (context) => new Register(),
      },
    ); 
  }
}