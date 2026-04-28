import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:fantasy_baseball_app/data/PlayerDataSource.dart';
import 'package:fantasy_baseball_app/model/HitterGame.dart';
import 'package:fantasy_baseball_app/model/HitterPerGameStat.dart';
import 'package:fantasy_baseball_app/model/HitterSeasonSummary.dart';
import 'package:fantasy_baseball_app/model/HitterSummary.dart';
import 'package:fantasy_baseball_app/widgets/FavoriteButton.dart';

class HitterPageHeader extends StatefulWidget
{
  final PlayerDataSource playerDataSource = PlayerDataSource();

  final String id;

  final List<int>     seasons = [2026, 2025, 2024, 2023];
  final List<String>  stats = ["RUNS", "HOME_RUNS", "RBIS", "STOLEN_BASES", "OBP"];

  final Map<String, Color> statToColor = {
    "RUNS": Colors.redAccent,
    "HOME_RUNS": Colors.blueAccent,
    "RBIS": Colors.greenAccent,
    "STOLEN_BASES": Colors.pinkAccent,
    "OBP": Colors.orange
  };

  final Map<Color, String> colorToStat = {
    Colors.redAccent: "RUNS",
    Colors.blueAccent: "HOME_RUNS",
    Colors.greenAccent: "RBIS",
    Colors.pinkAccent: "STOLEN_BASES",
    Colors.orange: "OBP"
  };

  HitterPageHeader({super.key, required this.id});

  @override
  HitterPageHeaderState createState() => HitterPageHeaderState();
}

class HitterPageHeaderState extends State<HitterPageHeader>
{
  bool finishedLoadingHitterSummary    = false;
  bool finishedLoadingSeasonSummaries  = false;

  late HitterSummary              hitterSummary;
  late List<HitterSeasonSummary>  seasonSummaries;
  Map<String, List<FlSpot>>       chartStat = {};

  int     selectedSeason  = 2026;
  String  selectedStat    = "RUNS";

  @override
  void initState()
  {
    super.initState();

    widget.playerDataSource.getHitterSummary(widget.id).then((HitterSummary summary){
      setState(()
      {
        hitterSummary = summary;

        finishedLoadingHitterSummary = true;
      });
    });

    widget.playerDataSource.getHittingSeasonSummaries(widget.id, 2023).then((List<HitterSeasonSummary> summaries){
      setState(()
      {
        finishedLoadingSeasonSummaries = true;

        seasonSummaries = summaries;
      });
    });
  }

  @override
  Widget build(BuildContext context)
  {
    if (finishedLoadingHitterSummary && finishedLoadingSeasonSummaries) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FavoriteButton(id: widget.id, name: hitterSummary.name, position: hitterSummary.position, team: hitterSummary.team, marginLeft: 0, marginRight: 20, marginTop: 10, marginBottom: 0),
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                alignment: Alignment.center,
                child: Text(
                  hitterSummary.name,
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
                  "Age: ${hitterSummary.age}    Height: ${hitterSummary.height}    Weight: ${hitterSummary.weight.toString()}",
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
                  "Team: ${hitterSummary.team}    Position: ${hitterSummary.position}",
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
                  "Bat Side: ${hitterSummary.batSide}    Throw Side: ${hitterSummary.throwSide}",
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
                  margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  alignment: Alignment.center,
                  child: Text(
                    "Projections",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0
                    ),
                  )
                ))
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
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Projected Grade", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Projected Runs", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Runs Grade", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Projected HRs", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("HRs Grade", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Projected Rbis", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Rbis Grade", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Projected SBs", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("SBs Grade", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Projected OBP", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("OBP Grade", style: TextStyle(fontSize: 12)))),
                          ]
                        )
                      )
                    )
                  ],
                )
              ),
              Divider(),
              ListTile(
                title: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Expanded(child: Container(alignment: Alignment.center, child: Text(getLetterGradeFromPercentile(hitterSummary.overallPercentileGrade), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(hitterSummary.runs.toString(), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(getLetterGradeFromPercentile(hitterSummary.overallPercentileRuns), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(hitterSummary.homeRuns.toString(),style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(getLetterGradeFromPercentile(hitterSummary.overallPercentileHomeRuns), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(hitterSummary.rbis.toString(), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(getLetterGradeFromPercentile(hitterSummary.overallPercentileRbis), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(hitterSummary.stolenBases.toString(), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(getLetterGradeFromPercentile(hitterSummary.overallPercentileStolenBases), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(hitterSummary.obp.toStringAsFixed(3), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(getLetterGradeFromPercentile(hitterSummary.overallPercentileObp), style: TextStyle(fontSize: 12)))),
                          ]
                        )
                      )
                    )
                  ],
                )
              ),
              Divider()
            ]
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                    margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
                    alignment: Alignment.center,
                    child: Text(
                      "Previous Seasons",
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
                                Expanded(child: Container(alignment: Alignment.center, child: Text("PA", style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text("AB", style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text("Runs", style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text("Hits", style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text("Doubles", style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text("Triples", style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text("HR", style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text("RBIs", style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text("W", style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text("K", style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text("SB", style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text("BA", style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text("OBP", style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text("SLG", style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text("OPS", style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text("BABIP", style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text("SPD", style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text("GB %", style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text("FB %", style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text("LD %", style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text("PU %", style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text("HH %", style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text("Barrel %", style: TextStyle(fontSize: 12)))),
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
                                Expanded(child: Container(alignment: Alignment.center, child: Text(summary.plateAppearances.toString(), style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(summary.atBats.toString(), style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(summary.runs.toString(), style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(summary.hits.toString(), style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(summary.doubles.toString(), style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(summary.triples.toString(), style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(summary.homeRuns.toString(), style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(summary.rbis.toString(), style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(summary.walks.toString(), style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(summary.strikeOuts.toString(), style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(summary.stolenBases.toString(), style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(summary.battingAverage.toStringAsFixed(3), style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(summary.onBasePercentage.toStringAsFixed(3), style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(summary.sluggingPercentage.toStringAsFixed(3), style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(summary.onBasePlusSlugging.toStringAsFixed(3), style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(summary.babip.toStringAsFixed(3), style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(summary.spd.toStringAsFixed(1), style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(summary.groundBallPercentage.toStringAsFixed(2), style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(summary.flyBallPercentage.toStringAsFixed(2), style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(summary.lineDrivePercentage.toStringAsFixed(2), style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(summary.popUpPercentage.toStringAsFixed(2), style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(summary.hardHitPercentage.toStringAsFixed(2), style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(summary.barrelPercentage.toStringAsFixed(2), style: TextStyle(fontSize: 12)))),
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
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Pitcher", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Venue", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Date", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Matchup Grade", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Pitcher Grade", style: TextStyle(fontSize: 12)))),
                          ]
                        )
                      )
                    )
                  ],
                )
              ),
              Divider(),
              for (final game in hitterSummary.upcomingSchedule)...[
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
                              Expanded(child: Container(alignment: Alignment.center, child: Text(getOpposingPitcherNameFromGame(game), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(game.venue, style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(game.date, style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(getOpposingTeamGradeFromGame(game), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(getOpposingPitcherGradeFromGame(game), style: TextStyle(fontSize: 12))))
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
                    margin: EdgeInsets.fromLTRB(40, 20, 0, 0),
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
            margin: const EdgeInsets.fromLTRB(50, 20, 50, 50),
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

  String getOpposingPitcherNameFromGame(HitterGame game)
  {
    if (game.opposingPitcherSummary != null)
    {
      return "${game.opposingPitcherSummary?.firstName} ${game.opposingPitcherSummary?.lastName}";
    }
    else
    {
      return "unknown";
    }
  }

  String getOpposingPitcherGradeFromGame(HitterGame game)
  {
    if (game.opposingPitcherSummary != null)
    {
      return getLetterGradeFromPercentile(game.opposingPitcherSummary!.percentileOverall);
    }
    else
    {
      return "none";
    }
  }

  String getOpposingTeamGradeFromGame(HitterGame game)
  {
    if (game.opposingTeamPitchingGrade != null)
    {
      return getLetterGradeFromPercentileForMatchup(game.opposingTeamPitchingGrade!);
    }
    else
    {
      return "none";
    }
  }

  void addLineToChart()
  {
    widget.playerDataSource.getHittingPerGameStats(widget.id, selectedSeason, selectedStat).then((List<HitterPerGameStat> stats)
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

  String getLetterGradeFromPercentile(double percentile)
  {
    if (percentile >= 80.0)
    {
      return "A";
    }
    else if (percentile >= 60.0)
    {
      return "B";
    }
    else if (percentile >= 70.0)
    {
      return "C";
    }
    else if (percentile >= 60.0)
    {
      return "D";
    }
    else if (percentile == -1.0)
    {
      return "none";
    }
    else
    {
      return "F";
    }
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