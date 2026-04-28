import 'package:fantasy_baseball_app/model/PageType.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fantasy_baseball_app/notifiers/HitterProjectionsModel.dart';
import 'package:fantasy_baseball_app/widgets/LeagueSelector.dart';
import 'package:fantasy_baseball_app/widgets/PositionSelector.dart';
import 'package:fantasy_baseball_app/widgets/ProjectionList.dart';
import 'package:fantasy_baseball_app/widgets/HeaderBar.dart';
import 'package:fantasy_baseball_app/widgets/NavigationDrawer.dart';

class HitterProjectionsPage extends StatelessWidget
{
  static const routeName = '/hitterProjections';

  const HitterProjectionsPage({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: HeaderBar(title: "Player Projections"),
      drawer: Drawer(
        child: NavigationList()
      ),
      body:
        Column(
          children: [
            Row (children: [
              Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text("Position: ")
              ),
              Consumer<HitterProjectionsModel>(
                builder: (context, hitterProjectionsModel, child) {
                  return Container(
                      child: PositionSelector(pageType: PageType.HITTER_PROJECTIONS, callback: Provider.of<HitterProjectionsModel>(context, listen: false).updatePositions)
                  );
                }
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text("League Filter: ")
              ),
              Consumer<HitterProjectionsModel>(
                  builder: (context, pitcherListModel, child) {
                    return LeagueSelector(userId: "1", pageType: PageType.HITTER_PROJECTIONS, callback: Provider.of<HitterProjectionsModel>(context, listen: false).updateTeamFilter);
                  }
              ),
            ]),
            Expanded(child: ProjectionList()),
            Consumer<HitterProjectionsModel>(
              builder: (context, hitterListModel, child) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        Provider.of<HitterProjectionsModel>(context, listen: false).decrementPage();
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
                        Provider.of<HitterProjectionsModel>(context, listen: false).incrementPage();
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