import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'HitterListHeader.dart';
import 'package:fantasy_baseball_app/model/HittingStat.dart';
import 'package:fantasy_baseball_app/notifiers/HitterProjectionsModel.dart';
import 'package:fantasy_baseball_app/pages/HitterPage.dart';
import 'package:fantasy_baseball_app/widgets/FavoriteButton.dart';

class ProjectionList extends StatelessWidget
{
  const ProjectionList({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Consumer<HitterProjectionsModel>(
        builder: (context, hitterProjectionsModel, child) {
          return ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              ListTile(
                title: Row(
                  children: [
                    Expanded(child: InkWell(
                      hoverColor: Colors.grey.withValues(alpha: 0.15),
                      child: Row(children: [
                        Expanded(child: Center(child: Text("Favorite"))),
                        Expanded(child: Center(child: Text("Name"))),
                        Expanded(child: Center(child: Text("Team"))),
                        Expanded(child: Center(child: Text("Pos"))),
                        HitterListHeader(text: "Grade Overall"  , hittingStat: HittingStat.PERCENTILE_OVERALL   , callback: Provider.of<HitterProjectionsModel>(context, listen: false).updateSort),
                        HitterListHeader(text: "Grade Qualified", hittingStat: HittingStat.PERCENTILE_QUALIFIED , callback: Provider.of<HitterProjectionsModel>(context, listen: false).updateSort),
                        HitterListHeader(text: "Runs"           , hittingStat: HittingStat.RUNS                 , callback: Provider.of<HitterProjectionsModel>(context, listen: false).updateSort),
                        HitterListHeader(text: "Home Runs"      , hittingStat: HittingStat.HOME_RUNS            , callback: Provider.of<HitterProjectionsModel>(context, listen: false).updateSort),
                        HitterListHeader(text: "RBIs"           , hittingStat: HittingStat.RBIS                 , callback: Provider.of<HitterProjectionsModel>(context, listen: false).updateSort),
                        HitterListHeader(text: "Stolen Bases"   , hittingStat: HittingStat.STOLEN_BASES         , callback: Provider.of<HitterProjectionsModel>(context, listen: false).updateSort),
                        HitterListHeader(text: "OBP"            , hittingStat: HittingStat.OBP                  , callback: Provider.of<HitterProjectionsModel>(context, listen: false).updateSort),
                      ])
                    ))
                  ],
                ),
              ),
              Divider(),
              if (hitterProjectionsModel.finishedLoading)
                for (final projection in hitterProjectionsModel.projections)...[
                  ListTile(
                    title: Row(
                      children: [
                        Expanded(child: FavoriteButton(id: projection.id, name: projection.name, position: projection.position, team: projection.team, marginLeft: 0, marginRight: 0, marginTop: 0, marginBottom: 0)),
                        Expanded(child: Center(child: Text(projection.name                                            ))),
                        Expanded(child: Center(child: Text(projection.team                                            ))),
                        Expanded(child: Center(child: Text(projection.position                                        ))),
                        Expanded(child: Center(child: Text(getLetterGradeFromPercentile(projection.overallPercentile) ))),
                        Expanded(child: Center(child: Text(getLetterGradeFromPercentile(projection.qualifiedPercentile)))),
                        Expanded(child: Center(child: Text(projection.runs        .toString()                         ))),
                        Expanded(child: Center(child: Text(projection.homeRuns    .toString()                         ))),
                        Expanded(child: Center(child: Text(projection.rbis        .toString()                         ))),
                        Expanded(child: Center(child: Text(projection.stolenBases .toString()                         ))),
                        Expanded(child: Center(child: Text(projection.obp         .toString()                         ))),
                      ],
                    ),
                    onTap: () {
                      context.go(HitterPage.simpleRouteName + projection.id);
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