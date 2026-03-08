import 'OpposingPitcherSummary.dart';

class HitterGame
{
  final String                    opposingTeam;
  final String                    venue;
  final String                    date;
  final double?                   opposingTeamPitchingGrade;
  final OpposingPitcherSummary?   opposingPitcherSummary;

  const HitterGame({required this.opposingTeam, required this.venue, required this.date, required this.opposingTeamPitchingGrade, required this.opposingPitcherSummary});

  factory HitterGame.fromJson(Map<String, dynamic> json)
  {
    return switch(json) {
      { 'opposingTeam': String opposingTeam, 'venue': String venue, 'date': String date, 'opposingTeamPitchingPercentileOverall': double? oppPitchingPercentileOverall, 'opposingPitcher': Map<String, dynamic>? opposingPitcher } =>
          HitterGame(
            opposingTeam              : opposingTeam,
            venue                     : venue,
            date                      : date,
            opposingTeamPitchingGrade : oppPitchingPercentileOverall,
            opposingPitcherSummary    : opposingPitcher == null ? null : OpposingPitcherSummary.fromJson(opposingPitcher)
          ),
          _ => throw const FormatException("Could not parse hitter upcoming schedule!"),
    };
  }
}