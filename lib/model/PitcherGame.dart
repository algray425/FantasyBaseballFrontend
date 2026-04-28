class PitcherGame
{
  final String                    opposingTeam;
  final String                    venue;
  final String                    date;
  final bool                      isStarting;
  final double?                   opposingTeamHittingGrade;

  const PitcherGame({required this.opposingTeam, required this.venue, required this.date, required this.isStarting, required this.opposingTeamHittingGrade});

  factory PitcherGame.fromJson(Map<String, dynamic> json)
  {
    return switch(json) {
      { 'opposingTeam': String opposingTeam, 'venue': String venue, 'date': String date, 'starting': bool starting, 'opposingTeamHittingPercentileOverall': double? oppHittingPercentileOverall } =>
      PitcherGame(
        opposingTeam: opposingTeam,
        venue: venue,
        date: date,
        isStarting: starting,
        opposingTeamHittingGrade: oppHittingPercentileOverall
      ),
      _ => throw const FormatException("Could not parse pitcher upcoming schedule!")
    };
  }
}