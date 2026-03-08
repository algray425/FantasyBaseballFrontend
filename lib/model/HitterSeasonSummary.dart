class HitterSeasonSummary
{
  final int season;
  final String teams;
  final int plateAppearances;
  final int atBats;
  final int runs;
  final int hits;
  final int doubles;
  final int triples;
  final int homeRuns;
  final int rbis;
  final int walks;
  final int strikeOuts;
  final int stolenBases;
  final double battingAverage;
  final double onBasePercentage;
  final double sluggingPercentage;
  final double onBasePlusSlugging;
  final double babip;
  final double spd;
  final double groundBallPercentage;
  final double flyBallPercentage;
  final double lineDrivePercentage;
  final double popUpPercentage;
  final double hardHitPercentage;
  final double barrelPercentage;

  const HitterSeasonSummary({required this.season, required this.teams, required this.plateAppearances,
    required this.atBats, required this.runs, required this.hits, required this.doubles, required this.triples,
    required this.homeRuns, required this.rbis, required this.walks, required this.strikeOuts, required this.stolenBases,
    required this.battingAverage, required this.onBasePercentage, required this.sluggingPercentage, required this.onBasePlusSlugging,
    required this.babip, required this.spd, required this.groundBallPercentage, required this.flyBallPercentage,
    required this.lineDrivePercentage, required this.popUpPercentage, required this.hardHitPercentage, required this.barrelPercentage});

  factory HitterSeasonSummary.fromJson(Map<String, dynamic> json)
  {
    return switch(json) {
      { 'season': int season, 'teams': String teams, 'plateAppearances': int plateAppearances, 'atBats': int atBats,
      'runs': int runs, 'hits': int hits, 'doubles': int doubles, 'triples': int triples, 'homeRuns': int homeRuns,
      'rbis': int rbis, 'walks': int walks, 'strikeOuts': int strikeOuts, 'stolenBases': int stolenBases,
      'battingAverage': double battingAverage, 'onBasePercentage': double onBasePercentage, 'sluggingPercentage': double sluggingPercentage,
      'onBasePlusSlugging': double onBasePlusSlugging, 'babip': double babip, 'spd': double spd, 'groundBallPercentage': double groundBallPercentage,
      'flyBallPercentage': double flyBallPercentage, 'lineDrivePercentage': double lineDrivePercentage, 'popUpPercentage': double popUpPercentage,
      'hardHitPercentage': double hardHitPercentage, 'barrelPercentage': double barrelPercentage} =>
      HitterSeasonSummary(season: season, teams: teams, plateAppearances: plateAppearances, atBats: atBats, runs: runs, hits: hits,
          doubles: doubles, triples: triples, homeRuns: homeRuns, rbis: rbis, walks: walks, strikeOuts: strikeOuts, stolenBases: stolenBases,
          battingAverage: battingAverage, onBasePercentage: onBasePercentage, sluggingPercentage:sluggingPercentage, onBasePlusSlugging: onBasePlusSlugging,
          babip: babip, spd: spd, groundBallPercentage: groundBallPercentage, flyBallPercentage: flyBallPercentage, lineDrivePercentage:lineDrivePercentage,
          popUpPercentage: popUpPercentage, hardHitPercentage: hardHitPercentage, barrelPercentage: barrelPercentage),
      _ => throw const FormatException("Could not read hitter summary!"),
    };
  }
}