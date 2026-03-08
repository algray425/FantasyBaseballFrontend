import 'package:fantasy_baseball_app/widgets/LeagueSelector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fantasy_baseball_app/notifiers/HitterListModel.dart';
import 'package:fantasy_baseball_app/widgets/HeaderBar.dart';
import 'package:fantasy_baseball_app/widgets/HitterList.dart';
import 'package:fantasy_baseball_app/widgets/NavigationDrawer.dart';
import 'package:fantasy_baseball_app/widgets/PositionSelector.dart';
import 'package:fantasy_baseball_app/widgets/SeasonSelector.dart';

import '../widgets/DateRangeSelector.dart';

class HitterRankingsPage extends StatelessWidget
{
  static const routeName = '/hitterRankings';

  const HitterRankingsPage({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: HeaderBar(title: "Hitter Rankings"),
      drawer: Drawer(
        child: NavigationList()
      ),
      body: ChangeNotifierProvider(
        create: (context) => HitterListModel(),
        child: Column( children: [
          Row(children: [
            Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text("Season: ")
            ),
            Consumer<HitterListModel>(
              builder: (context, hitterListModel, child) {
                return Container(
                  child: SeasonSelector(callback: Provider.of<HitterListModel>(context, listen: false).updateSeason, rankingType: "hitters"));
                }
            ),
            Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text("Position: ")
            ),
            Consumer<HitterListModel>(
              builder: (context, hitterListModel, child) {
                return Container(
                    child: PositionSelector(callback: Provider.of<HitterListModel>(context, listen: false).updatePositions)
                );
              }
            ),
            Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text("League Filter: ")
            ),
            Consumer<HitterListModel>(
              builder: (context, hitterListModel, child) {
                return Container(
                    child: LeagueSelector(userId: "1", callback: Provider.of<HitterListModel>(context, listen: false).updateTeamFilter)
                );
              }
            ),
            Consumer<HitterListModel>(
              builder: (context, hitterListModel, child) {
                return DateRangeSelector(callback: Provider.of<HitterListModel>(context, listen: false).updateDateRanges);
              }
            )
          ]),
          Expanded(child: HitterList()),
          Consumer<HitterListModel>(
            builder: (context, hitterListModel, child) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: (){
                        Provider.of<HitterListModel>(context, listen: false).decrementPage();
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back_rounded),
                            Text("Prev")
                          ]
                        )
                      )
                  ),
                  InkWell(
                    onTap: (){
                      Provider.of<HitterListModel>(context, listen: false).incrementPage();
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      child: Row(
                          children: [
                            Text("Next"),
                            Icon(Icons.arrow_forward_rounded)
                          ]
                      )
                    )
                  )
                ]
              );
            }
          )
        ]
      )
    ));
  }
}