import 'package:fantasy_baseball_app/model/HitterModel.dart';
import 'package:fantasy_baseball_app/model/ReliefPitcherSummary.dart';
import 'package:fantasy_baseball_app/model/StartingPitcherSummary.dart';

import 'TeamSchedule.dart';

class TeamSummary {
  final String team;
  final int season;
  final int runs;
  final int homeRuns;
  final int rbisAgainst;
  final int stolenBases;
  final double onBasePercentageAgainst;
  final double eraAgainst;
  final double whipAgainst;
  final double ksPerNineAgainst;
  final int qualityStartsAgainst;
  final int savesAgainst;
  final int holdsAgainst;
  final double percentileEra;
  final double percentileWhip;
  final double percentileKsPerNine;
  final double percentileQualityStarts;
  final double percentileSavesAndHolds;
  final double percentileStartingPitchers;
  final double percentileReliefPitchers;
  final double percentileHittingOverall;
  final double percentileRuns;
  final double percentileHomeRuns;
  final double percentileRbis;
  final double percentileStolenBases;
  final double percentileOnBasePercentage;
  final double percentilePitchingOverall;

  final List<HitterModel> teamBatters;
  final List<StartingPitcherSummary> teamStartingPitchers;
  final List<ReliefPitcherSummary> teamReliefPitchers;
  final TeamSchedule teamSchedule;

  const TeamSummary({
    required this.team,
    required this.season,
    required this.runs,
    required this.homeRuns,
    required this.rbisAgainst,
    required this.stolenBases,
    required this.onBasePercentageAgainst,
    required this.eraAgainst,
    required this.whipAgainst,
    required this.ksPerNineAgainst,
    required this.qualityStartsAgainst,
    required this.savesAgainst,
    required this.holdsAgainst,
    required this.percentileEra,
    required this.percentileWhip,
    required this.percentileKsPerNine,
    required this.percentileQualityStarts,
    required this.percentileSavesAndHolds,
    required this.percentileStartingPitchers,
    required this.percentileReliefPitchers,
    required this.percentileHittingOverall,
    required this.percentileRuns,
    required this.percentileHomeRuns,
    required this.percentileRbis,
    required this.percentileStolenBases,
    required this.percentileOnBasePercentage,
    required this.percentilePitchingOverall,
    required this.teamBatters,
    required this.teamStartingPitchers,
    required this.teamReliefPitchers,
    required this.teamSchedule,
  });

  factory TeamSummary.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'team': String team,
      'season': int season,
      'runs': int runs,
      'homeRuns': int homeRuns,
      'rbisAgainst': int rbisAgainst,
      'stolenBases': int stolenBases,
      'onBasePercentageAgainst': double onBasePercentageAgainst,
      'eraAgainst': double eraAgainst,
      'whipAgainst': double whipAgainst,
      'ksPerNineAgainst': double ksPerNineAgainst,
      'qualityStartsAgainst': int qualityStartsAgainst,
      'savesAgainst': int savesAgainst,
      'holdsAgainst': int holdsAgainst,
      'percentileEra': double percentileEra,
      'percentileWhip': double percentileWhip,
      'percentileKsPerNine': double percentileKsPerNine,
      'percentileQualityStarts': double percentileQualityStarts,
      'percentileSavesAndHolds': double percentileSavesAndHolds,
      'percentileStartingPitchers': double percentileStartingPitchers,
      'percentileReliefPitchers': double percentileReliefPitchers,
      'percentileHittingOverall': double percentileHittingOverall,
      'percentileRuns': double percentileRuns,
      'percentileHomeRuns': double percentileHomeRuns,
      'percentileRbis': double percentileRbis,
      'percentileStolenBases': double percentileStolenBases,
      'percentileOnBasePercentage': double percentileOnBasePercentage,
      'percentilePitchingOverall': double percentilePitchingOverall,
      'teamBatters': List<dynamic> teamBatters,
      'teamStartingPitchers': List<dynamic> teamStartingPitchers,
      'teamReliefPitchers': List<dynamic> teamReliefPitchers,
      'teamSchedule': Map<String, dynamic> teamSchedule,
      } =>
          TeamSummary(
            team: team,
            season: season,
            runs: runs,
            homeRuns: homeRuns,
            rbisAgainst: rbisAgainst,
            stolenBases: stolenBases,
            onBasePercentageAgainst: onBasePercentageAgainst,
            eraAgainst: eraAgainst,
            whipAgainst: whipAgainst,
            ksPerNineAgainst: ksPerNineAgainst,
            qualityStartsAgainst: qualityStartsAgainst,
            savesAgainst: savesAgainst,
            holdsAgainst: holdsAgainst,
            percentileEra: percentileEra,
            percentileWhip: percentileWhip,
            percentileKsPerNine: percentileKsPerNine,
            percentileQualityStarts: percentileQualityStarts,
            percentileSavesAndHolds: percentileSavesAndHolds,
            percentileStartingPitchers: percentileStartingPitchers,
            percentileReliefPitchers: percentileReliefPitchers,
            percentileHittingOverall: percentileHittingOverall,
            percentileRuns: percentileRuns,
            percentileHomeRuns: percentileHomeRuns,
            percentileRbis: percentileRbis,
            percentileStolenBases: percentileStolenBases,
            percentileOnBasePercentage: percentileOnBasePercentage,
            percentilePitchingOverall: percentilePitchingOverall,
            teamBatters: teamBatters
                .map((b) => HitterModel.fromJson(b as Map<String, dynamic>))
                .toList(),
            teamStartingPitchers: teamStartingPitchers
                .map((p) => StartingPitcherSummary.fromJson(p as Map<String, dynamic>))
                .toList(),
            teamReliefPitchers: teamReliefPitchers
                .map((p) => ReliefPitcherSummary.fromJson(p as Map<String, dynamic>))
                .toList(),
            teamSchedule: TeamSchedule.fromJson(teamSchedule),
          ),
      _ => throw const FormatException("Could not read team summary!"),
    };
  }

}