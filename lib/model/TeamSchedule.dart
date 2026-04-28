import 'ScheduleGame.dart';

class TeamSchedule
{
  final List<ScheduleGame> games;

  const TeamSchedule({required this.games});

  factory TeamSchedule.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'games': List<dynamic> games} => TeamSchedule(
        games: games
            .map((g) => ScheduleGame.fromJson(g as Map<String, dynamic>))
            .toList(),
      ),
      _ => throw const FormatException("Could not read team schedule!"),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'games': games.map((g) => g.toJson()).toList(),
    };
  }
}