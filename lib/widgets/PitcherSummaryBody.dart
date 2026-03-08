import 'package:fantasy_baseball_app/model/PitcherGame.dart';
import 'package:fantasy_baseball_app/model/PitcherSeasonSummary.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:fantasy_baseball_app/data/PlayerDataSource.dart';
import 'package:fantasy_baseball_app/model/PitcherSummary.dart';
import '../model/PitcherPerGameStat.dart';
import 'FavoriteButton.dart';

class PitcherSummaryBody extends StatefulWidget
{
  final PlayerDataSource playerDataSource = PlayerDataSource();

  final String id;

  final List<int>     seasons = [2025, 2024, 2023];
  final List<String>  stats = ["QUALITY_STARTS", "SAVES", "HOLDS", "ERA", "WHIP", "KS_PER_NINE"];

  final Map<String, Color> statToColor = {
    "QUALITY_STARTS": Colors.redAccent,
    "SAVES"         : Colors.blueAccent,
    "HOLDS"         : Colors.greenAccent,
    "ERA"           : Colors.pinkAccent,
    "WHIP"          : Colors.orange,
    "KS_PER_NINE"   : Colors.lime,
  };

  final Map<Color, String> colorToStat = {
    Colors.redAccent  :"QUALITY_STARTS",
    Colors.blueAccent :"SAVES",
    Colors.greenAccent:"HOLDS",
    Colors.pinkAccent :"ERA",
    Colors.orange     :"WHIP",
    Colors.lime       :"KS_PER_NINE",
  };

  PitcherSummaryBody({super.key, required this.id});

  @override
  PitcherSummaryBodyState createState() => PitcherSummaryBodyState();
}

class PitcherSummaryBodyState extends State<PitcherSummaryBody>
{
  bool                      finishedLoadingPitcherSummary           = false;
  bool                      finishedLoadingPitcherSeasonSummaries   = false;
  Map<String, List<FlSpot>> chartStat                               = {};
  int                       selectedSeason                          = 2025;
  String                    selectedStat                            = "QUALITY_STARTS";

  late PitcherSummary             pitcherSummary;
  late List<PitcherSeasonSummary> seasonSummaries;

  @override
  void initState()
  {
    super.initState();

    widget.playerDataSource.getPitcherSummary(widget.id).then((PitcherSummary summary){
      setState(() {
        pitcherSummary = summary;

        finishedLoadingPitcherSummary = true;
      });
    });

    widget.playerDataSource.getPitcherSeasonSummaries(widget.id, 2023).then((List<PitcherSeasonSummary> summaries){
      seasonSummaries = summaries;

      finishedLoadingPitcherSeasonSummaries = true;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    if (finishedLoadingPitcherSummary) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FavoriteButton(id: widget.id, name: pitcherSummary.name, position: "P", team: pitcherSummary.team, marginLeft: 0, marginRight: 20, marginTop: 10, marginBottom: 0),
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                alignment: Alignment.center,
                child: Text(
                  pitcherSummary.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0
                  ),
                )
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                alignment: Alignment.center,
                child: Text(
                  "Age: ${pitcherSummary.age}    Height: ${pitcherSummary.height}    Weight: ${pitcherSummary.weight.toString()}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                alignment: Alignment.center,
                child: Text(
                  "Team: ${pitcherSummary.team}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                alignment: Alignment.center,
                child: Text(
                  "Bat Side: ${pitcherSummary.batSide}    Throw Side: ${pitcherSummary.throwSide}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
                  alignment: Alignment.center,
                  child: Text(
                    "Previous Seasons Standard Pitching",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0
                    ),
                  )
                )
              )
            ],
          ),
          ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(40, 40, 40, 0),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Season", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Teams", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("ipOuts", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("BF", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Hits", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("HR", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("R", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("ER", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("W", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("IW", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("K", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("HBP", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("WP", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("BK", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("PB", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("SB", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("CS", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("W", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("L", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("SV", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("HD", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("QS", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("GS", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("ERA", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("WHIP", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("K/9", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("W/9", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("HR/9", style: TextStyle(fontSize: 12)))),
                          ]
                        )
                      )
                    )
                  ],
                )
              ),
              Divider(),
              for (final summary in seasonSummaries)...[
                ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.season.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.teams, style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.ipOuts.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.battersFaced.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.hits.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.homeRuns.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.runs.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.earnedRuns.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.walks.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.intentionalWalks.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.strikeOuts.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.hitByPitch.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.wildPitches.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.balks.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.passedBalls.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.stolenBases.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.caughtStealing.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.wins.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.losses.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.saves.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.holds.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.qualityStarts.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.gamesStarted.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.era.toStringAsFixed(2), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.whip.toStringAsFixed(2), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.ksPerNine.toStringAsFixed(2), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.walksPerNine.toStringAsFixed(2), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(summary.homeRunsPerNine.toStringAsFixed(2), style: TextStyle(fontSize: 12)))),
                            ]
                          )
                        )
                      )
                    ],
                  )
                ),
                Divider()
                //TODO: Add show more plus button
              ]
            ]
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                      margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
                      alignment: Alignment.center,
                      child: Text(
                        "Previous Seasons Advanced Pitching",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0
                        ),
                      )
                  )
              )
            ],
          ),
          ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                    title: Row(
                      children: [
                        Expanded(
                            child: Container(
                                margin: EdgeInsets.fromLTRB(40, 40, 40, 0),
                                alignment: Alignment.center,
                                child: Row(
                                    children: [
                                      Expanded(child: Container(alignment: Alignment.center, child: Text("Season", style: TextStyle(fontSize: 12)))),
                                      Expanded(child: Container(alignment: Alignment.center, child: Text("Teams", style: TextStyle(fontSize: 12)))),
                                      Expanded(child: Container(alignment: Alignment.center, child: Text("Avg FB Velo", style: TextStyle(fontSize: 12)))),
                                      Expanded(child: Container(alignment: Alignment.center, child: Text("Avg Exit Velo", style: TextStyle(fontSize: 12)))),
                                      Expanded(child: Container(alignment: Alignment.center, child: Text("Zone %", style: TextStyle(fontSize: 12)))),
                                      Expanded(child: Container(alignment: Alignment.center, child: Text("Chase %", style: TextStyle(fontSize: 12)))),
                                      Expanded(child: Container(alignment: Alignment.center, child: Text("SS %", style: TextStyle(fontSize: 12)))),
                                      Expanded(child: Container(alignment: Alignment.center, child: Text("HH %", style: TextStyle(fontSize: 12)))),
                                      Expanded(child: Container(alignment: Alignment.center, child: Text("Barrel %", style: TextStyle(fontSize: 12)))),
                                      Expanded(child: Container(alignment: Alignment.center, child: Text("GB% ", style: TextStyle(fontSize: 12)))),
                                      Expanded(child: Container(alignment: Alignment.center, child: Text("FB %", style: TextStyle(fontSize: 12)))),
                                      Expanded(child: Container(alignment: Alignment.center, child: Text("LD %", style: TextStyle(fontSize: 12)))),
                                      Expanded(child: Container(alignment: Alignment.center, child: Text("PU %", style: TextStyle(fontSize: 12)))),
                                      Expanded(child: Container(alignment: Alignment.center, child: Text("K %", style: TextStyle(fontSize: 12)))),
                                      Expanded(child: Container(alignment: Alignment.center, child: Text("W %", style: TextStyle(fontSize: 12)))),
                                      Expanded(child: Container(alignment: Alignment.center, child: Text("K% - W%", style: TextStyle(fontSize: 12)))),
                                      Expanded(child: Container(alignment: Alignment.center, child: Text("HR/FB%", style: TextStyle(fontSize: 12)))),
                                    ]
                                )
                            )
                        )
                      ],
                    )
                ),
                Divider(),
                for (final summary in seasonSummaries)...[
                  ListTile(
                      title: Row(
                        children: [
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
                                  alignment: Alignment.center,
                                  child: Row(
                                      children: [
                                        Expanded(child: Container(alignment: Alignment.center, child: Text(summary.season.toString(), style: TextStyle(fontSize: 12)))),
                                        Expanded(child: Container(alignment: Alignment.center, child: Text(summary.teams, style: TextStyle(fontSize: 12)))),
                                        Expanded(child: Container(alignment: Alignment.center, child: Text(summary.averageFastballVelocity.toStringAsFixed(1), style: TextStyle(fontSize: 12)))),
                                        Expanded(child: Container(alignment: Alignment.center, child: Text(summary.averageExitVelocity.toStringAsFixed(1), style: TextStyle(fontSize: 12)))),
                                        Expanded(child: Container(alignment: Alignment.center, child: Text(summary.zonePercentage.toStringAsFixed(1), style: TextStyle(fontSize: 12)))),
                                        Expanded(child: Container(alignment: Alignment.center, child: Text(summary.chasePercentage.toStringAsFixed(1), style: TextStyle(fontSize: 12)))),
                                        Expanded(child: Container(alignment: Alignment.center, child: Text(summary.swingingStrikePercentage.toStringAsFixed(1), style: TextStyle(fontSize: 12)))),
                                        Expanded(child: Container(alignment: Alignment.center, child: Text((summary.hardHitPercentage * 100.0).toStringAsFixed(1), style: TextStyle(fontSize: 12)))),
                                        Expanded(child: Container(alignment: Alignment.center, child: Text((summary.barrelPercentage * 100.0).toStringAsFixed(1), style: TextStyle(fontSize: 12)))),
                                        Expanded(child: Container(alignment: Alignment.center, child: Text((summary.groundBallPercentage * 100.0).toStringAsFixed(1), style: TextStyle(fontSize: 12)))),
                                        Expanded(child: Container(alignment: Alignment.center, child: Text((summary.flyBallPercentage * 100.0).toStringAsFixed(1), style: TextStyle(fontSize: 12)))),
                                        Expanded(child: Container(alignment: Alignment.center, child: Text((summary.lineDrivePercentage * 100.0).toStringAsFixed(1), style: TextStyle(fontSize: 12)))),
                                        Expanded(child: Container(alignment: Alignment.center, child: Text((summary.popUpPercentage * 100.0).toStringAsFixed(1), style: TextStyle(fontSize: 12)))),
                                        Expanded(child: Container(alignment: Alignment.center, child: Text((summary.strikeOutPercentage * 100.0).toStringAsFixed(1), style: TextStyle(fontSize: 12)))),
                                        Expanded(child: Container(alignment: Alignment.center, child: Text((summary.walkPercentage * 100.0).toStringAsFixed(1), style: TextStyle(fontSize: 12)))),
                                        Expanded(child: Container(alignment: Alignment.center, child: Text((summary.strikeOutWalkDifference * 100.0).toStringAsFixed(1), style: TextStyle(fontSize: 12)))),
                                        Expanded(child: Container(alignment: Alignment.center, child: Text((summary.homeRunPerFlyBallPercentage * 100.0).toStringAsFixed(1), style: TextStyle(fontSize: 12)))),
                                      ]
                                  )
                              )
                          )
                        ],
                      )
                  ),
                  Divider()
                  //TODO: Add show more plus button
                ]
              ]
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
                  alignment: Alignment.center,
                  child: Text(
                    "Upcoming Schedule",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0
                    ),
                  )
                )
              )
            ],
          ),
          ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(40, 40, 40, 0),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Expanded(child: Container(alignment: Alignment.center, child: Text("Team", style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text("Venue", style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text("Date", style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text("Matchup Grade", style: TextStyle(fontSize: 12)))),
                            ]
                          )
                        )
                      )
                    ],
                  )
                ),
                Divider(),
                for (final game in pitcherSummary.upcomingSchedule)...[
                  ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Expanded(child: Container(alignment: Alignment.center, child: Text(game.opposingTeam, style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(game.venue, style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(game.date, style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(getOpposingTeamGradeFromGame(game), style: TextStyle(fontSize: 12)))),
                              ]
                            )
                          )
                        )
                      ],
                    )
                  ),
                  Divider(),
                ]
            ]
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
                  alignment: Alignment.center,
                  child: Text(
                    "Fantasy Stats Viewer",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0
                    ),
                  )
                )
              )
            ],
          ),
          Row(
            children: [
              Container(margin: EdgeInsets.fromLTRB(50, 40, 0, 0), child: Text("Season: ")),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 40, 0, 0),
                  child: DropdownButton(
                      value: selectedSeason,
                      items: widget.seasons.map((int season){
                        return DropdownMenuItem(value: season, child: Text(season.toString()));
                      }).toList(),
                      onChanged: (int? newValue){
                        setState(() {
                          selectedSeason = newValue!;
                        });
                      }
                  )
              ),
              Container(margin: EdgeInsets.fromLTRB(20, 40, 0, 0), child: Text("Stat: ")),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 40, 0, 0),
                  child: DropdownButton(
                      value: selectedStat,
                      items: widget.stats.map((String stat){
                        return DropdownMenuItem(value: stat, child: Text(stat));
                      }).toList(),
                      onChanged: (String? newValue){
                        setState(() {
                          selectedStat = newValue!;
                        });
                      }
                  )
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 40, 0, 0),
                child: GestureDetector(
                  onTap: ()
                  {
                    addLineToChart();
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 5),
                        )
                      ]
                    ),
                    child: Center(child: Text("Add", textAlign: TextAlign.center))
                  )
                )
              ),
            ]
          ),
          Row(
            children: [
              for (MapEntry<String, List<FlSpot>> entry in chartStat.entries)
                Container(
                  margin: EdgeInsets.fromLTRB(40, 20, 0, 20),
                  child: GestureDetector(
                    onTap: ()
                    {
                      removeLineFromChart(entry.key);
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        color: widget.statToColor[entry.key],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 5),
                          )
                        ]
                      ),
                      child: Center(child: Text(entry.key))
                    )
                  )
                ),
            ],
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(50, 20, 150, 50),
            child: AspectRatio(
              aspectRatio: 3,
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                  ),
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                        return touchedBarSpots.map((spot) {
                          String? statName  = widget.colorToStat[spot.bar.color];
                          double  val       = spot.y;

                          return LineTooltipItem(
                              "$statName: $val",
                              TextStyle(color: spot.bar.color, fontWeight: FontWeight.bold)
                          );
                        }).toList();
                      }
                    )
                  ),
                  lineBarsData: [
                    for (MapEntry<String, List<FlSpot>> entry in chartStat.entries)
                      LineChartBarData(
                        spots: entry.value,
                        isCurved: false,
                        color: widget.statToColor[entry.key]
                      ),
                  ]
                )
              )
            )
          )
        ]
      );
    }
    else
    {
      return CircularProgressIndicator();
    }
  }
  String getOpposingTeamGradeFromGame(PitcherGame game)
  {
    if (game.opposingTeamHittingGrade != null)
    {
      return getLetterGradeFromPercentileForMatchup(game.opposingTeamHittingGrade!);
    }
    else
    {
      return "none";
    }
  }

  void addLineToChart()
  {
    widget.playerDataSource.getPitchingPerGameStats(widget.id, selectedSeason, selectedStat).then((List<PitcherPerGameStat> stats)
    {
      List<FlSpot> flStats = <FlSpot>[];

      for (int i=0; i<stats.length; ++i)
      {
        flStats.add(FlSpot(i as double, stats[i].stat));
      }

      setState(() {
        chartStat[selectedStat] = flStats;
      });
    });
  }

  void removeLineFromChart(String stat)
  {
    setState(() {
      chartStat.remove(stat);
    });
  }

  String getLetterGradeFromPercentileForMatchup(double percentile)
  {
    if (percentile >= 80.0)
    {
      return "A";
    }
    else if (percentile >= 60.0)
    {
      return "B";
    }
    else if (percentile >= 40.0)
    {
      return "C";
    }
    else if (percentile >= 20.0)
    {
      return "D";
    }
    else
    {
      return "F";
    }
  }
}