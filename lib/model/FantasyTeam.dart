class FantasyTeam
{
  final String teamId;
  final String teamName;
  final String leagueId;
  final String leagueName;
  final String leagueType;

  const FantasyTeam({required this.teamId, required this.teamName, required this.leagueId, required this.leagueName, required this.leagueType});

  factory FantasyTeam.fromJson(Map<String, dynamic> json)
  {
    return switch(json){
      {'teamId': String teamId, 'teamName': String teamName, 'leagueId': String leagueId, 'leagueName': String leagueName, 'leagueType': String leagueType } =>
        FantasyTeam(
          teamId: teamId,
          teamName: teamName,
          leagueId: leagueId,
          leagueName: leagueName,
          leagueType: leagueType
        ),
        _ => throw const FormatException("Could not read fantasy teams data!")
    };
  }
}