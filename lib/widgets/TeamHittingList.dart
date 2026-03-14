import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fantasy_baseball_app/notifiers/TeamHittingModel.dart';

class TeamHittingList extends StatelessWidget
{
  const TeamHittingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TeamHittingModel>(
      builder: (context, teamHittingModel, child) {
        return ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            ListTile(
              title: Row(
                children: [
                  Expanded(child: Center(child: Text("Team"))),
                  Expanded(child: Center(child: Text("R"))),
                  Expanded(child: Center(child: Text("HR"))),
                  Expanded(child: Center(child: Text("RBIs"))),
                  Expanded(child: Center(child: Text("SB"))),
                  Expanded(child: Center(child: Text("OBP"))),
                  Expanded(child: Center(child: Text("QS Against"))),
                  Expanded(child: Center(child: Text("SV + HD Against"))),
                  Expanded(child: Center(child: Text("ERA Against"))),
                  Expanded(child: Center(child: Text("WHIP Against"))),
                  Expanded(child: Center(child: Text("Ks/9 Against")))
                ],
              )
            ),
            Divider(),
            if (teamHittingModel.finishedLoading)
              for (final team in teamHittingModel.teams)...[
                ListTile(
                  title: Row(
                    children: [
                      Expanded(child: Center(child: Text(team.team))),
                      Expanded(child: Center(child: Text(team.runs.toString()))),
                      Expanded(child: Center(child: Text(team.homeRuns.toString()))),
                      Expanded(child: Center(child: Text(team.rbis.toString()))),
                      Expanded(child: Center(child: Text(team.stolenBases.toString()))),
                      Expanded(child: Center(child: Text(team.onBasePercentage.toStringAsFixed(3)))),
                      Expanded(child: Center(child: Text(team.qualityStartsAgainst.toString()))),
                      Expanded(child: Center(child: Text((team.savesAgainst + team.holdsAgainst).toString()))),
                      Expanded(child: Center(child: Text(team.eraAgainst.toStringAsFixed(2)))),
                      Expanded(child: Center(child: Text(team.whipAgainst.toStringAsFixed(2)))),
                      Expanded(child: Center(child: Text(team.ksPerNineAgainst.toStringAsFixed(1)))),
                    ],
                  ),
                  onTap: () {},
                ),
                Divider()
              ]
            else
              Center(child: CircularProgressIndicator())
          ],
        );
      }
    );
  }
}