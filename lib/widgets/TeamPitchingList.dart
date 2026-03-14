import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fantasy_baseball_app/notifiers/TeamPitchingModel.dart';

class TeamPitchingList extends StatelessWidget
{
  const TeamPitchingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TeamPitchingModel>(
        builder: (context, teamPitchingModel, child) {
          return ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              ListTile(
                title: Row(
                  children: [
                    Expanded(child: Center(child: Text("Team"))),
                    // Expanded(child: Center(child: Text("QS"))),
                    // Expanded(child: Center(child: Text("SV + HD"))),
                    Expanded(child: Center(child: Text("ERA"))),
                    Expanded(child: Center(child: Text("WHIP"))),
                    Expanded(child: Center(child: Text("Ks/9"))),
                    Expanded(child: Center(child: Text("R Against"))),
                    Expanded(child: Center(child: Text("HR Against"))),
                    Expanded(child: Center(child: Text("RBIs Against"))),
                    Expanded(child: Center(child: Text("SB Against"))),
                    Expanded(child: Center(child: Text("OBP Against")))
                  ],
                )
              ),
              Divider(),
              if (teamPitchingModel.finishedLoading)
                for (final team in teamPitchingModel.teams)...[
                  ListTile(
                    title: Row(
                      children: [
                        Expanded(child: Center(child: Text(team.team))),
                        Expanded(child: Center(child: Text(team.era.toStringAsFixed(2)))),
                        Expanded(child: Center(child: Text(team.whip.toStringAsFixed(2)))),
                        Expanded(child: Center(child: Text(team.ksPerNine.toStringAsFixed(1)))),
                        Expanded(child: Center(child: Text(team.runs.toString()))),
                        Expanded(child: Center(child: Text(team.homeRuns.toString()))),
                        Expanded(child: Center(child: Text(team.rbisAgainst.toString()))),
                        Expanded(child: Center(child: Text(team.stolenBases.toString()))),
                        Expanded(child: Center(child: Text(team.onBasePercentageAgainst.toStringAsFixed(3)))),
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