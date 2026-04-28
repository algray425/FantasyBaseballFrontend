import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fantasy_baseball_app/widgets/HeaderBar.dart';
import 'package:fantasy_baseball_app/widgets/NavigationDrawer.dart';
import 'package:fantasy_baseball_app/widgets/TeamSummaryBody.dart';

class TeamSummaryPage extends StatelessWidget
{
  static const simpleRouteName  = "/team/";
  static const routeName        = "/team/:teamId";

  final String teamId;

  const TeamSummaryPage({super.key, required this.teamId});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: HeaderBar(title: "Team Summary"),
      drawer: Drawer(
        child: NavigationList()
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: TeamSummaryBody(teamId: teamId)
      ),
    );
  }
}