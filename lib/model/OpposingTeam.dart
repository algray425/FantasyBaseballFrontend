class OpposingTeam
{
  final String teamName;
  final double matchupGradeHitting;
  final double matchupGradeStartingPitching;
  final double matchupGradeReliefPitching;
  final double matchupGradeOverallPitching;

  const OpposingTeam({
    required this.teamName,
    required this.matchupGradeHitting,
    required this.matchupGradeStartingPitching,
    required this.matchupGradeReliefPitching,
    required this.matchupGradeOverallPitching,
  });

  factory OpposingTeam.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'teamName': String teamName,
      'matchupGradeHitting': double matchupGradeHitting,
      'matchupGradeStartingPitching': double matchupGradeStartingPitching,
      'matchupGradeReliefPitching': double matchupGradeReliefPitching,
      'matchupGradeOverallPitching': double matchupGradeOverallPitching,
      } =>
          OpposingTeam(
            teamName: teamName,
            matchupGradeHitting: matchupGradeHitting,
            matchupGradeStartingPitching: matchupGradeStartingPitching,
            matchupGradeReliefPitching: matchupGradeReliefPitching,
            matchupGradeOverallPitching: matchupGradeOverallPitching,
          ),
      _ => throw const FormatException("Could not read opposing team!"),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'teamName': teamName,
      'matchupGradeHitting': matchupGradeHitting,
      'matchupGradeStartingPitching': matchupGradeStartingPitching,
      'matchupGradeReliefPitching': matchupGradeReliefPitching,
      'matchupGradeOverallPitching': matchupGradeOverallPitching,
    };
  }
}