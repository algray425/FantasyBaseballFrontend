import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fantasy_baseball_app/data/UserDataSource.dart';
import 'package:fantasy_baseball_app/model/FantasyTeam.dart';
import 'package:fantasy_baseball_app/model/PageType.dart';
import 'package:fantasy_baseball_app/notifiers/HitterListModel.dart';
import 'package:fantasy_baseball_app/notifiers/HitterProjectionsModel.dart';
import 'package:fantasy_baseball_app/notifiers/ReliefPitcherRankingsListModel.dart';
import 'package:fantasy_baseball_app/notifiers/StartingPitcherProjectionsModel.dart';
import 'package:fantasy_baseball_app/notifiers/StartingPitcherRankingListModel.dart';

class LeagueSelector extends StatefulWidget
{
  final UserDataSource              userDataSource = UserDataSource();
  final String                      userId;
  final PageType                    pageType;
  final void Function(FantasyTeam)  callback;

  LeagueSelector({super.key, required this.userId, required this.pageType, required this.callback});

  @override
  LeagueSelectorState createState() => LeagueSelectorState();
}

class LeagueSelectorState extends State<LeagueSelector>
{
  bool                            finishedLoadingTeams = false;
  String                          selectedTeam         = "None";
  Map<String, FantasyTeam>        teamKeyToFantasyTeam = {};

  late List<FantasyTeam>          fantasyTeams;

  @override
  void initState()
  {
    super.initState();

    widget.userDataSource.getFantasyTeamsForUser("1").then((List<FantasyTeam> teams){
      setState(() {
        fantasyTeams = teams;

        FantasyTeam noneTeam = FantasyTeam(teamId: "None", teamName: "None", leagueId: "None", leagueName: "None", leagueType: "None");

        fantasyTeams.insert(0, noneTeam);

        teamKeyToFantasyTeam[noneTeam.leagueName] = noneTeam;

        for (final team in fantasyTeams)
        {
          teamKeyToFantasyTeam[team.leagueName] = team;
        }

        finishedLoadingTeams = true;
      });
    });
  }

  @override
  Widget build(BuildContext context)
  {
    if (finishedLoadingTeams)
    {
      String modelTeam = "None";

      if (widget.pageType == PageType.HITTER_RANKINGS)
      {
        modelTeam = context.read<HitterListModel>().leagueName;
      }
      else if (widget.pageType == PageType.STARTING_PITCHER_RANKINGS)
      {
        modelTeam = context.read<StartingPitcherRankingListModel>().leagueName;
      }
      else if (widget.pageType == PageType.RELIEF_PITCHER_RANKINGS)
      {
        modelTeam = context.read<ReliefPitcherRankingsListModel>().leagueName;
      }
      else if (widget.pageType == PageType.HITTER_PROJECTIONS)
      {
        modelTeam = context.read<HitterProjectionsModel>().leagueName;
      }
      else if (widget.pageType == PageType.STARTING_PITCHER_PROJECTIONS)
      {
        modelTeam = context.read<StartingPitcherProjectionsModel>().leagueName;
      }

      return DropdownButton(
          value: modelTeam,
          items: fantasyTeams.map((FantasyTeam team){
            return DropdownMenuItem(value: team.leagueName, child: Text(team.leagueName));
          }).toList(),
          onChanged: (String? newValue){
            setState(() {
              if (teamKeyToFantasyTeam.containsKey(newValue!))
              {
                selectedTeam = newValue;

                widget.callback(teamKeyToFantasyTeam[newValue]!);
              }
            });
          });
    }
    else
    {
      return Center(child: CircularProgressIndicator());
    }
  }
}