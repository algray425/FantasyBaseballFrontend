import 'dart:convert';

import 'package:fantasy_baseball_app/model/FantasyTeam.dart';
import 'package:http/http.dart' as http;

import '../model/FantasyTeamSummary.dart';
import '../model/FavoritePlayerSummary.dart';

class UserDataSource
{
  final String getFavoritePlayersEndPoint     = "http://localhost:9292/api/v2/users/getFavoritePlayers/";
  final String addFavoritePlayerEndPoint      = "http://localhost:9292/api/v2/users/addFavoritePlayer/";
  final String removeFavoritePlayerEndPoint   = "http://localhost:9292/api/v2/users/deleteFavoritePlayer/";
  final String getFantasyTeamsEndPoint        = "http://localhost:9292/api/v2/users/getFantasyTeams/";
  final String getFantasyTeamSummaryEndPoint  = "http://localhost:9292/api/v2/users/fantasyTeamSummary/";

  Future<Map<String, Set<FavoritePlayerSummary>>> getFavoritePlayersForUser(String userId) async
  {
    final url = "$getFavoritePlayersEndPoint$userId";

    final response = await http.get(Uri.parse(url));

    final players = json.decode(response.body) as List;

    Map<String, Set<FavoritePlayerSummary>> favoritePlayers = {};

    for (final player in players)
    {
      final favoritePlayer = FavoritePlayerSummary.fromJson(player);

      String convertedPlayerPosition = (favoritePlayer.position == "CF" || favoritePlayer.position == "LF" || favoritePlayer.position == "RF") ? "OF" : favoritePlayer.position;

      if (!favoritePlayers.containsKey(convertedPlayerPosition))
      {
        favoritePlayers[convertedPlayerPosition] = <FavoritePlayerSummary>{};
      }

      favoritePlayers[convertedPlayerPosition]?.add(favoritePlayer);
    }

    return favoritePlayers;
  }

  Future<void> addFavoritePlayer(String userId, String playerId) async
  {
    final url = Uri.parse(addFavoritePlayerEndPoint);

    final headers = {'Content-Type': 'application/json; charset=UTF-8'};

    final requestBody = jsonEncode({
      'userId': userId,
      'playerId': playerId
    });

    await http.post(url, headers: headers, body: requestBody);
  }

  Future<void> removeFavoritePlayer(String userId, String playerId) async
  {
    final url = "$removeFavoritePlayerEndPoint$userId/$playerId";

    await http.delete(Uri.parse(url));
  }

  Future<List<FantasyTeam>> getFantasyTeamsForUser(String userId) async
  {
    final url = "$getFantasyTeamsEndPoint$userId";

    final response = await http.get(Uri.parse(url));

    final teams = json.decode(response.body) as List;

    var fantasyTeams = List<FantasyTeam>.empty(growable: true);

    for (final team in teams)
    {
      fantasyTeams.add(FantasyTeam.fromJson(team));
    }

    return fantasyTeams;
  }

  Future<FantasyTeamSummary> getFantasyTeamSummary(String userId, String leagueType, String leagueId, String teamId) async
  {
    final url = "$getFantasyTeamSummaryEndPoint$userId/$leagueType/$leagueId/$teamId";

    final response = await http.get(Uri.parse(url));

    final summarySections = json.decode(response.body) as Map<String, dynamic>;

    final fantasyTeamSummary = FantasyTeamSummary.fromJson(summarySections);

    return fantasyTeamSummary;
  }
}