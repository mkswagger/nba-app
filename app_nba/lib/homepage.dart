import 'dart:convert';
import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_nba/model/team.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  Future getTeams() async{
    var response = await http.get(Uri.https('balldontlie.io','/api/v1/teams'));
    var jsonData = jsonDecode(response.body);

    for (var eachTeam in jsonData['data']){
      final team = Team(abbreviation: eachTeam['abbreviation'] , 
      city: eachTeam['city']);
    }
    // if (response.statusCode == 200) {
    //   var jsonResponse = jsonDecode(response.body);
    //   print(jsonResponse);
    // } else {
    //   print('Request failed with status: ${response.statusCode}.');
    // }
  }

  @override
  Widget build(BuildContext context) {
    getTeams();
    return Scaffold();
  }
}