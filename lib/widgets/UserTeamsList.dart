import 'package:fantasy_baseball_app/data/UserDataSource.dart';
import 'package:fantasy_baseball_app/model/FantasyTeam.dart';
import 'package:fantasy_baseball_app/pages/FantasyTeamHomePage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserTeamsList extends StatefulWidget
{
  final UserDataSource userDataSource = UserDataSource();

  final String userId;

  UserTeamsList({super.key, required this.userId});

  @override
  UserTeamsListState createState() => UserTeamsListState();
}

class UserTeamsListState extends State<UserTeamsList>
{
  bool finishedLoadingTeams = false;

  late List<FantasyTeam> fantasyTeams;

  @override
  void initState()
  {
    super.initState();

    widget.userDataSource.getFantasyTeamsForUser(widget.userId).then((List<FantasyTeam> teams){
      setState(() {
        finishedLoadingTeams  = true;
        fantasyTeams          = teams;
      });
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Container(
      margin: EdgeInsets.fromLTRB(150, 0, 150, 0),
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Center(child: Text("League Name", style: TextStyle(fontWeight: FontWeight.bold)))),
                Expanded(child: Center(child: Text("League Id", style: TextStyle(fontWeight: FontWeight.bold))))
              ],
            ),
          ),
          Divider(),
          if (finishedLoadingTeams)
            for (final team in fantasyTeams)...[
              ListTile(
                onTap: (){
                  context.go("${FantasyTeamHomePage.simpleRouteName}${team.leagueType}/${team.leagueId}/${team.teamId}/${widget.userId}");
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Center(child: Text(team.leagueName))),
                    Expanded(child: Center(child: Text(team.teamName)))
                  ],
                )
              ),
              Divider(),
            ]
          else
            CircularProgressIndicator()
        ]
      )
    );
  }
}