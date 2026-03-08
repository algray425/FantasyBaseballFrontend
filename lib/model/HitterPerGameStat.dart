class HitterPerGameStat
{
  final String gameId;
  final String date;
  final String homeTeam;
  final String awayTeam;
  final double stat;

  const HitterPerGameStat({required this.gameId, required this.date, required this.homeTeam, required this.awayTeam, required this.stat});

  factory HitterPerGameStat.fromJson(Map<String, dynamic> json)
  {
    return switch(json) {
      {'gameId': String gameId, 'date': String date, 'homeTeam': String homeTeam, 'awayTeam': String awayTeam, 'stat': double stat} =>
      HitterPerGameStat(
        gameId: gameId,
        date: date,
        homeTeam: homeTeam,
        awayTeam: awayTeam,
        stat: stat
      ),
      _ => throw const FormatException("Could not read hitter per game stats!"),
    };
  }
}