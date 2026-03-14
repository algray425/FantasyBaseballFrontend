import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fantasy_baseball_app/notifiers/HitterListModel.dart';
import 'package:fantasy_baseball_app/notifiers/StartingPitcherRankingListModel.dart';
import 'package:fantasy_baseball_app/notifiers/ReliefPitcherRankingsListModel.dart';
import 'package:fantasy_baseball_app/notifiers/TeamHittingModel.dart';
import 'package:fantasy_baseball_app/notifiers/TeamPitchingModel.dart';

class SeasonSelector extends StatefulWidget
{
  final                     List<int> seasons = [2025, 2024, 2023];
  final void Function(int)  callback;
  final String              rankingType;

  SeasonSelector({super.key, required this.callback, required this.rankingType});

  @override
  SeasonSelectorState createState() => SeasonSelectorState();
}

class SeasonSelectorState extends State<SeasonSelector>
{
  int selectedSeason = 2025;

  @override
  Widget build(BuildContext context)
  {
    int season = -1;

    if (widget.rankingType == "hitters")
    {
      season = context.read<HitterListModel>().season;
    }
    else if (widget.rankingType == "starting_pitchers")
    {
      season = context.read<StartingPitcherRankingListModel>().season;
    }
    else if (widget.rankingType == "relief_pitchers")
    {
      season = context.read<ReliefPitcherRankingsListModel>().season;
    }
    else if (widget.rankingType == "team_hitting")
    {
      season = context.read<TeamHittingModel>().season;
    }
    else if (widget.rankingType == "team_pitching")
    {
      season = context.read<TeamPitchingModel>().season;
    }
    else
    {
      season = 2025;
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