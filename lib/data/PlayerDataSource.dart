import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:fantasy_baseball_app/model/HitterProjection.dart';
import 'package:fantasy_baseball_app/model/ReliefPitcherSummary.dart';
import 'package:fantasy_baseball_app/model/StartingPitcherSummary.dart';
import 'package:fantasy_baseball_app/model/HitterModel.dart';
import 'package:fantasy_baseball_app/model/HitterPerGameStat.dart';
import 'package:fantasy_baseball_app/model/HitterSeasonSummary.dart';
import 'package:fantasy_baseball_app/model/HitterSummary.dart';
import 'package:fantasy_baseball_app/model/PitcherSeasonSummary.dart';
import 'package:fantasy_baseball_app/model/PitcherSummary.dart';
import 'package:fantasy_baseball_app/model/PitcherPerGameStat.dart';
import 'package:fantasy_baseball_app/model/TeamHittingStats.dart';
import 'package:fantasy_baseball_app/model/StartingPitcherProjection.dart';

import '../model/TeamPitchingStats.dart';

class PlayerDataSource
{
  final String hitterRankingsEndpoint               = "http://localhost:9292/api/v2/players/hitting/stats/";
  final String hitterProjectionsEndpoint            = "http://localhost:9292/api/v2/players/hitting/projections";
  final String startingPitchersProjectionsEndpoint  = "http://localhost:9292/api/v2/players/startingPitchers/projections";
  final String hitterSummaryEndpoint                = "http://localhost:9292/api/v2/players/hitting/summary/";
  final String hitterSeasonSummariesEndpoint        = "http://localhost:9292/api/v2/players/hitting/stats/seasonSummaries/";
  final String hitterPerGameStatsEndpoint           = "http://localhost:9292/api/v2/players/hitting/stats/perGame/";
  final String pitcherPerGameStatsEndpoint          = "http://localhost:9292/api/v2/players/pitching/stats/perGame/";
  final String startingPitcherRankingsEndpoint      = "http://localhost:9292/api/v2/players/startingPitchers/stats/";
  final String reliefPitcherRankingsEndpoint        = "http://localhost:9292/api/v2/players/reliefPitchers/stats/";
  final String pitcherSummaryEndpoint               = "http://localhost:9292/api/v2/players/pitching/summary/";
  final String pitcherSeasonSummariesEndpoint       = "http://localhost:9292/api/v2/players/pitching/stats/seasonSummaries/";
  final String getTeamHittingStatsEndpoint          = "http://localhost:9292/api/v2/teams/hitting/stats";
  final String getTeamPitchingStatsEndpoint         = "http://localhost:9292/api/v2/teams/pitching/stats";

  Future<List<HitterModel>> getHitterByRanks(final int season, final String sortBy, final String position, final String startDate, final String endDate, final String leagueTypeFilter, final String leagueIdFilter,
      final int limit, final int page) async
  {
    final url = "$hitterRankingsEndpoint$season?sortBy=$sortBy&position=$position&startDate=$startDate&endDate=$endDate&leagueTypeFilter=$leagueTypeFilter&leagueIdFilter=$leagueIdFilter&limit=$limit&page=$page";

    final response = await http.get(Uri.parse(url));

    final players = json.decode(response.body) as List;

    var rankedPlayers = List<HitterModel>.empty(growable: true);

    for (final player in players)
    {
      HitterModel rankedPlayer = HitterModel.fromJson(player);

       rankedPlayers.add(rankedPlayer);
    }

    return rankedPlayers;
  }

  Future<List<HitterProjection>> getHitterProjections(final String sortBy, final String position, final String leagueType, final String leagueId, final bool qualified, final int limit, final int page) async
  {
    final url = "$hitterProjectionsEndpoint?sortBy=$sortBy&qualified=$qualified&position=$position&leagueType=$leagueType&leagueId=$leagueId&limit=$limit&page=$page";

    final response = await http.get(Uri.parse(url));

    final projections = json.decode(response.body) as List;

    var playerProjections = List<HitterProjection>.empty(growable: true);

    for (final projection in projections)
    {
      HitterProjection hitterProjection = HitterProjection.fromJson(projection);

      playerProjections.add(hitterProjection);
    }

    return playerProjections;
  }

  Future<List<StartingPitcherProjection>> getStartingPitcherProjections(final String sortBy, final String leagueType, final String leagueId, final int limit, final int page) async
  {
    final url = "$startingPitchersProjectionsEndpoint?sortBy=$sortBy&leagueType=$leagueType&leagueId=$leagueId&limit=$limit&page=$page";

    final response = await http.get(Uri.parse(url));

    final projections = json.decode(response.body) as List;

    var playerProjections = List<StartingPitcherProjection>.empty(growable: true);

    for (final projection in projections)
    {
      StartingPitcherProjection hitterProjection = StartingPitcherProjection.fromJson(projection);

      playerProjections.add(hitterProjection);
    }

    return playerProjections;
  }

  Future<HitterSummary> getHitterSummary(final String playerId) async
  {
    final url = "$hitterSummaryEndpoint$playerId";

    final response = await http.get(Uri.parse(url));

    final summary = json.decode(response.body) as Map<String, dynamic>;

    HitterSummary hitterSummary = HitterSummary.fromJson(summary);

    return hitterSummary;
  }

  Future<PitcherSummary> getPitcherSummary(final String playerId) async
  {
    final url = "$pitcherSummaryEndpoint$playerId";

    final response = await http.get(Uri.parse(url));

    final summary = json.decode(response.body) as Map<String, dynamic>;

    PitcherSummary pitcherSummary = PitcherSummary.fromJson(summary);

    return pitcherSummary;
  }

  Future<List<HitterSeasonSummary>> getHittingSeasonSummaries(String playerId, int startSeason) async
  {
    final url = "$hitterSeasonSummariesEndpoint$playerId?startSeason=$startSeason";

    final response = await http.get(Uri.parse(url));

    final summaries = json.decode(response.body) as List;

    var seasonSummaries = List<HitterSeasonSummary>.empty(growable: true);

    for (final summary in summaries)
    {
      HitterSeasonSummary seasonSummary = HitterSeasonSummary.fromJson(summary);

      seasonSummaries.add(seasonSummary);
    }

    return seasonSummaries;
  }

  Future<List<PitcherSeasonSummary>> getPitcherSeasonSummaries(String playerId, int startSeason) async
  {
    final url = "$pitcherSeasonSummariesEndpoint$playerId?startSeason=$startSeason";

    final response = await http.get(Uri.parse(url));

    final summaries = json.decode(response.body) as List;

    var seasonSummaries = List<PitcherSeasonSummary>.empty(growable: true);

    for (final summary in summaries)
    {
      seasonSummaries.add(PitcherSeasonSummary.fromJson(summary));
    }

    return seasonSummaries;
  }

  Future<List<HitterPerGameStat>> getHittingPerGameStats(String playerId, int season, String stat) async
  {
    final url = "$hitterPerGameStatsEndpoint$playerId/$season/$stat";

    final response = await http.get(Uri.parse(url));

    final games = json.decode(response.body) as List;

    var perGameStats = List<HitterPerGameStat>.empty(growable: true);

    for (final game in games)
    {
      HitterPerGameStat perGameStat = HitterPerGameStat.fromJson(game);

      perGameStats.add(perGameStat);
    }

    return perGameStats;
  }

  Future<List<PitcherPerGameStat>> getPitchingPerGameStats(String playerId, int season, String stat) async
  {
    final url = "$pitcherPerGameStatsEndpoint$playerId/$season/$stat";

    final response = await http.get(Uri.parse(url));

    final games = json.decode(response.body) as List;

    var perGameStats = List<PitcherPerGameStat>.empty(growable: true);

    for (final game in games)
    {
      PitcherPerGameStat perGameStat = PitcherPerGameStat.fromJson(game);

      perGameStats.add(perGameStat);
    }

    return perGameStats;
  }

  Future<List<StartingPitcherSummary>> getStartingPitcherRankingsPerSeason(final int season, final String sortBy, final String startDate, final String endDate, final String leagueTypeFilter,
      final String leagueIdFilter, final int limit, final int page) async
  {
    final url = "$startingPitcherRankingsEndpoint$season?sortBy=$sortBy&startDate=$startDate&endDate=$endDate&leagueTypeFilter=$leagueTypeFilter&leagueIdFilter=$leagueIdFilter&limit=$limit&page=$page";

    final response = await http.get(Uri.parse(url));

    final pitchers = json.decode(response.body) as List;

    var rankedStartingPitchers = List<StartingPitcherSummary>.empty(growable: true);

    for (final pitcher in pitchers)
    {
      rankedStartingPitchers.add(StartingPitcherSummary.fromJson(pitcher));
    }

    return rankedStartingPitchers;
  }

  Future<List<ReliefPitcherSummary>> getReliefPitcherRankingsPerSeason(final int season, final String sortBy, final String startDate, final String endDate, final String leagueTypeFilter,
      final String leagueIdFilter, final int limit, final int page) async
  {
    final url = "$reliefPitcherRankingsEndpoint$season?sortBy=$sortBy&startDate=$startDate&endDate=$endDate&leagueTypeFilter=$leagueTypeFilter&leagueIdFilter=$leagueIdFilter&limit=$limit&page=$page";

    print(url);

    final response = await http.get(Uri.parse(url));

    final pitchers = json.decode(response.body) as List;

    var rankedReliefPitchers = List<ReliefPitcherSummary>.empty(growable: true);

    for (final pitcher in pitchers)
    {
      rankedReliefPitchers.add(ReliefPitcherSummary.fromJson(pitcher));
    }

    return rankedReliefPitchers;
  }

  Future<List<TeamHittingStats>> getTeamHittingStats(int season) async
  {
    final url = "$getTeamHittingStatsEndpoint/$season";

    final response = await http.get(Uri.parse(url));

    final teams = json.decode(response.body) as List;

    var teamHitting = List<TeamHittingStats>.empty(growable: true);

    for (final team in teams)
    {
      teamHitting.add(TeamHittingStats.fromJson(team));
    }

    return teamHitting;
  }

  Future<List<TeamPitchingStats>> getTeamPitchingStats(int season) async
  {
    final url = "$getTeamPitchingStatsEndpoint/$season";

    final response = await http.get(Uri.parse(url));

    final teams = json.decode(response.body) as List;

    var teamPitching = List<TeamPitchingStats>.empty(growable: true);

    for (final team in teams)
    {
      teamPitching.add(TeamPitchingStats.fromJson(team));
    }

    return teamPitching;
  }
}