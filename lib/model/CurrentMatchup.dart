import 'TeamMatchupSummary.dart';

class CurrentMatchup
{
  final TeamMatchupSummary homeTeamSummary;
  final TeamMatchupSummary awayTeamSummary;

  const CurrentMatchup({
    required this.homeTeamSummary,
    required this.awayTeamSummary,
  });

  factory CurrentMatchup.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'homeTeamSummary': Map<String, dynamic> homeTeamSummary,
      'awayTeamSummary': Map<String, dynamic> awayTeamSummary,
      } =>
          CurrentMatchup(
            homeTeamSummary: TeamMatchupSummary.fromJson(homeTeamSummary),
            awayTeamSummary: TeamMatchupSummary.fromJson(awayTeamSummary),
          ),
      _ => throw const FormatException("Could not read current matchup!"),
    };
  }
}