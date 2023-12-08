import 'dart:convert';
import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app_nba/model/team.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(teams: []),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Team> teams;

  MyHomePage({Key? key, required this.teams}) : super(key: key);

  Future<List<Team>> getTeams() async {
    var response = await http.get(Uri.https('balldontlie.io', '/api/v1/teams'));
    var jsonData = jsonDecode(response.body);
    List<Team> teams = [];

    for (var eachTeam in jsonData['data']) {
      final team = Team(
        abbreviation: eachTeam['abbreviation'],
        city: eachTeam['city'],
      );
      teams.add(team);
    }

    print(teams.length);
    return teams;
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Team>>(
        future: getTeams(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            final teams = snapshot.data ?? [];

            return ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(teams[index].abbreviation),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}