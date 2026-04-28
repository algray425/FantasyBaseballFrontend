import 'package:fantasy_baseball_app/model/PageType.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fantasy_baseball_app/notifiers/TeamPitchingModel.dart';
import 'package:fantasy_baseball_app/widgets/HeaderBar.dart';
import 'package:fantasy_baseball_app/widgets/NavigationDrawer.dart';
import 'package:fantasy_baseball_app/widgets/SeasonSelector.dart';
import 'package:fantasy_baseball_app/widgets/TeamPitchingList.dart';

class TeamPitchingRankingsPage extends StatelessWidget
{
  static const routeName = "/teamPitching";

  const TeamPitchingRankingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderBar(title: "Team Pitching"),
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
                  Consumer<TeamPitchingModel>(
                    builder: (context, teamPitchingModel, child) {
                      return SeasonSelector(pageType: PageType.TEAM_PITCHING, callback: Provider.of<TeamPitchingModel>(context, listen: false).updateSeason);
                    }
                  ),
                ]
              ),
              Expanded(child: TeamPitchingList())
            ],
          )
    );
  }
}