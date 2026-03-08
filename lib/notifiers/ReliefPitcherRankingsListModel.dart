import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:fantasy_baseball_app/data/PlayerDataSource.dart';
import 'package:fantasy_baseball_app/model/ReliefPitcherSummary.dart';
import 'package:fantasy_baseball_app/model/PitchingStat.dart';
import 'package:fantasy_baseball_app/model/FantasyTeam.dart';

class ReliefPitcherRankingsListModel extends ChangeNotifier
{
  PlayerDataSource playerDataSource = PlayerDataSource();

  bool                          _finishedLoading  = false;
  int                           _season           = 2025;
  List<ReliefPitcherSummary>    _pitchers         = [];
  PitchingStat                  _sortBy           = PitchingStat.PERCENTILE_OVERALL;
  String                        _startDate        = "";
  String                        _endDate          = "";
  String                        _leagueTypeFilter = "";
  String                        _leagueIdFilter   = "";
  int                           _limit            = 10;
  int                           _page             = 0;

  UnmodifiableListView<ReliefPitcherSummary>  get pitchers        => UnmodifiableListView(_pitchers);
  bool                                        get finishedLoading => _finishedLoading;
  int                                         get season          => _season;

  ReliefPitcherRankingsListModel()
  {
    updateReliefPitcherList();
  }

  void updateSeason(int season)
  {
    _finishedLoading = false;

    notifyListeners();

    _season = season;

    updateReliefPitcherList();
  }

  void updateTeamFilter(FantasyTeam team)
  {
    _finishedLoading = false;

    notifyListeners();

    if (team.teamId == "None")
    {
      _leagueTypeFilter = "";
      _leagueIdFilter   = "";
    }
    else
    {
      _leagueTypeFilter = team.leagueType;
      _leagueIdFilter   = team.leagueId;
    }

    updateReliefPitcherList();
  }

  void updateDateRanges(({String startDate, String endDate}) dates)
  {
    _finishedLoading = false;

    notifyListeners();

    _startDate  = dates.startDate;
    _endDate    = dates.endDate;

    updateReliefPitcherList();
  }

  void decrementPage()
  {
    if (_page == 0)
    {
      return;
    }

    _finishedLoading = false;

    notifyListeners();

    _page -= 1;

    updateReliefPitcherList();
  }

  void incrementPage()
  {
    _finishedLoading = false;

    notifyListeners();

    _page = _page + 1;

    updateReliefPitcherList();
  }

  void updateSort(PitchingStat stat)
  {
    _finishedLoading = false;

    notifyListeners();

    _sortBy = stat;

    updateReliefPitcherList();
  }

  void updateReliefPitcherList()
  {
    playerDataSource.getReliefPitcherRankingsPerSeason(_season, _sortBy.name, _startDate, _endDate, _leagueTypeFilter, _leagueIdFilter, _limit, _page).then((List<ReliefPitcherSummary> pitchers){
      _pitchers         = pitchers;
      _finishedLoading  = true;

      notifyListeners();
    });
  }
}