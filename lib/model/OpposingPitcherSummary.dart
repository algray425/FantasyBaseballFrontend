class OpposingPitcherSummary
{
  final String playerId;
  final String firstName;
  final String lastName;
  final double percentileOverall;

  const OpposingPitcherSummary({required this.playerId, required this.firstName, required this.lastName, required this.percentileOverall});

  factory OpposingPitcherSummary.fromJson(Map<String, dynamic> json)
  {
    return switch(json) {
    { 'playerId': String playerId, 'firstName': String firstName, 'lastName': String lastName, 'percentileOverall': double percentileOverall } =>
      OpposingPitcherSummary(
        playerId          : playerId,
        firstName         : firstName,
        lastName          : lastName,
        percentileOverall : percentileOverall
      ),
      _ => throw const FormatException("Could not extract opposing pitcher summary!"),
    };
  }
}