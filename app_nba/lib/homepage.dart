import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  Future getTeams() async{
    var response = await http.get(Uri.https('balldontlie.io','/api/v1/teams'));
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    getTeams();
    return Scaffold();
  }
}