import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fantasy_baseball_app/model/PageType.dart';
import 'package:fantasy_baseball_app/notifiers/TeamHittingModel.dart';
import 'package:fantasy_baseball_app/widgets/HeaderBar.dart';
import 'package:fantasy_baseball_app/widgets/NavigationDrawer.dart';
import 'package:fantasy_baseball_app/widgets/SeasonSelector.dart';
import 'package:fantasy_baseball_app/widgets/TeamHittingList.dart';

class TeamHittingRankingsPage extends StatelessWidget
{
  static const routeName = "/teamHitting";

  const TeamHittingRankingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(title: "Team Hitting"),
      drawer: Drawer(
        child: NavigationList()
      ),
      body:
        Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text("Season: ")
                ),
                Consumer<TeamHittingModel>(
                  builder: (context, teamHittingModel, child) {
                    return SeasonSelector(pageType: PageType.TEAM_HITTING,callback: Provider.of<TeamHittingModel>(context, listen: false).updateSeason);
                  }
                ),
              ]
            ),
            Expanded(child: TeamHittingList())
          ]
        )
    );
  }
}