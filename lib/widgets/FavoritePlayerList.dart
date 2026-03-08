import 'dart:collection';

import 'package:fantasy_baseball_app/model/FavoritePlayerSummary.dart';
import 'package:fantasy_baseball_app/pages/PitcherPage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:fantasy_baseball_app/widgets/FavoriteButton.dart';
import 'package:fantasy_baseball_app/notifiers/FavoritePlayersModel.dart';
import 'package:fantasy_baseball_app/pages/HitterPage.dart';

class FavoritePlayerList extends StatelessWidget
{
  const FavoritePlayerList({super.key});

  @override
  Widget build(BuildContext context) {
    UnmodifiableMapView<String, Set<FavoritePlayerSummary>> favoritePlayers = context.read<FavoritePlayersModel>().favoritePlayers;

    return Container(
      margin: EdgeInsets.fromLTRB(150, 0, 150, 40),
      child: Column(
        children: [
          for (final position in favoritePlayers.keys)...[
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 40, 10, 20),
                    alignment: Alignment.center,
                    child: Text(
                      position,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ),
                    )
                  ))
              ],
            ),
            ListView(
              scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: Center(child:Text("Favorite", style: TextStyle(fontWeight: FontWeight.bold)))),
                        Expanded(child: Center(child:Text("Name", style: TextStyle(fontWeight: FontWeight.bold)))),
                        Expanded(child: Center(child:Text("Team", style: TextStyle(fontWeight: FontWeight.bold)))),
                      ],
                    )
                ),
                Divider(),
                for (final player in favoritePlayers[position]!)...[
                  ListTile(
                    onTap: ()
                    {
                      if (player.position == "P")
                      {
                        context.go(PitcherPage.simpleRouteName + player.playerId);
                      }
                      else
                      {
                        context.go(HitterPage.simpleRouteName + player.playerId);
                      }
                    },
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: FavoriteButton(id: player.playerId, name: "${player.firstName} ${player.lastName}", position: player.position, team: player.team, marginRight: 0.0, marginLeft: 0.0, marginBottom: 0.0, marginTop: 0.0)),
                        Expanded(child: Center(child:Text("${player.firstName} ${player.lastName}"))),
                        Expanded(child: Center(child:Text(player.team))),
                      ]
                    )
                  ),
                  Divider(),
                ]]
              )
            ],
          ]
      )
    );
  }
}