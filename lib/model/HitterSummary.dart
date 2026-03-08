import 'HitterGame.dart';

class HitterSummary
{
  final String id;
  final String name;
  final int age;
  final String batSide;
  final String throwSide;
  final String height;
  final double weight;
  final String team;
  final String position;
  final int runs;
  final int homeRuns;
  final int rbis;
  final int stolenBases;
  final double obp;
  final double overallPercentileRuns;
  final double overallPercentileHomeRuns;
  final double overallPercentileRbis;
  final double overallPercentileStolenBases;
  final double overallPercentileObp;
  final double overallPercentileGrade;
  final double qualifiedPercentileRuns;
  final double qualifiedPercentileHomeRuns;
  final double qualifiedPercentileRbis;
  final double qualifiedPercentileStolenBases;
  final double qualifiedPercentileObp;
  final double qualifiedPercentileGrade;
  final List<HitterGame> upcomingSchedule;

  const HitterSummary({required this.id, required this.name, required this.age, required this.batSide, required this.throwSide,
    required this.height, required this.weight, required this.team, required this.position, required this.runs, required this.homeRuns,
    required this.rbis, required this.stolenBases, required this.obp, required this.overallPercentileRuns, required this.overallPercentileHomeRuns,
    required this.overallPercentileRbis, required this.overallPercentileStolenBases, required this.overallPercentileObp, required this.overallPercentileGrade,
    required this.qualifiedPercentileRuns, required this.qualifiedPercentileHomeRuns, required this.qualifiedPercentileRbis,
    required this.qualifiedPercentileStolenBases, required this.qualifiedPercentileObp, required this.qualifiedPercentileGrade, required this.upcomingSchedule});

  factory HitterSummary.fromJson(Map<String, dynamic> json)
  {
    return switch(json) {
      {'playerId': String playerId, 'firstName': String firstName, 'lastName': String lastName, 'dob': int dob, 'batSide': String batSide, 'throwHand': String throwHand,
      'height': String height, 'weight': double weight, 'currentTeam': String currentTeam, 'currentPosition': String position, 'predictedRuns': int runs, 'predictedHomeRuns': int homeRuns,
      'predictedRbis': int rbis, 'predictedStolenBases': int stolenBases, 'predictedObp': double obp, 'overallPercentilePredictedRuns': double overallPercentileRuns,
      'overallPercentilePredictedHomeRuns': double overallPercentileHomeRuns, 'overallPercentilePredictedRbis': double overallPercentileRbis,
      'overallPercentilePredictedStolenBases': double overallPercentileStolenBases, 'overallPercentilePredictedObp': double overallPercentileObp,
      'overallPercentilePredictedGrade': double overallPercentileGrade, 'qualifiedPercentilePredictedRuns': double qualifiedPercentileRuns,
      'qualifiedPercentilePredictedHomeRuns': double qualifiedPercentileHomeRuns, 'qualifiedPercentilePredictedRbis': double qualifiedPercentileRbis,
      'qualifiedPercentilePredictedStolenBases': double qualifiedPercentileStolenBases, 'qualifiedPercentilePredictedObp': double qualifiedPercentileObp,
      'qualifiedPercentilePredictedGrade': double qualifiedPercentileGrade, 'upcomingSchedule': List<dynamic> games} =>
        HitterSummary(
          id: playerId,
          name: '$firstName $lastName',
          age: dob,
          batSide: batSide,
          throwSide: throwHand,
          height: height,
          weight: weight,
          team: currentTeam,
          position: position,
          runs: runs,
          homeRuns: homeRuns,
          rbis: rbis,
          stolenBases: stolenBases,
          obp: obp,
          overallPercentileRuns: overallPercentileRuns,
          overallPercentileHomeRuns: overallPercentileHomeRuns,
          overallPercentileRbis: overallPercentileRbis,
          overallPercentileStolenBases: overallPercentileStolenBases,
          overallPercentileObp: overallPercentileObp,
          overallPercentileGrade: overallPercentileGrade,
          qualifiedPercentileRuns: qualifiedPercentileRuns,
          qualifiedPercentileHomeRuns: qualifiedPercentileHomeRuns,
          qualifiedPercentileRbis: qualifiedPercentileRbis,
          qualifiedPercentileStolenBases: qualifiedPercentileStolenBases,
          qualifiedPercentileObp: qualifiedPercentileObp,
          qualifiedPercentileGrade: qualifiedPercentileGrade,
          upcomingSchedule: games.map((game) => HitterGame.fromJson(game)).toList()
      ),
      _ => throw const FormatException("Could not read hitter summary!"),
    };
  }
}