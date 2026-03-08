class HitterModel
{
  final String  id;
  final String  name;
  final String  team;
  final String  position;
  final double  overallPercentile;
  final double  overallPercentileRuns;
  final double  overallPercentileHomeRuns;
  final double  overallPercentileRbis;
  final double  overallPercentileStolenBases;
  final double  overallPercentileObp;
  final int     runs;
  final int     homeRuns;
  final int     rbis;
  final int     stolenBases;
  final double  obp;

  const HitterModel({required this.id, required this.name, required this.team, required this.position, required this.overallPercentile, required this.runs, required this.homeRuns,
  required this.rbis, required this.stolenBases, required this.obp, this.overallPercentileRuns = 0.0, this.overallPercentileHomeRuns = 0.0, this.overallPercentileRbis = 0.0,
  this.overallPercentileStolenBases = 0.0, this.overallPercentileObp = 0.0});

  factory HitterModel.fromJson(Map<String, dynamic> json)
  {
    return switch(json) {
    {  'playerId': String playerId, 'firstName': String firstName, 'lastName': String lastName, 'team': String team, 'position': String position, 'grade': double grade, 'runs': int runs, 'homeRuns': int homeRuns, 'rbis': int rbis, 'stolenBases': int stolenBases, 'onBasePercentage': double obp } =>
        HitterModel(
        id: playerId,
        name: '$firstName $lastName',
        team: team,
        position: position,
        overallPercentile: grade,
        runs: runs,
        homeRuns: homeRuns,
        rbis: rbis,
        stolenBases: stolenBases,
        obp: obp
      ),
      _ => throw const FormatException("Could not read ranked player data!"),
    };
  }
}