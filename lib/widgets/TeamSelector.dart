import 'package:flutter/material.dart';

class TeamSelector extends StatefulWidget
{
  final List<String> teams = [
    "None",
    "SEA",
    "BOS",
    "MIL",
    "TOR",
    "CHN",
    "CIN",
    "COL",
    "TEX",
    "ARI",
    "ATL",
    "HOU",
    "MIN",
    "OAK",
    "KCA",
    "BAL",
    "NYA",
    "WAS",
    "ANA",
    "CHA",
    "MIA",
    "TBA",
    "PHI",
    "DET",
    "NYN",
    "LAN",
    "PIT",
    "SFN",
    "SLN",
    "SDN",
    "CLE"];

  final void Function(String) callback;

  TeamSelector({super.key, required this.callback});

  @override
  SeasonSelectorState createState() => SeasonSelectorState();
}

class SeasonSelectorState extends State<TeamSelector>
{
  String selectedTeam = "None";

  @override
  Widget build(BuildContext context)
  {
    return DropdownButton(
        value: selectedTeam,
        items: widget.teams.map((String team) {
          return DropdownMenuItem(value: team, child: Text(team));
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedTeam = newValue!;

            widget.callback(selectedTeam);
          });
        });
  }
}