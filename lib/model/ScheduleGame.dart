import 'OpposingPitcher.dart';
import 'OpposingTeam.dart';

class ScheduleGame
{
  final OpposingTeam opposingTeam;
  final OpposingPitcher? opposingPitcher;

  const ScheduleGame({
    required this.opposingTeam,
    required this.opposingPitcher,
  });

  factory ScheduleGame.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'opposingTeam': Map<String, dynamic> opposingTeam,
      'opposingPitcher': final opposingPitcherJson,
      } =>
          ScheduleGame(
            opposingTeam: OpposingTeam.fromJson(opposingTeam),
            opposingPitcher: opposingPitcherJson == null
                ? null
                : OpposingPitcher.fromJson(opposingPitcherJson as Map<String, dynamic>),
          ),
      _ => throw const FormatException("Could not read schedule game!"),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'opposingTeam': opposingTeam.toJson(),
      'opposingPitcher': opposingPitcher?.toJson(),
    };
  }
}