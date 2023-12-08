import 'dart:convert';
import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_nba/model/team.dart';

class MyHomePage extends StatelessWidget {
  final List<Team> teams;
  const MyHomePage({Key? key, required this.teams}) : super(key: key);

  Future getTeams() async{
    var response = await http.get(Uri.https('balldontlie.io','/api/v1/teams'));
    var jsonData = jsonDecode(response.body);

    for (var eachTeam in jsonData['data']){
      final team = Team(abbreviation: eachTeam['abbreviation'] , 
      city: eachTeam['city']
      );
      teams.add(team);
    }
    // if (response.statusCode == 200) {
    //   var jsonResponse = jsonDecode(response.body);
    //   print(jsonResponse);
    // } else {
    //   print('Request failed with status: ${response.statusCode}.');
    // }
    print(teams.length);
  }

  @override
  Widget build(BuildContext context) {
    getTeams();
    return Scaffold(
      body: FutureBuilder(
        future: getTeams(),
        builder:(context, snapshot) {
          //is it done loading ? then show team data 
          if(snapshot.connectionState == ConnectionState.done){
                  return ListView.builder(
                    itemCount: teams.length,
                    itemBuilder:(context, index) {

                    return ListTile(
                      title: Text(teams[index].abbreviation),
                    );
                  },
                  );
          }
          else{
                 return const Center(
                  child: CircularProgressIndicator(),
                 );
          }
        },
        ),
    );
  }
}