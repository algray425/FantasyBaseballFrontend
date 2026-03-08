import 'package:fantasy_baseball_app/widgets/FavoriteButton.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../model/HittingStat.dart';
import '../notifiers/HitterListModel.dart';
import '../pages/HitterPage.dart';
import 'HitterListHeader.dart';

class HitterList extends StatelessWidget
{
  const HitterList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HitterListModel>(
        builder: (context, hitterListModel, child) {
          return ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              ListTile(
                title: Row(
                  children: [
                    Expanded(child: Center(child: Text("Favorite"))),
                    Expanded(child: Center(child: Text("Name"))),
                    Expanded(child: Center(child: Text("Team"))),
                    Expanded(child: Center(child: Text("Pos"))),
                    HitterListHeader(text: "Grade"        , hittingStat: HittingStat.PERCENTILE_OVERALL , callback: Provider.of<HitterListModel>(context, listen: false).updateSort),
                    HitterListHeader(text: "Runs"         , hittingStat: HittingStat.RUNS               , callback: Provider.of<HitterListModel>(context, listen: false).updateSort),
                    HitterListHeader(text: "Home Runs"    , hittingStat: HittingStat.HOME_RUNS          , callback: Provider.of<HitterListModel>(context, listen: false).updateSort),
                    HitterListHeader(text: "RBIs"         , hittingStat: HittingStat.RBIS               , callback: Provider.of<HitterListModel>(context, listen: false).updateSort),
                    HitterListHeader(text: "Stolen Bases" , hittingStat: HittingStat.STOLEN_BASES       , callback: Provider.of<HitterListModel>(context, listen: false).updateSort),
                    HitterListHeader(text: "OBP"          , hittingStat: HittingStat.OBP                , callback: Provider.of<HitterListModel>(context, listen: false).updateSort)
                  ],
                ),
              ),
              Divider(),
              if (hitterListModel.finishedLoading)
                for (final player in hitterListModel.players)...[
                  ListTile(
                    title: Row(
                      children: [
                        Expanded(child: FavoriteButton(id: player.id, name: player.name, position: player.position, team: player.team, marginLeft: 0, marginRight: 0, marginTop: 0, marginBottom: 0)),
                        Expanded(child: Center(child: Text(player.name                                            ))),
                        Expanded(child: Center(child: Text(player.team                                            ))),
                        Expanded(child: Center(child: Text(player.position                                        ))),
                        Expanded(child: Center(child: Text(getLetterGradeFromPercentile(player.overallPercentile) ))),
                        Expanded(child: Center(child: Text(player.runs        .toString()                         ))),
                        Expanded(child: Center(child: Text(player.homeRuns    .toString()                         ))),
                        Expanded(child: Center(child: Text(player.rbis        .toString()                         ))),
                        Expanded(child: Center(child: Text(player.stolenBases .toString()                         ))),
                        Expanded(child: Center(child: Text(player.obp         .toString()                         ))),
                      ],
                    ),
                    onTap: () {
                      context.go(HitterPage.simpleRouteName + player.id);
                    },
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