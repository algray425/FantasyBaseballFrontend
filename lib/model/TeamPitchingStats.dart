class TeamPitchingStats
{
  final String team;
  final int season;
  final int ipOuts;
  final int battersFaced;
  final int hits;
  final int singles;
  final int doubles;
  final int triples;
  final int homeRuns;
  final int runs;
  final int earnedRuns;
  final int walks;
  final int intentionalWalks;
  final int strikeOuts;
  final int hitByPitch;
  final int wildPitches;
  final int balks;
  final int sacHits;
  final int sacFlies;
  final int stolenBases;
  final int caughtStealing;
  final int passedBalls;
  final double era;
  final double whip;
  final double ksPerNine;
  final int rbisAgainst;
  final double onBasePercentageAgainst;

  const TeamPitchingStats({
    required this.team,
    required this.season,
    required this.ipOuts,
    required this.battersFaced,
    required this.hits,
    required this.singles,
    required this.doubles,
    required this.triples,
    required this.homeRuns,
    required this.runs,
    required this.earnedRuns,
    required this.walks,
    required this.intentionalWalks,
    required this.strikeOuts,
    required this.hitByPitch,
    required this.wildPitches,
    required this.balks,
    required this.sacHits,
    required this.sacFlies,
    required this.stolenBases,
    required this.caughtStealing,
    required this.passedBalls,
    required this.era,
    required this.whip,
    required this.ksPerNine,
    required this.rbisAgainst,
    required this.onBasePercentageAgainst,
  });

  factory TeamPitchingStats.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'team': String team,
      'season': int season,
      'ipOuts': int ipOuts,
      'battersFaced': int battersFaced,
      'hits': int hits,
      'singles': int singles,
      'doubles': int doubles,
      'triples': int triples,
      'homeRuns': int homeRuns,
      'runs': int runs,
      'earnedRuns': int earnedRuns,
      'walks': int walks,
      'intentionalWalks': int intentionalWalks,
      'strikeOuts': int strikeOuts,
      'hitByPitch': int hitByPitch,
      'wildPitches': int wildPitches,
      'balks': int balks,
      'sacHits': int sacHits,
      'sacFlies': int sacFlies,
      'stolenBases': int stolenBases,
      'caughtStealing': int caughtStealing,
      'passedBalls': int passedBalls,
      'era': double era,
      'whip': double whip,
      'ksPerNine': double ksPerNine,
      'rbisAgainst': int rbisAgainst,
      'onBasePercentageAgainst': double onBasePercentageAgainst,
      } =>
          TeamPitchingStats(
            team: team,
            season: season,
            ipOuts: ipOuts,
            battersFaced: battersFaced,
            hits: hits,
            singles: singles,
            doubles: doubles,
            triples: triples,
            homeRuns: homeRuns,
            runs: runs,
            earnedRuns: earnedRuns,
            walks: walks,
            intentionalWalks: intentionalWalks,
            strikeOuts: strikeOuts,
            hitByPitch: hitByPitch,
            wildPitches: wildPitches,
            balks: balks,
            sacHits: sacHits,
            sacFlies: sacFlies,
            stolenBases: stolenBases,
            caughtStealing: caughtStealing,
            passedBalls: passedBalls,
            era: era,
            whip: whip,
            ksPerNine: ksPerNine,
            rbisAgainst: rbisAgainst,
            onBasePercentageAgainst: onBasePercentageAgainst,
          ),
      _ => throw const FormatException("Could not read team pitching stats!"),
    };
  }
}