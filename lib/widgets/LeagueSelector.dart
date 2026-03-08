import 'package:flutter/material.dart';

import 'package:fantasy_baseball_app/data/UserDataSource.dart';
import 'package:fantasy_baseball_app/model/FantasyTeam.dart';

class LeagueSelector extends StatefulWidget
{
  final UserDataSource              userDataSource = UserDataSource();
  final String                      userId;
  final void Function(FantasyTeam)  callback;

  LeagueSelector({super.key, required this.userId, required this.callback});

  @override
  LeagueSelectorState createState() => LeagueSelectorState();
}

class LeagueSelectorState extends State<LeagueSelector>
{
  bool                            finishedLoadingTeams = false;
  String                          selectedTeam         = "None";
  Map<String, FantasyTeam>        teamKeyToFantasyTeam = {};

  late List<FantasyTeam>          fantasyTeams;

  @override
  void initState()
  {
    super.initState();

    widget.userDataSource.getFantasyTeamsForUser("1").then((List<FantasyTeam> teams){
      setState(() {
        fantasyTeams = teams;

        FantasyTeam noneTeam = FantasyTeam(teamId: "None", teamName: "None", leagueId: "None", leagueName: "None", leagueType: "None");

        fantasyTeams.insert(0, noneTeam);

        teamKeyToFantasyTeam[noneTeam.teamName] = noneTeam;

        for (final team in fantasyTeams)
        {
          teamKeyToFantasyTeam[team.teamName] = team;
        }

        finishedLoadingTeams = true;
      });
    });
  }

  @override
  Widget build(BuildContext context)
  {
    if (finishedLoadingTeams)
    {
      return DropdownButton(
          value: selectedTeam,
          items: fantasyTeams.map((FantasyTeam team){
            return DropdownMenuItem(value: team.teamName, child: Text(team.teamName));
          }).toList(),
          onChanged: (String? newValue){
            setState(() {
              if (teamKeyToFantasyTeam.containsKey(newValue!))
              {
                selectedTeam = newValue;

                widget.callback(teamKeyToFantasyTeam[newValue]!);
              }
            });
          });
    }
    else
    {
      return Center(child: CircularProgressIndicator());
    }
  }
}