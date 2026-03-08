class TeamMatchupSummary
{
  final int teamId;
  final int wins;
  final int losses;
  final int ties;
  final int runs;
  final int homeRuns;
  final int rbis;
  final int stolenBases;
  final double onBasePercentage;
  final int qualityStarts;
  final int savesPlusHolds;
  final double era;
  final double whip;
  final double ksPerNine;

  const TeamMatchupSummary({
    required this.teamId,
    required this.wins,
    required this.losses,
    required this.ties,
    required this.runs,
    required this.homeRuns,
    required this.rbis,
    required this.stolenBases,
    required this.onBasePercentage,
    required this.qualityStarts,
    required this.savesPlusHolds,
    required this.era,
    required this.whip,
    required this.ksPerNine,
  });

  factory TeamMatchupSummary.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'teamId': int teamId,
      'wins': int wins,
      'losses': int losses,
      'ties': int ties,
      'runs': int runs,
      'homeRuns': int homeRuns,
      'rbis': int rbis,
      'stolenBases': int stolenBases,
      'onBasePercentage': double onBasePercentage,
      'qualityStarts': int qualityStarts,
      'savesPlusHolds': int savesPlusHolds,
      'era': double era,
      'whip': double whip,
      'ksPerNine': double ksPerNine,
      } =>
          TeamMatchupSummary(
            teamId: teamId,
            wins: wins,
            losses: losses,
            ties: ties,
            runs: runs,
            homeRuns: homeRuns,
            rbis: rbis,
            stolenBases: stolenBases,
            onBasePercentage: onBasePercentage,
            qualityStarts: qualityStarts,
            savesPlusHolds: savesPlusHolds,
            era: era,
            whip: whip,
            ksPerNine: ksPerNine,
          ),
      _ => throw const FormatException("Could not read team matchup summary!"),
    };
  }
}