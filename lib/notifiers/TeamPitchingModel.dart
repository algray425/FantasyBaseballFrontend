import 'package:flutter/material.dart';

import 'dart:collection';

import 'package:fantasy_baseball_app/data/PlayerDataSource.dart';
import 'package:fantasy_baseball_app/model/TeamPitchingStats.dart';


class TeamPitchingModel extends ChangeNotifier
{
  PlayerDataSource playerDataSource = PlayerDataSource();

  bool _finishedLoading = false;
  int _season           = 2026;

  List<TeamPitchingStats> _teams = [];

  UnmodifiableListView<TeamPitchingStats> get teams => UnmodifiableListView(_teams);

  bool get finishedLoading  => _finishedLoading;
  int get season            => _season;

  TeamPitchingModel()
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
    playerDataSource.getTeamPitchingStats(_season).then((List<TeamPitchingStats> teams){
      _teams            = teams;
      _finishedLoading  = true;

      notifyListeners();
    });
  }
}