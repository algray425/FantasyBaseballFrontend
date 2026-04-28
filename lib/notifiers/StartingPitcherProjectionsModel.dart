import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:fantasy_baseball_app/data/PlayerDataSource.dart';
import 'package:fantasy_baseball_app/model/PitchingStat.dart';
import 'package:fantasy_baseball_app/model/StartingPitcherProjection.dart';
import 'package:fantasy_baseball_app/model/FantasyTeam.dart';

class StartingPitcherProjectionsModel extends ChangeNotifier
{
  PlayerDataSource playerDataSource = PlayerDataSource();

  bool          _finishedLoading  = false;
  PitchingStat  _sortBy           = PitchingStat.PERCENTILE_OVERALL;
  String        _team             = "";
  String        _leagueTypeFilter = "";
  String        _leagueIdFilter   = "";
  String        _leagueName       = "None";
  int           _limit            = 10;
  int           _page             = 0;

  List<StartingPitcherProjection> _projections = [];

  UnmodifiableListView<StartingPitcherProjection> get projections => UnmodifiableListView(_projections);

  bool    get finishedLoading => _finishedLoading;
  String  get leagueName      => _leagueName;

  StartingPitcherProjectionsModel()
  {
    updateProjectionList();
  }

  void updateSort(PitchingStat stat)
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

  void updatePlayerTeamFilter(String team)
  {
    _finishedLoading = false;

    notifyListeners();

    _team = team == "None" ? "" : team;

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

    _leagueName = team.leagueName;

    updateProjectionList();
  }

  void updateProjectionList()
  {
    playerDataSource.getStartingPitcherProjections(_sortBy.name, _team, _leagueTypeFilter, _leagueIdFilter, _limit, _page).then((List<StartingPitcherProjection> projections){
      _projections      = projections;
      _finishedLoading  = true;

      notifyListeners();
    });
  }
}