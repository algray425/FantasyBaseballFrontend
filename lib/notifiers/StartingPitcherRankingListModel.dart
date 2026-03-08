import 'dart:collection';

import 'package:fantasy_baseball_app/data/PlayerDataSource.dart';
import 'package:fantasy_baseball_app/model/FantasyTeam.dart';
import 'package:fantasy_baseball_app/model/PitchingStat.dart';
import 'package:fantasy_baseball_app/model/StartingPitcherSummary.dart';
import 'package:flutter/material.dart';

class StartingPitcherRankingListModel extends ChangeNotifier
{
  PlayerDataSource playerDataSource = PlayerDataSource();

  bool                          _finishedLoading  = false;
  List<StartingPitcherSummary>  _pitchers         = [];
  int                           _season           = 2025;
  PitchingStat                  _sortBy           = PitchingStat.PERCENTILE_OVERALL;
  String                        _startDate        = "";
  String                        _endDate          = "";
  String                        _leagueTypeFilter = "";
  String                        _leagueIdFilter   = "";
  int                           _limit            = 10;
  int                           _page             = 0;

  UnmodifiableListView<StartingPitcherSummary>  get pitchers        => UnmodifiableListView(_pitchers);
  bool                                          get finishedLoading => _finishedLoading;
  int                                           get season          => _season;

  StartingPitcherRankingListModel()
  {
    updateStartingPitcherList();
  }

  void updateSeason(int season)
  {
    _finishedLoading = false;

    notifyListeners();

    _season = season;

    updateStartingPitcherList();
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

    updateStartingPitcherList();
  }

  void incrementPage()
  {
    _finishedLoading = false;

    notifyListeners();

    _page = _page + 1;

    updateStartingPitcherList();
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

    updateStartingPitcherList();
  }

  void updateSort(PitchingStat stat)
  {
    _finishedLoading = false;

    notifyListeners();

    _sortBy = stat;

    updateStartingPitcherList();
  }

  void updateDateRanges(({String startDate, String endDate}) dates)
  {
    _finishedLoading = false;

    notifyListeners();

    _startDate  = dates.startDate;
    _endDate    = dates.endDate;

    updateStartingPitcherList();
  }

  void updateStartingPitcherList()
  {
    playerDataSource.getStartingPitcherRankingsPerSeason(_season, _sortBy.name, _startDate, _endDate, _leagueTypeFilter, _leagueIdFilter, _limit, _page).then((List<StartingPitcherSummary> pitchers){
      _pitchers         = pitchers;
      _finishedLoading  = true;

      notifyListeners();
    });
  }
}