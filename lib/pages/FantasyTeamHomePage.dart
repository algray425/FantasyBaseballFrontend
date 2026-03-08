import 'package:fantasy_baseball_app/widgets/FantasyTeamSummaryWidget.dart';
import 'package:flutter/material.dart';

import '../widgets/HeaderBar.dart';
import '../widgets/NavigationDrawer.dart';

class FantasyTeamHomePage extends StatelessWidget
{
  static const simpleRouteName  = "/fantasyTeamHome/";
  static const routeName        = "/fantasyTeamHome/:leagueType/:leagueId/:teamId/:userId";

  final String leagueType;
  final String leagueId;
  final String teamId;
  final String userId;

  const FantasyTeamHomePage({super.key, required this.leagueType, required this.leagueId, required this.teamId,
  required this.userId});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: HeaderBar(title: "Fantasy Team Home"),
      drawer: Drawer(
      child: NavigationList()
      ),
      body: SingleChildScrollView(scrollDirection: Axis.vertical, child: FantasyTeamSummaryWidget(leagueType: leagueType, leagueId: leagueId, teamId: teamId, userId: userId))
    );
  }
}