class TeamHittingStats
{
  final String team;
  final int season;
  final int plateAppearances;
  final int atBats;
  final int runs;
  final int hits;
  final int singles;
  final int doubles;
  final int triples;
  final int homeRuns;
  final int rbis;
  final int sacHits;
  final int sacFlies;
  final int hitByPitch;
  final int walks;
  final int intentionalWalks;
  final int strikeOuts;
  final int stolenBases;
  final int caughtStealing;
  final int groundIntoDoublePlays;
  final int catcherInterference;
  final double battingAverage;
  final double onBasePercentage;
  final double sluggingPercentage;
  final double onBasePlusSlugging;
  final double eraAgainst;
  final double whipAgainst;
  final double ksPerNineAgainst;
  final int qualityStartsAgainst;
  final int savesAgainst;
  final int holdsAgainst;

  const TeamHittingStats({
    required this.team,
    required this.season,
    required this.plateAppearances,
    required this.atBats,
    required this.runs,
    required this.hits,
    required this.singles,
    required this.doubles,
    required this.triples,
    required this.homeRuns,
    required this.rbis,
    required this.sacHits,
    required this.sacFlies,
    required this.hitByPitch,
    required this.walks,
    required this.intentionalWalks,
    required this.strikeOuts,
    required this.stolenBases,
    required this.caughtStealing,
    required this.groundIntoDoublePlays,
    required this.catcherInterference,
    required this.battingAverage,
    required this.onBasePercentage,
    required this.sluggingPercentage,
    required this.onBasePlusSlugging,
    required this.eraAgainst,
    required this.whipAgainst,
    required this.ksPerNineAgainst,
    required this.qualityStartsAgainst,
    required this.savesAgainst,
    required this.holdsAgainst,
  });

  factory TeamHittingStats.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'team': String team,
      'season': int season,
      'plateAppearances': int plateAppearances,
      'atBats': int atBats,
      'runs': int runs,
      'hits': int hits,
      'singles': int singles,
      'doubles': int doubles,
      'triples': int triples,
      'homeRuns': int homeRuns,
      'rbis': int rbis,
      'sacHits': int sacHits,
      'sacFlies': int sacFlies,
      'hitByPitch': int hitByPitch,
      'walks': int walks,
      'intentionalWalks': int intentionalWalks,
      'strikeOuts': int strikeOuts,
      'stolenBases': int stolenBases,
      'caughtStealing': int caughtStealing,
      'groundIntoDoublePlays': int groundIntoDoublePlays,
      'catcherInterference': int catcherInterference,
      'battingAverage': double battingAverage,
      'onBasePercentage': double onBasePercentage,
      'sluggingPercentage': double sluggingPercentage,
      'onBasePlusSlugging': double onBasePlusSlugging,
      'eraAgainst': double eraAgainst,
      'whipAgainst': double whipAgainst,
      'ksPerNineAgainst': double ksPerNineAgainst,
      'qualityStartsAgainst': int qualityStartsAgainst,
      'savesAgainst': int savesAgainst,
      'holdsAgainst': int holdsAgainst,
      } =>
          TeamHittingStats(
            team: team,
            season: season,
            plateAppearances: plateAppearances,
            atBats: atBats,
            runs: runs,
            hits: hits,
            singles: singles,
            doubles: doubles,
            triples: triples,
            homeRuns: homeRuns,
            rbis: rbis,
            sacHits: sacHits,
            sacFlies: sacFlies,
            hitByPitch: hitByPitch,
            walks: walks,
            intentionalWalks: intentionalWalks,
            strikeOuts: strikeOuts,
            stolenBases: stolenBases,
            caughtStealing: caughtStealing,
            groundIntoDoublePlays: groundIntoDoublePlays,
            catcherInterference: catcherInterference,
            battingAverage: battingAverage,
            onBasePercentage: onBasePercentage,
            sluggingPercentage: sluggingPercentage,
            onBasePlusSlugging: onBasePlusSlugging,
            eraAgainst: eraAgainst,
            whipAgainst: whipAgainst,
            ksPerNineAgainst: ksPerNineAgainst,
            qualityStartsAgainst: qualityStartsAgainst,
            savesAgainst: savesAgainst,
            holdsAgainst: holdsAgainst,
          ),
      _ => throw const FormatException("Could not read team hitting stats!"),
    };
  }
}