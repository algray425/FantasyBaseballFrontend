import 'package:fantasy_baseball_app/notifiers/StartingPitcherRankingListModel.dart';
import 'package:fantasy_baseball_app/widgets/DateRangeSelector.dart';
import 'package:fantasy_baseball_app/widgets/SeasonSelector.dart';
import 'package:flutter/material.dart';

import 'package:fantasy_baseball_app/widgets/NavigationDrawer.dart';
import 'package:fantasy_baseball_app/widgets/HeaderBar.dart';
import 'package:fantasy_baseball_app/widgets/StartingPitcherList.dart';
import 'package:provider/provider.dart';

import '../widgets/LeagueSelector.dart';

class StartingPitcherRankingsPage extends StatelessWidget
{
  static const routeName = '/startingPitcherRankings';

  const StartingPitcherRankingsPage({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: HeaderBar(title: "Starting Pitcher Rankings"),
      drawer: Drawer(
        child: NavigationList()
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text("Season: ")
              ),
              Consumer<StartingPitcherRankingListModel>(
                builder: (context, pitcherListModel, child)
                {
                  return SeasonSelector(callback: Provider.of<StartingPitcherRankingListModel>(context, listen: false).updateSeason, rankingType: "starting_pitchers",);
                },
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text("League Filter: ")
              ),
              Consumer<StartingPitcherRankingListModel>(
                  builder: (context, pitcherListModel, child) {
                    return LeagueSelector(userId: "1", callback: Provider.of<StartingPitcherRankingListModel>(context, listen: false).updateTeamFilter);
                  }
              ),
              Consumer<StartingPitcherRankingListModel>(
                builder: (context, pitcherListModel, child) {
                  return DateRangeSelector(callback: Provider.of<StartingPitcherRankingListModel>(context, listen: false).updateDateRanges);
                }
              )
            ],
          ),
          Expanded(child: StartingPitcherList()),
          Consumer<StartingPitcherRankingListModel>(
            builder: (context, pitcherListModel, child) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      Provider.of<StartingPitcherRankingListModel>(context, listen: false).decrementPage();
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
                      Provider.of<StartingPitcherRankingListModel>(context, listen: false).incrementPage();
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
        ],
      ),
    );
  }
}