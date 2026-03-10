import 'package:fantasy_baseball_app/pages/PitcherPage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:fantasy_baseball_app/widgets/FavoriteButton.dart';
import 'package:fantasy_baseball_app/model/PitchingStat.dart';
import 'package:fantasy_baseball_app/notifiers/StartingPitcherProjectionsModel.dart';
import 'package:fantasy_baseball_app/widgets/PitcherListHeader.dart';

class StartingPitcherProjectionList extends StatelessWidget
{
  const StartingPitcherProjectionList({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Consumer<StartingPitcherProjectionsModel>(
        builder: (context, pitcherProjectionsModel, child) {
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
                        PitcherListHeader(text: "Grade Overall"   , pitchingStat: PitchingStat.PERCENTILE_OVERALL , callback: Provider.of<StartingPitcherProjectionsModel>(context, listen: false).updateSort),
                        PitcherListHeader(text: "Quality Starts"  , pitchingStat: PitchingStat.QUALITY_STARTS     , callback: Provider.of<StartingPitcherProjectionsModel>(context, listen: false).updateSort),
                        PitcherListHeader(text: "ERA"             , pitchingStat: PitchingStat.ERA                , callback: Provider.of<StartingPitcherProjectionsModel>(context, listen: false).updateSort),
                        PitcherListHeader(text: "WHIP"            , pitchingStat: PitchingStat.WHIP               , callback: Provider.of<StartingPitcherProjectionsModel>(context, listen: false).updateSort),
                        PitcherListHeader(text: "Ks/9"            , pitchingStat: PitchingStat.KS_PER_NINE        , callback: Provider.of<StartingPitcherProjectionsModel>(context, listen: false).updateSort),
                      ])
                    ))
                  ],
                ),
              ),
              Divider(),
              if (pitcherProjectionsModel.finishedLoading)
                for (final projection in pitcherProjectionsModel.projections)...[
                  ListTile(
                    title: Row(
                      children: [
                        Expanded(child: FavoriteButton(id: projection.playerId, name: projection.name, position: "P", team: projection.team, marginLeft: 0, marginRight: 0, marginTop: 0, marginBottom: 0)),
                        Expanded(child: Center(child: Text(projection.name                                        ))),
                        Expanded(child: Center(child: Text(projection.team                                        ))),
                        Expanded(child: Center(child: Text(getLetterGradeFromPercentile(projection.percentileGrade)))),
                        Expanded(child: Center(child: Text(projection.qualityStarts .toString()                   ))),
                        Expanded(child: Center(child: Text(projection.era           .toStringAsFixed(2)           ))),
                        Expanded(child: Center(child: Text(projection.whip          .toStringAsFixed(2)           ))),
                        Expanded(child: Center(child: Text(projection.ksPerNine     .toStringAsFixed(1)           ))),
                      ],
                    ),
                    onTap: () {
                      context.go(PitcherPage.simpleRouteName + projection.playerId);
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