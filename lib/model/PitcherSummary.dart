import 'PitcherGame.dart';

class PitcherSummary
{
  final String id;
  final String name;
  final int age;
  final String batSide;
  final String throwSide;
  final String height;
  final double weight;
  final String team;
  final List<PitcherGame> upcomingSchedule;

  const PitcherSummary({required this.id, required this.name, required this.age, required this.batSide, required this.throwSide,
    required this.height, required this.weight, required this.team, required this.upcomingSchedule});

  factory PitcherSummary.fromJson(Map<String, dynamic> json)
  {
    return switch(json) {
      { 'playerId': String playerId, 'firstName': String firstName, 'lastName': String lastName, 'dob': int dob, 'batSide': String batSide, 'throwHand': String throwHand,
      'height': String height, 'weight': double weight, 'currentTeam': String currentTeam, 'upcomingSchedule': List<
          dynamic> games} =>
          PitcherSummary(
            id: playerId,
            name: '$firstName $lastName',
            age: dob,
            batSide: batSide,
            throwSide: throwHand,
            height: height,
            weight: weight,
            team: currentTeam,
            upcomingSchedule: games.map((game) => PitcherGame.fromJson(game)).toList()
          ),
      _ => throw const FormatException("Could not parse pitcher summary!")
    };
  }
}