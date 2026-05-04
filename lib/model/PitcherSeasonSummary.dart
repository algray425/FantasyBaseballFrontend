class PitcherSeasonSummary
{
  final int season;
  final String teams;
  final int ipOuts;
  final int battersFaced;
  final int hits;
  final int homeRuns;
  final int runs;
  final int earnedRuns;
  final int walks;
  final int intentionalWalks;
  final int strikeOuts;
  final int hitByPitch;
  final int wildPitches;
  final int balks;
  final int stolenBases;
  final int caughtStealing;
  final int passedBalls;
  final int wins;
  final int losses;
  final int saves;
  final int holds;
  final int qualityStarts;
  final int gamesStarted;
  final double era;
  final double whip;
  final double ksPerNine;
  final double walksPerNine;
  final double homeRunsPerNine;
  final double averageFastballVelocity;
  final double averageExitVelocity;
  final double zonePercentage;
  final double chasePercentage;
  final double swingingStrikePercentage;
  final double hardHitPercentage;
  final double barrelPercentage;
  final double groundBallPercentage;
  final double flyBallPercentage;
  final double lineDrivePercentage;
  final double popUpPercentage;
  final double strikeOutPercentage;
  final double walkPercentage;
  final double strikeOutWalkDifference;
  final double homeRunPerFlyBallPercentage;
  final double fip;
  final double csw;

  const PitcherSeasonSummary({
    required this.season,
    required this.teams,
    required this.ipOuts,
    required this.battersFaced,
    required this.hits,
    required this.homeRuns,
    required this.runs,
    required this.earnedRuns,
    required this.walks,
    required this.intentionalWalks,
    required this.strikeOuts,
    required this.hitByPitch,
    required this.wildPitches,
    required this.balks,
    required this.stolenBases,
    required this.caughtStealing,
    required this.passedBalls,
    required this.wins,
    required this.losses,
    required this.saves,
    required this.holds,
    required this.qualityStarts,
    required this.gamesStarted,
    required this.era,
    required this.whip,
    required this.ksPerNine,
    required this.walksPerNine,
    required this.homeRunsPerNine,
    required this.averageFastballVelocity,
    required this.averageExitVelocity,
    required this.zonePercentage,
    required this.chasePercentage,
    required this.swingingStrikePercentage,
    required this.hardHitPercentage,
    required this.barrelPercentage,
    required this.groundBallPercentage,
    required this.flyBallPercentage,
    required this.lineDrivePercentage,
    required this.popUpPercentage,
    required this.strikeOutPercentage,
    required this.walkPercentage,
    required this.strikeOutWalkDifference,
    required this.homeRunPerFlyBallPercentage,
    required this.fip,
    required this.csw
  });

  factory PitcherSeasonSummary.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'season': int season,
      'teams': String teams,
      'ipOuts': int ipOuts,
      'battersFaced': int battersFaced,
      'hits': int hits,
      'homeRuns': int homeRuns,
      'runs': int runs,
      'earnedRuns': int earnedRuns,
      'walks': int walks,
      'intentionalWalks': int intentionalWalks,
      'strikeOuts': int strikeOuts,
      'hitByPitch': int hitByPitch,
      'wildPitches': int wildPitches,
      'balks': int balks,
      'stolenBases': int stolenBases,
      'caughtStealing': int caughtStealing,
      'passedBalls': int passedBalls,
      'wins': int wins,
      'losses': int losses,
      'saves': int saves,
      'holds': int holds,
      'qualityStarts': int qualityStarts,
      'gamesStarted': int gamesStarted,
      'era': double era,
      'whip': double whip,
      'ksPerNine': double ksPerNine,
      'walksPerNine': double walksPerNine,
      'homeRunsPerNine': double homeRunsPerNine,
      'averageFastballVelocity': double averageFastballVelocity,
      'averageExitVelocity': double averageExitVelocity,
      'zonePercentage': double zonePercentage,
      'chasePercentage': double chasePercentage,
      'swingingStrikePercentage': double swingingStrikePercentage,
      'hardHitPercentage': double hardHitPercentage,
      'barrelPercentage': double barrelPercentage,
      'groundBallPercentage': double groundBallPercentage,
      'flyBallPercentage': double flyBallPercentage,
      'lineDrivePercentage': double lineDrivePercentage,
      'popUpPercentage': double popUpPercentage,
      'strikeOutPercentage': double strikeOutPercentage,
      'walkPercentage': double walkPercentage,
      'strikeOutWalkDifference': double strikeOutWalkDifference,
      'homeRunPerFlyBallPercentage': double homeRunPerFlyBallPercentage,
      'fip': double fip,
      'csw': double csw
      } =>
          PitcherSeasonSummary(
            season: season,
            teams: teams,
            ipOuts: ipOuts,
            battersFaced: battersFaced,
            hits: hits,
            homeRuns: homeRuns,
            runs: runs,
            earnedRuns: earnedRuns,
            walks: walks,
            intentionalWalks: intentionalWalks,
            strikeOuts: strikeOuts,
            hitByPitch: hitByPitch,
            wildPitches: wildPitches,
            balks: balks,
            stolenBases: stolenBases,
            caughtStealing: caughtStealing,
            passedBalls: passedBalls,
            wins: wins,
            losses: losses,
            saves: saves,
            holds: holds,
            qualityStarts: qualityStarts,
            gamesStarted: gamesStarted,
            era: era,
            whip: whip,
            ksPerNine: ksPerNine,
            walksPerNine: walksPerNine,
            homeRunsPerNine: homeRunsPerNine,
            averageFastballVelocity: averageFastballVelocity,
            averageExitVelocity: averageExitVelocity,
            zonePercentage: zonePercentage,
            chasePercentage: chasePercentage,
            swingingStrikePercentage: swingingStrikePercentage,
            hardHitPercentage: hardHitPercentage,
            barrelPercentage: barrelPercentage,
            groundBallPercentage: groundBallPercentage,
            flyBallPercentage: flyBallPercentage,
            lineDrivePercentage: lineDrivePercentage,
            popUpPercentage: popUpPercentage,
            strikeOutPercentage: strikeOutPercentage,
            walkPercentage: walkPercentage,
            strikeOutWalkDifference: strikeOutWalkDifference,
            homeRunPerFlyBallPercentage: homeRunPerFlyBallPercentage,
            fip: fip,
            csw: csw
          ),
      _ => throw const FormatException("Could not read team pitching stats!"),
    };
  }
}