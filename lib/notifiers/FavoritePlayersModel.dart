import 'dart:collection';

import 'package:fantasy_baseball_app/data/UserDataSource.dart';
import 'package:fantasy_baseball_app/model/FavoritePlayerSummary.dart';
import 'package:flutter/material.dart';

class FavoritePlayersModel extends ChangeNotifier
{
  UserDataSource userDataSource = UserDataSource();

  Map<String, Set<FavoritePlayerSummary>> _favoritePlayers  = {};

  UnmodifiableMapView<String, Set<FavoritePlayerSummary>> get favoritePlayers => UnmodifiableMapView(_favoritePlayers);

  FavoritePlayersModel()
  {
    userDataSource.getFavoritePlayersForUser("1").then((Map<String, Set<FavoritePlayerSummary>> players){
      _favoritePlayers = players;

      notifyListeners();
    });
  }

  void updatePlayerFavoritism(String playerId, String firstName, String lastName, String position, String team)
  {
    String convertedPosition = position;

    if (convertedPosition == "CF" || convertedPosition == "LF" || convertedPosition == "RF")
    {
      convertedPosition = "OF";
    }

    final player = FavoritePlayerSummary(playerId: playerId, firstName: firstName, lastName: lastName, position: convertedPosition, team: team);

    if (!_favoritePlayers.containsKey(convertedPosition) || !_favoritePlayers[convertedPosition]!.contains(player))
    {
      userDataSource.addFavoritePlayer("1", playerId).then((_){

        if (!_favoritePlayers.containsKey(convertedPosition))
        {
          _favoritePlayers[convertedPosition] = {};
        }

        _favoritePlayers[convertedPosition]?.add(player);

        notifyListeners();
      });
    }
    else
    {
      userDataSource.removeFavoritePlayer("1", playerId).then((_){
        _favoritePlayers[convertedPosition]?.remove(player);

        if (_favoritePlayers[convertedPosition]!.isEmpty)
        {
          _favoritePlayers.remove(convertedPosition);
        }

        notifyListeners();
      });
    }
  }

  bool containsPlayer(String playerId)
  {
    FavoritePlayerSummary playerCheck = FavoritePlayerSummary(playerId: playerId, firstName: "", lastName: "", position: "", team: "");

    for (final players in _favoritePlayers.values)
    {
      if (players.contains(playerCheck))
      {
        return true;
      }
    }

    return false;
  }
}