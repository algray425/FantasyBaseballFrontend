class StartingPitcherSummary
{
  final String  id;
  final String  name;
  final String  team;
  final double  overallPercentile;
  final int     qualityStarts;
  final double  era;
  final double  whip;
  final double  ksPerNine;
  double  overallPercentileQualityStarts = 0.0;
  double  overallPercentileEra = 0.0;
  double  overallPercentileWhip = 0.0;
  double  overallPercentileKsPerNine = 0.0;

  StartingPitcherSummary({required this.id, required this.name, required this.team,
    required this.overallPercentile, required this.qualityStarts, required this.era, required this.whip,
  required this.ksPerNine});

  factory StartingPitcherSummary.fromJson(Map<String, dynamic> json)
  {
    return switch(json) {
      { 'playerId': String playerId, 'firstName': String firstName, 'lastName': String lastName, 'team': String team, 'grade': double overallPercentile, 'qualityStarts': int qualityStarts, 'era': double era, 'whip': double whip, 'ksPerNine': double ksPerNine } =>
        StartingPitcherSummary(
          id: playerId,
          name: "$firstName $lastName",
          team: team,
          overallPercentile: overallPercentile,
          qualityStarts: qualityStarts,
          era: era,
          whip: whip,
          ksPerNine: ksPerNine
        ),
        _ => throw const FormatException("Could not parse starting pitcher summary!")
    };
  }
}