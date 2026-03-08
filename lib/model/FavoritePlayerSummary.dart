class FavoritePlayerSummary
{
  final String playerId;
  final String firstName;
  final String lastName;
  final String position;
  final String team;

  const FavoritePlayerSummary({
    required this.playerId,
    required this.firstName,
    required this.lastName,
    required this.position,
    required this.team,
  });

  @override
  bool operator ==(Object other) {
    return other is FavoritePlayerSummary && other.runtimeType == runtimeType && other.playerId == playerId;
  }

  @override
  int get hashCode => playerId.hashCode;

  factory FavoritePlayerSummary.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'playerId': String playerId,
      'firstName': String firstName,
      'lastName': String lastName,
      'position': String position,
      'team': String team,
      } =>
          FavoritePlayerSummary(
            playerId: playerId,
            firstName: firstName,
            lastName: lastName,
            position: position,
            team: team,
          ),
      _ => throw const FormatException("Could not read favorite player summary!"),
    };
  }
}