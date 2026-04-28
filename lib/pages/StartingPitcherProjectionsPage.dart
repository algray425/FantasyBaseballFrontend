import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fantasy_baseball_app/model/PageType.dart';
import 'package:fantasy_baseball_app/notifiers/StartingPitcherProjectionsModel.dart';
import 'package:fantasy_baseball_app/widgets/HeaderBar.dart';
import 'package:fantasy_baseball_app/widgets/NavigationDrawer.dart';
import 'package:fantasy_baseball_app/widgets/LeagueSelector.dart';
import 'package:fantasy_baseball_app/widgets/StartingPitcherProjectionList.dart';
import 'package:fantasy_baseball_app/widgets/TeamSelector.dart';

class StartingPitcherProjectionsPage extends StatelessWidget
{
  static const routeName = '/startingPitcherProjections';

  const StartingPitcherProjectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderBar(title: "Player Projections"),
      drawer: Drawer(
        child: NavigationList()
      ),
      body:
      Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text("League Filter: ")
              ),
              Consumer<StartingPitcherProjectionsModel>(
                builder: (context, pitcherListModel, child) {
                  return LeagueSelector(userId: "1", pageType: PageType.STARTING_PITCHER_PROJECTIONS, callback: Provider.of<StartingPitcherProjectionsModel>(context, listen: false).updateTeamFilter);
                }
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text("Team Filter: ")
              ),
              Consumer<StartingPitcherProjectionsModel>(
                builder: (context, pitcherListModel, child) {
                  return TeamSelector(callback: Provider.of<StartingPitcherProjectionsModel>(context, listen: false).updatePlayerTeamFilter);
                }
              ),
            ],
          ),
          Expanded(child: StartingPitcherProjectionList()),
          Consumer<StartingPitcherProjectionsModel>(
            builder: (context, hitterListModel, child) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      Provider.of<StartingPitcherProjectionsModel>(context, listen: false).decrementPage();
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
                      Provider.of<StartingPitcherProjectionsModel>(context, listen: false).incrementPage();
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
    );
  }
}