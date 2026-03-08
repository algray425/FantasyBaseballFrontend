import 'package:fantasy_baseball_app/data/PlayerDataSource.dart';
import 'package:flutter/material.dart';

import '../model/HitterSummary.dart';

class HitterStatsModel extends ChangeNotifier
{
  PlayerDataSource playerDataSource = PlayerDataSource();

  bool    _finishedLoading  = false;
  String  _playerId         = "";

  late HitterSummary _hitterSummary;

  bool          get finishedLoading => _finishedLoading;
  HitterSummary get hitterSummary   => _hitterSummary;

  HitterStatsModel();

  void updatePlayerId(String playerId)
  {
    _finishedLoading  = false;
    _playerId         = playerId;

    notifyListeners();

    getPlayerSummary();
  }

  void getPlayerSummary()
  {
    playerDataSource.getHitterSummary(_playerId).then((HitterSummary summary){
      _hitterSummary = summary;

      _finishedLoading = true;

      notifyListeners();
    });
  }
}