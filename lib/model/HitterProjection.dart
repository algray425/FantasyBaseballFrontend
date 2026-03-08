class HitterProjection
{
  final String  id;
  final String  name;
  final String  team;
  final String  position;
  final double  overallPercentile;
  final double  qualifiedPercentile;
  final int     runs;
  final int     homeRuns;
  final int     rbis;
  final int     stolenBases;
  final double  obp;

  const HitterProjection({required this.id, required this.name, required this.team, required this.position, required this.overallPercentile, required this.qualifiedPercentile,
  required this.runs, required this.homeRuns, required this.rbis, required this.stolenBases, required this.obp});

  factory HitterProjection.fromJson(Map<String, dynamic> json)
  {
    return switch(json) {
      { 'playerId': String playerId, 'firstName': String firstName, 'lastName': String lastName, 'team': String team, 'position': String position,
      'overallPercentileGrade': double overallPercentile, 'qualifiedPercentileGrade': double qualifiedPercentile,
      'runs': int runs, 'homeRuns': int homeRuns, 'rbis': int rbis, 'stolenBases': int stolenBases, 'onBasePercentage': double obp } =>
      HitterProjection(
        id: playerId,
        name: '$firstName $lastName',
        team: team,
        position: position,
        overallPercentile: overallPercentile,
        qualifiedPercentile: qualifiedPercentile,
        runs: runs,
        homeRuns: homeRuns,
        rbis: rbis,
        stolenBases: stolenBases,
        obp: obp
      ),
      _ => throw const FormatException("Could not read player projections!"),
    };
  }
}