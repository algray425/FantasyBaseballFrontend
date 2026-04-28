import 'dart:collection';
import 'package:flutter/material.dart';

import 'package:fantasy_baseball_app/data/PlayerDataSource.dart';
import 'package:fantasy_baseball_app/model/HitterModel.dart';
import 'package:fantasy_baseball_app/model/HittingStat.dart';
import 'package:fantasy_baseball_app/model/FantasyTeam.dart';

class HitterListModel extends ChangeNotifier
{
  PlayerDataSource playerDataSource = PlayerDataSource();

  bool          _finishedLoading  = false;
  int           _season           = 2026;
  HittingStat   _sortBy           = HittingStat.PERCENTILE_OVERALL;
  String        _position         = "";
  String        _leagueTypeFilter = "";
  String        _leagueIdFilter   = "";
  String        _leagueName       = "None";
  String        _startDate        = "";
  String        _endDate          = "";
  int           _limit            = 10;
  int           _page             = 0;

  List<HitterModel> _players = [];

  UnmodifiableListView<HitterModel> get players => UnmodifiableListView(_players);

  String  get leagueName        => _leagueName;
  bool    get finishedLoading   => _finishedLoading;
  int     get season            => _season;
  String  get startDate         => _startDate;
  String  get endDate           => _endDate;

  HitterListModel()
  {
    updatePlayerList();
  }

  String getPosition()
  {
    return _position.isEmpty ? "All" : _position;
  }

  void updateSeason(int season)
  {
    _finishedLoading = false;

    notifyListeners();

    _season = season;

    updatePlayerList();
  }

  void updateSort(HittingStat stat)
  {
    _finishedLoading = false;

    notifyListeners();

    _sortBy = stat;

    updatePlayerList();
  }

  void updatePositions(String position)
  {
    _finishedLoading = false;

    notifyListeners();

    _page     = 0;
    _position = position == "All" ? "" : position;

    updatePlayerList();
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

    updatePlayerList();
  }

  void incrementPage()
  {
    _finishedLoading = false;

    notifyListeners();

    _page = _page + 1;

    updatePlayerList();
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

    _leagueName = team.leagueName;

    updatePlayerList();
  }

  void updateDateRanges(({String startDate, String endDate}) dates)
  {
    _finishedLoading = false;

    notifyListeners();

    _startDate  = dates.startDate;
    _endDate    = dates.endDate;

    updatePlayerList();
  }

  void updatePlayerList()
  {
    playerDataSource.getHitterByRanks(_season, _sortBy.name, _position, _startDate, _endDate, _leagueTypeFilter, _leagueIdFilter, _limit, _page).then((List<HitterModel> players)
    {
      _players = players;

      _finishedLoading = true;

      notifyListeners();
    });
  }
}