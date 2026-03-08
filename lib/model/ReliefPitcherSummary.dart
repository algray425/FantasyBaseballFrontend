class ReliefPitcherSummary
{
  final String  id;
  final String  name;
  final String  team;
  final double  overallPercentile;
  final int     saves;
  final int     holds;
  final double  era;
  final double  whip;
  final double  ksPerNine;
  double        overallPercentileSavesAndHolds = 0.0;
  double        overallPercentileEra           = 0.0;
  double        overallPercentileWhip          = 0.0;
  double        overallPercentileKsPerNine     = 0.0;

  ReliefPitcherSummary({required this.id, required this.name, required this.team,
    required this.overallPercentile, required this.saves, required this.holds, required this.era, required this.whip,
    required this.ksPerNine});

  factory ReliefPitcherSummary.fromJson(Map<String, dynamic> json)
  {
    return switch(json) {
      { 'playerId': String playerId, 'firstName': String firstName, 'lastName': String lastName, 'team': String team, 'grade': double overallPercentile, 'saves': int saves, 'holds': int holds, 'era': double era, 'whip': double whip, 'ksPerNine': double ksPerNine } =>
          ReliefPitcherSummary(
              id: playerId,
              name: "$firstName $lastName",
              team: team,
              overallPercentile: overallPercentile,
              saves: saves,
              holds: holds,
              era: era,
              whip: whip,
              ksPerNine: ksPerNine
          ),
      _ => throw const FormatException("Could not parse relief pitcher summary!")
    };
  }
}