class StartingPitcherProjection
{
  final String playerId;
  final String name;
  final String team;
  final int qualityStarts;
  final double era;
  final double whip;
  final double ksPerNine;
  final double grade;
  final double percentileQualityStarts;
  final double percentileEra;
  final double percentileWhip;
  final double percentileKsPerNine;
  final double percentileGrade;

  const StartingPitcherProjection({
    required this.playerId,
    required this.name,
    required this.team,
    required this.qualityStarts,
    required this.era,
    required this.whip,
    required this.ksPerNine,
    required this.grade,
    required this.percentileQualityStarts,
    required this.percentileEra,
    required this.percentileWhip,
    required this.percentileKsPerNine,
    required this.percentileGrade,
  });

  factory StartingPitcherProjection.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'playerId': String playerId,
      'firstName': String firstName,
      'lastName': String lastName,
      'team': String team,
      'qualityStarts': int qualityStarts,
      'era': double era,
      'whip': double whip,
      'ksPerNine': double ksPerNine,
      'grade': double grade,
      'percentileQualityStarts': double percentileQualityStarts,
      'percentileEra': double percentileEra,
      'percentileWhip': double percentileWhip,
      'percentileKsPerNine': double percentileKsPerNine,
      'percentileGrade': double percentileGrade,
      } =>
          StartingPitcherProjection(
            playerId: playerId,
            name: "$firstName $lastName",
            team: team,
            qualityStarts: qualityStarts,
            era: era,
            whip: whip,
            ksPerNine: ksPerNine,
            grade: grade,
            percentileQualityStarts: percentileQualityStarts,
            percentileEra: percentileEra,
            percentileWhip: percentileWhip,
            percentileKsPerNine: percentileKsPerNine,
            percentileGrade: percentileGrade,
          ),
      _ => throw const FormatException("Could not read starting pitcher projection!"),
    };
  }
}