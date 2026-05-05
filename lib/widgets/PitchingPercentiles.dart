import 'package:flutter/material.dart';

import 'package:fantasy_baseball_app/model/PitcherSummary.dart';
import 'package:fantasy_baseball_app/widgets/StatPercentileBar.dart';

class PitchingPercentiles extends StatelessWidget
{
  final PitcherSummary pitcherSummary;

  const PitchingPercentiles({super.key, required this.pitcherSummary});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (pitcherSummary.percentileEra != null)...[
          StatPercentileBar(statName: "ERA", percentile: pitcherSummary.percentileEra)
        ],
        if (pitcherSummary.percentileWhip != null)...[
          StatPercentileBar(statName: "WHIP", percentile: pitcherSummary.percentileWhip)
        ],
        if (pitcherSummary.percentileKsPerNine != null)...[
          StatPercentileBar(statName: "Ks/9", percentile: pitcherSummary.percentileKsPerNine)
        ],
        if (pitcherSummary.percentileQualityStarts != null)...[
          StatPercentileBar(statName: "Quality Starts", percentile: pitcherSummary.percentileQualityStarts)
        ],
        if (pitcherSummary.percentileSavesAndHolds != null)...[
          StatPercentileBar(statName: "Saves + Holds", percentile: pitcherSummary.percentileSavesAndHolds)
        ],
        if (pitcherSummary.percentileFip != null)...[
          StatPercentileBar(statName: "FIP", percentile: pitcherSummary.percentileFip)
        ],
        if (pitcherSummary.percentileOverall != null)...[
          StatPercentileBar(statName: "Overall", percentile: pitcherSummary.percentileOverall)
        ]
      ],
    );
  }
}