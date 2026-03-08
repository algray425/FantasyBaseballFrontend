import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:fantasy_baseball_app/model/PitchingStat.dart';
import 'package:fantasy_baseball_app/notifiers/ReliefPitcherRankingsListModel.dart';
import 'package:fantasy_baseball_app/pages/PitcherPage.dart';
import 'FavoriteButton.dart';
import 'PitcherListHeader.dart';

class ReliefPitcherList extends StatelessWidget
{
  const ReliefPitcherList({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Consumer<ReliefPitcherRankingsListModel>(
        builder: (context, reliefPitcherModel, child)
        {
          if (reliefPitcherModel.finishedLoading)
          {
            return ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distributes space horizontally
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Center(child: Text("Favorite"))),
                      Expanded(child: Center(child: Text("Name"))),
                      Expanded(child: Center(child: Text("Team"))),
                      PitcherListHeader(text: "Grade",          pitchingStat: PitchingStat.PERCENTILE_OVERALL,  callback: Provider.of<ReliefPitcherRankingsListModel>(context, listen: false).updateSort),
                      PitcherListHeader(text: "Saves",          pitchingStat: PitchingStat.SAVES,               callback: Provider.of<ReliefPitcherRankingsListModel>(context, listen: false).updateSort),
                      PitcherListHeader(text: "Holds",          pitchingStat: PitchingStat.HOLDS,               callback: Provider.of<ReliefPitcherRankingsListModel>(context, listen: false).updateSort),
                      PitcherListHeader(text: "ERA",            pitchingStat: PitchingStat.ERA,                 callback: Provider.of<ReliefPitcherRankingsListModel>(context, listen: false).updateSort),
                      PitcherListHeader(text: "WHIP",           pitchingStat: PitchingStat.WHIP,                callback: Provider.of<ReliefPitcherRankingsListModel>(context, listen: false).updateSort),
                      PitcherListHeader(text: "Ks/9",           pitchingStat: PitchingStat.KS_PER_NINE,         callback: Provider.of<ReliefPitcherRankingsListModel>(context, listen: false).updateSort),
                    ],
                  ),
                ),
                Divider(),
                if (reliefPitcherModel.finishedLoading)
                  for (final pitcher in reliefPitcherModel.pitchers)...[
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distributes space horizontally
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: FavoriteButton(id: pitcher.id, name: pitcher.name, position: "P", team: pitcher.team, marginLeft: 0, marginRight: 0, marginTop: 0, marginBottom: 0)),
                          Expanded(child: Center(child: Text(pitcher.name                                             ))),
                          Expanded(child: Center(child: Text(pitcher.team                                             ))),
                          Expanded(child: Center(child: Text(getLetterGradeFromPercentile(pitcher.overallPercentile)  ))),
                          Expanded(child: Center(child: Text(pitcher.saves.toString()                         ))),
                          Expanded(child: Center(child: Text(pitcher.holds.toString()                         ))),
                          Expanded(child: Center(child: Text(pitcher.era          .toStringAsFixed(3)                 ))),
                          Expanded(child: Center(child: Text(pitcher.whip         .toStringAsFixed(3)                 ))),
                          Expanded(child: Center(child: Text(pitcher.ksPerNine    .toStringAsFixed(3)                 ))),
                        ],
                      ),
                      onTap: ()
                      {
                        context.go(PitcherPage.simpleRouteName + pitcher.id);
                      },
                    ),
                    Divider(),
                  ]
              ]
            );
          }
          else
          {
            return Center(child: CircularProgressIndicator());
          }
        }
      );
  }

  String getLetterGradeFromPercentile(double percentile)
  {
    if (percentile >= 90.0)
    {
      return "A";
    }
    else if (percentile >= 80.0)
    {
      return "B";
    }
    else if (percentile >= 70.0)
    {
      return "C";
    }
    else if (percentile >= 60.0)
    {
      return "D";
    }
    else
    {
      return "F";
    }
  }
}