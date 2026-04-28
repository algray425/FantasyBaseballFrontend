import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fantasy_baseball_app/model/PageType.dart';
import 'package:fantasy_baseball_app/notifiers/HitterListModel.dart';
import 'package:fantasy_baseball_app/notifiers/StartingPitcherRankingListModel.dart';
import 'package:fantasy_baseball_app/notifiers/ReliefPitcherRankingsListModel.dart';
import 'package:fantasy_baseball_app/notifiers/TeamHittingModel.dart';
import 'package:fantasy_baseball_app/notifiers/TeamPitchingModel.dart';

class SeasonSelector extends StatefulWidget
{
  final                     List<int> seasons = [2026, 2025, 2024, 2023, 2022, 2021, 2020, 2019, 2018, 2017, 2016, 2015];
  final void Function(int)  callback;
  final PageType            pageType;

  SeasonSelector({super.key, required this.pageType, required this.callback});

  @override
  SeasonSelectorState createState() => SeasonSelectorState();
}

class SeasonSelectorState extends State<SeasonSelector>
{
  int selectedSeason = 2026;

  @override
  Widget build(BuildContext context)
  {
    int season = -1;

    if (widget.pageType == PageType.HITTER_RANKINGS)
    {
      season = context.read<HitterListModel>().season;
    }
    else if (widget.pageType == PageType.STARTING_PITCHER_RANKINGS)
    {
      season = context.read<StartingPitcherRankingListModel>().season;
    }
    else if (widget.pageType == PageType.RELIEF_PITCHER_RANKINGS)
    {
      season = context.read<ReliefPitcherRankingsListModel>().season;
    }
    else if (widget.pageType == PageType.TEAM_HITTING)
    {
      season = context.read<TeamHittingModel>().season;
    }
    else if (widget.pageType == PageType.TEAM_PITCHING)
    {
      season = context.read<TeamPitchingModel>().season;
    }
    else
    {
      season = 2026;
    }

    return DropdownButton(
        value: season,
        items: widget.seasons.map((int season) {
          return DropdownMenuItem(value: season, child: Text(season.toString()));
        }).toList(),
        onChanged: (int? newValue) {
          setState(() {
            selectedSeason = newValue!;

            widget.callback(selectedSeason);
          });
        });
  }
}