import 'package:flutter/material.dart';

import 'package:fantasy_baseball_app/data/PlayerDataSource.dart';
import 'package:fantasy_baseball_app/model/TeamSummary.dart';

class TeamSummaryBody extends StatefulWidget
{
  final PlayerDataSource playerDataSource = PlayerDataSource();

  final String teamId;

  TeamSummaryBody({super.key, required this.teamId});

  @override
  TeamSummaryBodyState createState() => TeamSummaryBodyState();
}

class TeamSummaryBodyState extends State<TeamSummaryBody>
{
  bool  finishedLoadingTeamSummary  = false;
  int   season                      = 2026;

  late TeamSummary teamSummary;

  @override
  void initState()
  {
    super.initState();

    widget.playerDataSource.getTeamSummary(widget.teamId, season).then((TeamSummary summary){
      setState(() {
        teamSummary                 = summary;
        finishedLoadingTeamSummary  = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!finishedLoadingTeamSummary)
    {
      return Center(child: CircularProgressIndicator());
    }
    else
    {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  alignment: Alignment.center,
                  child: Text(
                    "Pitching Matchup Grades",
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
                              Expanded(child: Container(alignment: Alignment.center, child: Text("ERA", style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text("Grade", style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text("WHIP", style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text("Grade", style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text("Ks/9", style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text("Grade", style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text("Quality Starts", style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text("Grade", style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text("Saves + Holds", style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text("Grade", style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text("SP Grade", style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text("RP Grade", style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text("Overall Grade", style: TextStyle(fontSize: 12)))),
                            ],
                          ),
                        )
                    )
                  ],
                ),
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
                            Expanded(child: Container(alignment: Alignment.center, child: Text(teamSummary.eraAgainst.toStringAsFixed(2), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(getLetterGradeFromPercentileForMatchup(teamSummary.percentileEra), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(teamSummary.whipAgainst.toStringAsFixed(2), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(getLetterGradeFromPercentileForMatchup(teamSummary.percentileWhip), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(teamSummary.ksPerNineAgainst.toStringAsFixed(2), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(getLetterGradeFromPercentileForMatchup(teamSummary.percentileKsPerNine), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(teamSummary.qualityStartsAgainst.toString(),style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(getLetterGradeFromPercentileForMatchup(teamSummary.percentileQualityStarts),style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text((teamSummary.savesAgainst + teamSummary.holdsAgainst).toString(), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(getLetterGradeFromPercentileForMatchup(teamSummary.percentileSavesAndHolds), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(getLetterGradeFromPercentileForMatchup(teamSummary.percentileStartingPitchers), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(getLetterGradeFromPercentileForMatchup(teamSummary.percentileReliefPitchers), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(getLetterGradeFromPercentileForMatchup(teamSummary.percentileHittingOverall), style: TextStyle(fontSize: 12)))),
                          ]
                        )
                      )
                    )
                  ],
                )
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
                  alignment: Alignment.center,
                  child: Text(
                    "Hitting Matchup Grades",
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
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Runs", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Grade", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Home Runs", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Grade", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("RBIs", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Grade", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Stolen Bases", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Grade", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("OBP", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Grade", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Overall Grade", style: TextStyle(fontSize: 12)))),
                          ],
                        ),
                      )
                    )
                  ],
                ),
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
                            Expanded(child: Container(alignment: Alignment.center, child: Text(teamSummary.runs.toString(), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(getLetterGradeFromPercentileForMatchup(teamSummary.percentileRuns), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(teamSummary.homeRuns.toString(), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(getLetterGradeFromPercentileForMatchup(teamSummary.percentileHomeRuns), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(teamSummary.rbisAgainst.toString(), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(getLetterGradeFromPercentileForMatchup(teamSummary.percentileRbis), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(teamSummary.stolenBases.toString(),style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(getLetterGradeFromPercentileForMatchup(teamSummary.percentileStolenBases),style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(teamSummary.onBasePercentageAgainst.toStringAsFixed(3), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(getLetterGradeFromPercentileForMatchup(teamSummary.percentileOnBasePercentage), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text(getLetterGradeFromPercentileForMatchup(teamSummary.percentilePitchingOverall), style: TextStyle(fontSize: 12)))),
                          ]
                        )
                      )
                    )
                  ],
                )
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
                  alignment: Alignment.center,
                  child: Text(
                    "Batters",
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
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Name", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Position", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Runs", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Home Runs", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("RBIs", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Stolen Bases", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("OBP", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Grade", style: TextStyle(fontSize: 12)))),
                          ],
                        ),
                      )
                    )
                  ],
                ),
              ),
              Divider(),
              for (final batter in teamSummary.teamBatters)...[
                ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Expanded(child: Container(alignment: Alignment.center, child: Text(batter.name, style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(batter.position, style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(batter.runs.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(batter.homeRuns.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(batter.rbis.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(batter.stolenBases.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(batter.obp.toStringAsFixed(3),style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(getLetterGradeFromPercentile(batter.overallPercentile),style: TextStyle(fontSize: 12)))),
                            ]
                          )
                        )
                      )
                    ],
                  )
                ),
                Divider(),
              ]
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
                  alignment: Alignment.center,
                  child: Text(
                    "Starting Pitchers",
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
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Name", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("ERA", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("WHIP", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Ks/9", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Quality Starts", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Grade", style: TextStyle(fontSize: 12)))),
                          ],
                        ),
                      )
                    )
                  ],
                ),
              ),
              Divider(),
              for (final pitcher in teamSummary.teamStartingPitchers)...[
                ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Expanded(child: Container(alignment: Alignment.center, child: Text(pitcher.name, style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(pitcher.era.toStringAsFixed(2), style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(pitcher.whip.toStringAsFixed(2), style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(pitcher.ksPerNine.toStringAsFixed(2), style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(pitcher.qualityStarts.toString(), style: TextStyle(fontSize: 12)))),
                                Expanded(child: Container(alignment: Alignment.center, child: Text(getLetterGradeFromPercentile(pitcher.overallPercentile), style: TextStyle(fontSize: 12)))),
                              ]
                            )
                          )
                        )
                      ],
                    )
                ),
                Divider(),
              ]
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 40, 10, 0),
                  alignment: Alignment.center,
                  child: Text(
                    "Relief Pitchers",
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
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Name", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("ERA", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("WHIP", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Ks/9", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Saves", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Holds", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Container(alignment: Alignment.center, child: Text("Grade", style: TextStyle(fontSize: 12)))),
                          ],
                        ),
                      )
                    )
                  ],
                ),
              ),
              Divider(),
              for (final pitcher in teamSummary.teamReliefPitchers)...[
                ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Expanded(child: Container(alignment: Alignment.center, child: Text(pitcher.name, style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(pitcher.era.toStringAsFixed(2), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(pitcher.whip.toStringAsFixed(2), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(pitcher.ksPerNine.toStringAsFixed(2), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(pitcher.saves.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(pitcher.holds.toString(), style: TextStyle(fontSize: 12)))),
                              Expanded(child: Container(alignment: Alignment.center, child: Text(getLetterGradeFromPercentile(pitcher.overallPercentile), style: TextStyle(fontSize: 12)))),
                            ]
                          )
                        )
                      )
                    ],
                  )
                ),
                Divider(),
              ]
            ],
          ),
        ],
      );
    }
  }

  String getLetterGradeFromPercentile(double percentile)
  {
    if (percentile >= 90.0)
    {
      return "A";
    }
    else if (percentile >= 80.0)
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