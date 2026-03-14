import 'package:flutter/material.dart';

import 'dart:collection';

import 'package:fantasy_baseball_app/data/PlayerDataSource.dart';
import 'package:fantasy_baseball_app/model/TeamHittingStats.dart';

class TeamHittingModel extends ChangeNotifier
{
  PlayerDataSource playerDataSource = PlayerDataSource();

  bool _finishedLoading = false;
  int _season           = 2025;

  List<TeamHittingStats> _teams = [];

  UnmodifiableListView<TeamHittingStats> get teams => UnmodifiableListView(_teams);

  bool get finishedLoading  => _finishedLoading;
  int get season            => _season;

  TeamHittingModel()
  {
    updateTeamList();
  }

  void updateSeason(int season)
  {
    _finishedLoading = false;

    notifyListeners();

    _season = season;

    updateTeamList();
  }

  void updateTeamList()
  {
    playerDataSource.getTeamHittingStats(_season).then((List<TeamHittingStats> teams){
      _teams = teams;

      _finishedLoading = true;

      notifyListeners();
    });
  }
}