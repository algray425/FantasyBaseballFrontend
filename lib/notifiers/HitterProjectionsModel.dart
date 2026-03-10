import 'package:flutter/material.dart';

import 'dart:collection';

import 'package:fantasy_baseball_app/data/PlayerDataSource.dart';

import 'package:fantasy_baseball_app/model/FantasyTeam.dart';
import 'package:fantasy_baseball_app/model/HitterProjection.dart';
import 'package:fantasy_baseball_app/model/HittingStat.dart';

class HitterProjectionsModel extends ChangeNotifier
{
  PlayerDataSource playerDataSource = PlayerDataSource();

  bool        _finishedLoading  = false;
  bool        _qualified        = false;
  HittingStat _sortBy           = HittingStat.PERCENTILE_OVERALL;
  String      _position         = "";
  String      _leagueTypeFilter = "";
  String      _leagueIdFilter   = "";
  int         _limit            = 10;
  int         _page             = 0;

  List<HitterProjection> _projections = [];

  UnmodifiableListView<HitterProjection> get projections => UnmodifiableListView(_projections);

  bool get finishedLoading => _finishedLoading;

  HitterProjectionsModel()
  {
    updateProjectionList();
  }

  void updateSort(HittingStat stat)
  {
    _finishedLoading = false;

    notifyListeners();

    _sortBy = stat;
    _page   = 0;

    updateProjectionList();
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

    updateProjectionList();
  }

  void incrementPage()
  {
    _finishedLoading = false;

    notifyListeners();

    _page = _page + 1;

    updateProjectionList();
  }

  void updatePositions(String position)
  {
    _finishedLoading = false;

    notifyListeners();

    _page     = 0;
    _position = position == "All" ? "" : position;

    updateProjectionList();
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

    updateProjectionList();
  }

  void updateProjectionList()
  {
    playerDataSource.getHitterProjections(_sortBy.name, _position, _leagueTypeFilter, _leagueIdFilter, _qualified, _limit, _page).then((List<HitterProjection> projections)
    {
      _projections = projections;

      _finishedLoading = true;

      notifyListeners();
    });
  }
}