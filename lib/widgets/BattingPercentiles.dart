import 'package:flutter/material.dart';

import 'package:fantasy_baseball_app/model/HitterSummary.dart';
import 'package:fantasy_baseball_app/widgets/StatPercentileBar.dart';

class BattingPercentiles extends StatelessWidget
{
  final HitterSummary hitterSummary;

  const BattingPercentiles({super.key, required this.hitterSummary});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //TODO: Need the percentiles of in season stats, not projections
        // StatPercentileBar(statName: "Runs",         percentile: hitterSummary.overallPercentileRuns),
        // StatPercentileBar(statName: "Home Runs",    percentile: hitterSummary.overallPercentileHomeRuns),
        // StatPercentileBar(statName: "RBIs",         percentile: hitterSummary.overallPercentileRbis),
        // StatPercentileBar(statName: "Stolen Bases", percentile: hitterSummary.overallPercentileStolenBases),
        // StatPercentileBar(statName: "OBP",          percentile: hitterSummary.overallPercentileObp),
        StatPercentileBar(statName: "Hard Hit%",    percentile: hitterSummary.hardHitPercentile),
        StatPercentileBar(statName: "Barrel%",      percentile: hitterSummary.barrelPercentile),
        StatPercentileBar(statName: "BABIP",        percentile: hitterSummary.babipPercentile),
        StatPercentileBar(statName: "SPD",          percentile: hitterSummary.spdPercentile)
      ]
    );
  }
}