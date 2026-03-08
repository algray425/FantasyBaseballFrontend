import 'package:fantasy_baseball_app/widgets/ReliefPitcherList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fantasy_baseball_app/notifiers/ReliefPitcherRankingsListModel.dart';
import 'package:fantasy_baseball_app/widgets/HeaderBar.dart';
import 'package:fantasy_baseball_app/widgets/NavigationDrawer.dart';
import 'package:fantasy_baseball_app/widgets/SeasonSelector.dart';
import 'package:fantasy_baseball_app/widgets/DateRangeSelector.dart';
import 'package:fantasy_baseball_app/widgets/LeagueSelector.dart';

class ReliefPitcherRankingsPage extends StatelessWidget
{
  static const routeName = '/reliefPitcherRankings';

  const ReliefPitcherRankingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(title: "Relief Pitcher Rankings"),
      drawer: Drawer(
        child: NavigationList()
      ),
      body: ChangeNotifierProvider(
        create: (context) => ReliefPitcherRankingsListModel(),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text("Season: ")
                ),
                Consumer<ReliefPitcherRankingsListModel>(
                  builder: (context, pitcherListModel, child)
                  {
                    return SeasonSelector(callback: Provider.of<ReliefPitcherRankingsListModel>(context, listen: false).updateSeason, rankingType: "relief_pitchers",);
                  },
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text("League Filter: ")
                ),
                Consumer<ReliefPitcherRankingsListModel>(
                    builder: (context, pitcherListModel, child) {
                      return LeagueSelector(userId: "1", callback: Provider.of<ReliefPitcherRankingsListModel>(context, listen: false).updateTeamFilter);
                    }
                ),
                Consumer<ReliefPitcherRankingsListModel>(
                    builder: (context, pitcherListModel, child) {
                      return DateRangeSelector(callback: Provider.of<ReliefPitcherRankingsListModel>(context, listen: false).updateDateRanges);
                    }
                ),
              ]
            ),
            Expanded(child: ReliefPitcherList()),
            Consumer<ReliefPitcherRankingsListModel>(
              builder: (context, pitcherListModel, child) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        Provider.of<ReliefPitcherRankingsListModel>(context, listen: false).decrementPage();
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
                        Provider.of<ReliefPitcherRankingsListModel>(context, listen: false).incrementPage();
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
        )
      )
    );
  }
}