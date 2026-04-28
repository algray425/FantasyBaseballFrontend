import 'package:fantasy_baseball_app/data/UserDataSource.dart';
import 'package:fantasy_baseball_app/model/ReliefPitcherSummary.dart';
import 'package:fantasy_baseball_app/model/StartingPitcherSummary.dart';
import 'package:fantasy_baseball_app/pages/PitcherPage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../model/FantasyTeamSummary.dart';
import '../model/HitterModel.dart';
import '../model/HittingStat.dart';
import '../model/PitchingStat.dart';
import '../pages/HitterPage.dart';

class FantasyTeamSummaryWidget extends StatefulWidget
{
  final UserDataSource userDataSource = UserDataSource();

  final String leagueType;
  final String leagueId;
  final String teamId;
  final String userId;

  FantasyTeamSummaryWidget({super.key, required this.leagueType, required this.leagueId, required this.teamId, required this.userId});

  @override
  FantasyTeamSummaryWidgetState createState() => FantasyTeamSummaryWidgetState();
}

class FantasyTeamSummaryWidgetState extends State<FantasyTeamSummaryWidget>
{
  bool finishedLoadingSummary = false;
  late FantasyTeamSummary fantasyTeamSummary;

  @override
  void initState()
  {
    super.initState();

    widget.userDataSource.getFantasyTeamSummary(widget.userId, widget.leagueType, widget.leagueId, widget.teamId).then((FantasyTeamSummary summary){
      setState(() {
        fantasyTeamSummary      = summary;
        finishedLoadingSummary  = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> hittingStatToGrade          = finishedLoadingSummary ? getTeamPerStatHittingGrades          (fantasyTeamSummary.hitterSummaries         ) : {};
    Map<String, String> startingPitchingStatToGrade = finishedLoadingSummary ? getTeamPerStatStartingPitchingGrades (fantasyTeamSummary.startingPitcherSummaries) : {};
    Map<String, String> reliefPitchingStatToGrade   = finishedLoadingSummary ? getTeamPerStatReliefPitchingGrade    (fantasyTeamSummary.reliefPitcherSummaries  ) : {};

    Map<String, String> matchupHittingStatToGrade          = finishedLoadingSummary ? getTeamPerStatHittingGrades          (fantasyTeamSummary.upcomingMatchupHitterSummaries         ) : {};
    Map<String, String> matchupStartingPitchingStatToGrade = finishedLoadingSummary ? getTeamPerStatStartingPitchingGrades (fantasyTeamSummary.upcomingMatchupStartingPitcherSummaries) : {};
    Map<String, String> matchupReliefPitchingStatToGrade   = finishedLoadingSummary ? getTeamPerStatReliefPitchingGrade    (fantasyTeamSummary.upcomingMatchupReliefPitcherSummaries  ) : {};

    return Column(
      children: [
        if (finishedLoadingSummary)...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text("Team Grades", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text("Overall Hitting Grade: ${hittingStatToGrade["overall"]}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text("Runs Grade: ${hittingStatToGrade["runs"]}", style: TextStyle(fontSize: 18))
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text("HRs Grade: ${hittingStatToGrade["homeRuns"]}", style: TextStyle(fontSize: 18))
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text("RBIs Grade: ${hittingStatToGrade["rbis"]}", style: TextStyle(fontSize: 18))
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text("SBs Grade: ${hittingStatToGrade["sbs"]}", style: TextStyle(fontSize: 18))
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text("OBP Grade: ${hittingStatToGrade["obp"]}", style: TextStyle(fontSize: 18))
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text("Overall Starting Pitching Grade: ${startingPitchingStatToGrade["overall"]}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text("QS Grade: ${startingPitchingStatToGrade["qs"]}", style: TextStyle(fontSize: 18))
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text("ERA Grade: ${startingPitchingStatToGrade["era"]}", style: TextStyle(fontSize: 18))
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text("WHIP Grade: ${startingPitchingStatToGrade["whip"]}", style: TextStyle(fontSize: 18))
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text("Ks/9 Grade: ${startingPitchingStatToGrade["ks"]}", style: TextStyle(fontSize: 18))
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text("Overall Relief Pitching Grade: ${reliefPitchingStatToGrade["overall"]}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text("S/H Grade: ${reliefPitchingStatToGrade["sh"]}", style: TextStyle(fontSize: 18))
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text("ERA Grade: ${reliefPitchingStatToGrade["era"]}", style: TextStyle(fontSize: 18))
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text("WHIP Grade: ${reliefPitchingStatToGrade["whip"]}", style: TextStyle(fontSize: 18))
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text("Ks/9 Grade: ${reliefPitchingStatToGrade["ks"]}", style: TextStyle(fontSize: 18))
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 40),
                  child: Text("Player Grades", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)))
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
          Container(
            margin: EdgeInsets.fromLTRB(50, 0, 10, 0),
            height: 500,
            width: 1000,
            decoration: BoxDecoration(
              color: Colors.lightBlue,
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
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
                children: [
                  ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(child: Text("Name", style: TextStyle(fontSize: 12))),
                              Expanded(child: Text("Team",style: TextStyle(fontSize: 12))),
                              Expanded(child: Text("Position",style: TextStyle(fontSize: 12))),
                              Expanded(child: Text("Grade",style: TextStyle(fontSize: 12))),
                              Expanded(child: Text("Runs",style: TextStyle(fontSize: 12))),
                              Expanded(child: Text("HRs",style: TextStyle(fontSize: 12))),
                              Expanded(child: Text("RBIs",style: TextStyle(fontSize: 12))),
                              Expanded(child: Text("SBs",style: TextStyle(fontSize: 12))),
                              Expanded(child: Text("OBP",style: TextStyle(fontSize: 12))),
                            ],
                          )
                        ),
                      ]
                    )
                  ),
                  Divider(),
                  for (final hitter in fantasyTeamSummary.hitterSummaries)...[
                    ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(child: Text(hitter.name,style: TextStyle(fontSize: 12))),
                                Expanded(child: Text(hitter.team,style: TextStyle(fontSize: 12))),
                                Expanded(child: Text(hitter.position,style: TextStyle(fontSize: 12))),
                                Expanded(child: Text(getLetterGradeFromPercentile(hitter.overallPercentile),style: TextStyle(fontSize: 12))),
                                Expanded(child: Text(hitter.runs.toString(),style: TextStyle(fontSize: 12))),
                                Expanded(child: Text(hitter.homeRuns.toString(),style: TextStyle(fontSize: 12))),
                                Expanded(child: Text(hitter.rbis.toString(),style: TextStyle(fontSize: 12))),
                                Expanded(child: Text(hitter.stolenBases.toString(),style: TextStyle(fontSize: 12))),
                                Expanded(child: Text(hitter.obp.toStringAsFixed(3),style: TextStyle(fontSize: 12))),
                              ],
                            )
                          ),
                        ]
                      ),
                      onTap: ()
                      {
                        context.go(HitterPage.simpleRouteName + hitter.id);
                      },
                    ),
                    Divider()
                  ]
                ],
            )
          ),
         ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(50, 20, 10, 20),
                height: 500,
                width: 700,
                decoration: BoxDecoration(
                    color: Colors.lightBlue,
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
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    ListTile(
                        title: Row(
                            children: [
                              Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(child: Text("Name",style: TextStyle(fontSize: 12))),
                                      Expanded(child: Text("Team",style: TextStyle(fontSize: 12))),
                                      Expanded(child: Text("Grade",style: TextStyle(fontSize: 12))),
                                      Expanded(child: Text("QS",style: TextStyle(fontSize: 12))),
                                      Expanded(child: Text("ERA",style: TextStyle(fontSize: 12))),
                                      Expanded(child: Text("WHIP",style: TextStyle(fontSize: 12))),
                                      Expanded(child: Text("Ks/9",style: TextStyle(fontSize: 12))),
                                    ],
                                  )
                              ),
                            ]
                        )
                    ),
                    Divider(),
                    for (final pitcher in fantasyTeamSummary.startingPitcherSummaries)...[
                      ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(child: Text(pitcher.name,style: TextStyle(fontSize: 12))),
                                  Expanded(child: Text("n/a",style: TextStyle(fontSize: 12))),
                                  Expanded(child: Text(getLetterGradeFromPercentile(pitcher.overallPercentile),style: TextStyle(fontSize: 12))),
                                  Expanded(child: Text(pitcher.qualityStarts.toString(),style: TextStyle(fontSize: 12))),
                                  Expanded(child: Text(pitcher.era.toStringAsFixed(2),style: TextStyle(fontSize: 12))),
                                  Expanded(child: Text(pitcher.whip.toStringAsFixed(2),style: TextStyle(fontSize: 12))),
                                  Expanded(child: Text(pitcher.ksPerNine.toStringAsFixed(2),style: TextStyle(fontSize: 12))),
                                ],
                              )
                            ),
                          ]
                        ),
                        onTap: ()
                        {
                          context.go(PitcherPage.simpleRouteName + pitcher.id);
                        },
                      ),
                      Divider()
                    ]
                  ],
                )
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 20, 50, 20),
                  height: 500,
                  width: 700,
                  decoration: BoxDecoration(
                      color: Colors.lightBlue,
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
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(child: Text("Name",style: TextStyle(fontSize: 12))),
                                  Expanded(child: Text("Team",style: TextStyle(fontSize: 12))),
                                  Expanded(child: Text("Grade",style: TextStyle(fontSize: 12))),
                                  Expanded(child: Text("Saves + Holds",style: TextStyle(fontSize: 12))),
                                  Expanded(child: Text("ERA",style: TextStyle(fontSize: 12))),
                                  Expanded(child: Text("WHIP",style: TextStyle(fontSize: 12))),
                                  Expanded(child: Text("Ks/9",style: TextStyle(fontSize: 12))),
                                ],
                              )
                            ),
                          ]
                        )
                      ),
                      Divider(),
                      for (final pitcher in fantasyTeamSummary.reliefPitcherSummaries)...[
                        ListTile(
                          title: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(child: Text(pitcher.name,style: TextStyle(fontSize: 12))),
                                    Expanded(child: Text("n/a",style: TextStyle(fontSize: 12))),
                                    Expanded(child: Text(getLetterGradeFromPercentile(pitcher.overallPercentile),style: TextStyle(fontSize: 12))),
                                    Expanded(child: Text((pitcher.saves + pitcher.holds).toString(),style: TextStyle(fontSize: 12))),
                                    Expanded(child: Text(pitcher.era.toStringAsFixed(2),style: TextStyle(fontSize: 12))),
                                    Expanded(child: Text(pitcher.whip.toStringAsFixed(2),style: TextStyle(fontSize: 12))),
                                    Expanded(child: Text(pitcher.ksPerNine.toStringAsFixed(2),style: TextStyle(fontSize: 12))),
                                  ],
                                )
                              ),
                            ]
                          ),
                          onTap: ()
                          {
                            context.go(PitcherPage.simpleRouteName + pitcher.id);
                          },
                        ),
                        Divider()
                      ]
                    ],
                  )
              )
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 40),
                  child: Text("Current Matchup", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)))
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(300, 0, 300, 0),
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: Center(child: Text("Stat", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Center(child: Text("Me",style: TextStyle(fontSize: 12)))),
                            Expanded(child: Center(child: Text("Opp",style: TextStyle(fontSize: 12)))),
                          ],
                        )
                      ),
                    ]
                  )
                ),
                Divider(),
                ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: Center(child: Text("Runs", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Center(child: Text(getCurMatchupHittingStatMyTeam (HittingStat.RUNS),style: TextStyle(fontSize: 12)))),
                            Expanded(child: Center(child: Text(getCurMatchupHittingStatOppTeam(HittingStat.RUNS),style: TextStyle(fontSize: 12)))),
                          ],
                        )
                      ),
                    ]
                  )
                ),
                Divider(),
                ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: Center(child: Text("Home Runs", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Center(child: Text(getCurMatchupHittingStatMyTeam (HittingStat.HOME_RUNS),style: TextStyle(fontSize: 12)))),
                            Expanded(child: Center(child: Text(getCurMatchupHittingStatOppTeam(HittingStat.HOME_RUNS),style: TextStyle(fontSize: 12)))),
                          ],
                        )
                      ),
                    ]
                  )
                ),
                Divider(),
                ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: Center(child: Text("RBIs", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Center(child: Text(getCurMatchupHittingStatMyTeam (HittingStat.RBIS),style: TextStyle(fontSize: 12)))),
                            Expanded(child: Center(child: Text(getCurMatchupHittingStatOppTeam(HittingStat.RBIS),style: TextStyle(fontSize: 12)))),
                          ],
                        )
                      ),
                    ]
                  )
                ),
                Divider(),
                ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: Center(child: Text("Stolen Bases", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Center(child: Text(getCurMatchupHittingStatMyTeam (HittingStat.STOLEN_BASES),style: TextStyle(fontSize: 12)))),
                            Expanded(child: Center(child: Text(getCurMatchupHittingStatOppTeam(HittingStat.STOLEN_BASES),style: TextStyle(fontSize: 12)))),
                          ],
                        )
                      ),
                    ]
                  )
                ),
                Divider(),
                ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: Center(child: Text("OBP", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Center(child: Text(getCurMatchupHittingStatMyTeam (HittingStat.OBP),style: TextStyle(fontSize: 12)))),
                            Expanded(child: Center(child: Text(getCurMatchupHittingStatOppTeam(HittingStat.OBP),style: TextStyle(fontSize: 12)))),
                          ],
                        )
                      ),
                    ]
                  )
                ),
                Divider(),
                ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: Center(child: Text("OBP", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Center(child: Text(getCurMatchupPitchingStatMyTeam (PitchingStat.QUALITY_STARTS),style: TextStyle(fontSize: 12)))),
                            Expanded(child: Center(child: Text(getCurMatchupPitchingStatOppTeam(PitchingStat.QUALITY_STARTS),style: TextStyle(fontSize: 12)))),
                          ],
                        )
                      ),
                    ]
                  )
                ),
                Divider(),
                ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: Center(child: Text("SV + HD", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Center(child: Text(getCurMatchupPitchingStatMyTeam (PitchingStat.SAVES),style: TextStyle(fontSize: 12)))),
                            Expanded(child: Center(child: Text(getCurMatchupPitchingStatOppTeam(PitchingStat.SAVES),style: TextStyle(fontSize: 12)))),
                          ],
                        )
                      ),
                    ]
                  )
                ),
                Divider(),
                ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: Center(child: Text("ERA", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Center(child: Text(getCurMatchupPitchingStatMyTeam (PitchingStat.ERA),style: TextStyle(fontSize: 12)))),
                            Expanded(child: Center(child: Text(getCurMatchupPitchingStatOppTeam(PitchingStat.ERA),style: TextStyle(fontSize: 12)))),
                          ],
                        )
                      ),
                    ]
                  )
                ),
                Divider(),
                ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: Center(child: Text("WHIP", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Center(child: Text(getCurMatchupPitchingStatMyTeam (PitchingStat.WHIP),style: TextStyle(fontSize: 12)))),
                            Expanded(child: Center(child: Text(getCurMatchupPitchingStatOppTeam(PitchingStat.WHIP),style: TextStyle(fontSize: 12)))),
                          ],
                        )
                      ),
                    ]
                  )
                ),
                Divider(),
                ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: Center(child: Text("Ks/9", style: TextStyle(fontSize: 12)))),
                            Expanded(child: Center(child: Text(getCurMatchupPitchingStatMyTeam (PitchingStat.KS_PER_NINE),style: TextStyle(fontSize: 12)))),
                            Expanded(child: Center(child: Text(getCurMatchupPitchingStatOppTeam(PitchingStat.KS_PER_NINE),style: TextStyle(fontSize: 12)))),
                          ],
                        )
                      ),
                    ]
                  )
                ),
                Divider(),
                ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: Center(child: Text("Wins", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)))),
                            Expanded(child: Center(child: Text(getMyWinsCurMatchup(), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Center(child: Text(getOppWinsCurMatchup(), style: TextStyle(fontSize: 12)))),
                          ],
                        )
                      ),
                    ]
                  )
                ),
                Divider(),
                ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: Center(child: Text("Losses", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)))),
                            Expanded(child: Center(child: Text(getMyLossesCurMatchup(), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Center(child: Text(getOppLossesCurMatchup(), style: TextStyle(fontSize: 12)))),
                          ],
                        )
                      ),
                    ]
                  )
                ),
                Divider(),
                ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: Center(child: Text("Ties", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)))),
                            Expanded(child: Center(child: Text(getMyTiesCurMatchup(), style: TextStyle(fontSize: 12)))),
                            Expanded(child: Center(child: Text(getOppTiesCurMatchup(), style: TextStyle(fontSize: 12)))),
                          ],
                        )
                      ),
                    ]
                  )
                ),
                Divider(),
              ],
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text("Upcoming Opponent Grades", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text("Overall Hitting Grade: ${matchupHittingStatToGrade["overall"]}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text("Runs Grade: ${matchupHittingStatToGrade["runs"]}", style: TextStyle(fontSize: 18))
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text("HRs Grade: ${matchupHittingStatToGrade["homeRuns"]}", style: TextStyle(fontSize: 18))
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text("RBIs Grade: ${matchupHittingStatToGrade["rbis"]}", style: TextStyle(fontSize: 18))
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text("SBs Grade: ${matchupHittingStatToGrade["sbs"]}", style: TextStyle(fontSize: 18))
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text("OBP Grade: ${matchupHittingStatToGrade["obp"]}", style: TextStyle(fontSize: 18))
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text("Overall Starting Pitching Grade: ${matchupStartingPitchingStatToGrade["overall"]}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text("QS Grade: ${matchupStartingPitchingStatToGrade["qs"]}", style: TextStyle(fontSize: 18))
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text("ERA Grade: ${matchupStartingPitchingStatToGrade["era"]}", style: TextStyle(fontSize: 18))
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text("WHIP Grade: ${matchupStartingPitchingStatToGrade["whip"]}", style: TextStyle(fontSize: 18))
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Text("Ks/9 Grade: ${matchupStartingPitchingStatToGrade["ks"]}", style: TextStyle(fontSize: 18))
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text("Overall Relief Pitching Grade: ${matchupReliefPitchingStatToGrade["overall"]}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 0, 40),
                child: Text("S/H Grade: ${matchupReliefPitchingStatToGrade["sh"]}", style: TextStyle(fontSize: 18))
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 0, 40),
                child: Text("ERA Grade: ${matchupReliefPitchingStatToGrade["era"]}", style: TextStyle(fontSize: 18))
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 0, 40),
                child: Text("WHIP Grade: ${matchupReliefPitchingStatToGrade["whip"]}", style: TextStyle(fontSize: 18))
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 0, 40),
                child: Text("Ks/9 Grade: ${matchupReliefPitchingStatToGrade["ks"]}", style: TextStyle(fontSize: 18))
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //         margin: EdgeInsets.fromLTRB(0, 20, 0, 40),
          //         child: Text("Best Available Hitters", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)))
          //   ],
          // ),
          // Container(
          //   margin: EdgeInsets.fromLTRB(100, 0, 100, 0),
          //   child: ListView(
          //     scrollDirection: Axis.vertical,
          //     shrinkWrap: true,
          //     children: [
          //       ListTile(
          //           title: Row(
          //               children: [
          //                 Expanded(
          //                     child: Row(
          //                       children: [
          //                         Expanded(child: Text("Name", style: TextStyle(fontSize: 12))),
          //                         Expanded(child: Text("Team",style: TextStyle(fontSize: 12))),
          //                         Expanded(child: Text("Position",style: TextStyle(fontSize: 12))),
          //                         Expanded(child: Text("Grade",style: TextStyle(fontSize: 12))),
          //                         Expanded(child: Text("Runs",style: TextStyle(fontSize: 12))),
          //                         Expanded(child: Text("HRs",style: TextStyle(fontSize: 12))),
          //                         Expanded(child: Text("RBIs",style: TextStyle(fontSize: 12))),
          //                         Expanded(child: Text("SBs",style: TextStyle(fontSize: 12))),
          //                         Expanded(child: Text("OBP",style: TextStyle(fontSize: 12))),
          //                       ],
          //                     )
          //                 ),
          //               ]
          //           )
          //       ),
          //       Divider(),
          //       for (final hitter in fantasyTeamSummary.bestAvailableHitters)...[
          //         ListTile(
          //           title: Row(
          //             children: [
          //               Expanded(
          //                 child: Row(
          //                   children: [
          //                     Expanded(child: Text(hitter.name,style: TextStyle(fontSize: 12))),
          //                     Expanded(child: Text(hitter.team,style: TextStyle(fontSize: 12))),
          //                     Expanded(child: Text(hitter.position,style: TextStyle(fontSize: 12))),
          //                     Expanded(child: Text(getLetterGradeFromPercentile(hitter.overallPercentile),style: TextStyle(fontSize: 12))),
          //                     Expanded(child: Text(hitter.runs.toString(),style: TextStyle(fontSize: 12))),
          //                     Expanded(child: Text(hitter.homeRuns.toString(),style: TextStyle(fontSize: 12))),
          //                     Expanded(child: Text(hitter.rbis.toString(),style: TextStyle(fontSize: 12))),
          //                     Expanded(child: Text(hitter.stolenBases.toString(),style: TextStyle(fontSize: 12))),
          //                     Expanded(child: Text(hitter.obp.toStringAsFixed(3),style: TextStyle(fontSize: 12))),
          //                   ],
          //                 )
          //               ),
          //             ]
          //           )
          //         ),
          //         Divider()
          //       ]
          //     ],
          //   )
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //         margin: EdgeInsets.fromLTRB(0, 20, 0, 40),
          //         child: Text("Best Available Starting Pitchers", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)))
          //   ],
          // ),
          // Container(
          //     margin: EdgeInsets.fromLTRB(100, 0, 100, 0),
          //     child: ListView(
          //       scrollDirection: Axis.vertical,
          //       shrinkWrap: true,
          //       children: [
          //         ListTile(
          //             title: Row(
          //                 children: [
          //                   Expanded(
          //                       child: Row(
          //                         children: [
          //                           Expanded(child: Text("Name", style: TextStyle(fontSize: 12))),
          //                           Expanded(child: Text("Team",style: TextStyle(fontSize: 12))),
          //                           Expanded(child: Text("Grade",style: TextStyle(fontSize: 12))),
          //                           Expanded(child: Text("QS",style: TextStyle(fontSize: 12))),
          //                           Expanded(child: Text("ERA",style: TextStyle(fontSize: 12))),
          //                           Expanded(child: Text("WHIP",style: TextStyle(fontSize: 12))),
          //                           Expanded(child: Text("Ks/9",style: TextStyle(fontSize: 12))),
          //                         ],
          //                       )
          //                   ),
          //                 ]
          //             )
          //         ),
          //         Divider(),
          //         for (final pitcher in fantasyTeamSummary.bestAvailableStartingPitchers)...[
          //           ListTile(
          //               title: Row(
          //                   children: [
          //                     Expanded(
          //                         child: Row(
          //                           children: [
          //                             Expanded(child: Text(pitcher.name,style: TextStyle(fontSize: 12))),
          //                             Expanded(child: Text(pitcher.team,style: TextStyle(fontSize: 12))),
          //                             Expanded(child: Text(getLetterGradeFromPercentile(pitcher.overallPercentile),style: TextStyle(fontSize: 12))),
          //                             Expanded(child: Text(pitcher.qualityStarts.toString(),style: TextStyle(fontSize: 12))),
          //                             Expanded(child: Text(pitcher.era.toStringAsFixed(2),style: TextStyle(fontSize: 12))),
          //                             Expanded(child: Text(pitcher.whip.toStringAsFixed(2),style: TextStyle(fontSize: 12))),
          //                             Expanded(child: Text(pitcher.ksPerNine.toStringAsFixed(1),style: TextStyle(fontSize: 12))),
          //                           ],
          //                         )
          //                     ),
          //                   ]
          //               )
          //           ),
          //           Divider()
          //         ]
          //       ],
          //     )
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //         margin: EdgeInsets.fromLTRB(0, 20, 0, 40),
          //         child: Text("Best Available Relief Pitchers", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)))
          //   ],
          // ),
          // Container(
          //     margin: EdgeInsets.fromLTRB(100, 0, 100, 0),
          //     child: ListView(
          //       scrollDirection: Axis.vertical,
          //       shrinkWrap: true,
          //       children: [
          //         ListTile(
          //             title: Row(
          //                 children: [
          //                   Expanded(
          //                       child: Row(
          //                         children: [
          //                           Expanded(child: Text("Name", style: TextStyle(fontSize: 12))),
          //                           Expanded(child: Text("Team",style: TextStyle(fontSize: 12))),
          //                           Expanded(child: Text("Grade",style: TextStyle(fontSize: 12))),
          //                           Expanded(child: Text("S/H",style: TextStyle(fontSize: 12))),
          //                           Expanded(child: Text("ERA",style: TextStyle(fontSize: 12))),
          //                           Expanded(child: Text("WHIP",style: TextStyle(fontSize: 12))),
          //                           Expanded(child: Text("Ks/9",style: TextStyle(fontSize: 12))),
          //                         ],
          //                       )
          //                   ),
          //                 ]
          //             )
          //         ),
          //         Divider(),
          //         for (final pitcher in fantasyTeamSummary.bestAvailableReliefPitchers)...[
          //           ListTile(
          //             title: Row(
          //               children: [
          //                 Expanded(
          //                   child: Row(
          //                     children: [
          //                       Expanded(child: Text(pitcher.name,style: TextStyle(fontSize: 12))),
          //                       Expanded(child: Text(pitcher.team,style: TextStyle(fontSize: 12))),
          //                       Expanded(child: Text(getLetterGradeFromPercentile(pitcher.overallPercentile),style: TextStyle(fontSize: 12))),
          //                       Expanded(child: Text((pitcher.saves + pitcher.holds).toString(),style: TextStyle(fontSize: 12))),
          //                       Expanded(child: Text(pitcher.era.toStringAsFixed(2),style: TextStyle(fontSize: 12))),
          //                       Expanded(child: Text(pitcher.whip.toStringAsFixed(2),style: TextStyle(fontSize: 12))),
          //                       Expanded(child: Text(pitcher.ksPerNine.toStringAsFixed(1),style: TextStyle(fontSize: 12))),
          //                     ],
          //                   )
          //                 ),
          //               ]
          //             )
          //           ),
          //           Divider()
          //         ]
          //       ],
          //     )
          // )
        ]
        else
          Center(child: CircularProgressIndicator())
      ],
    );
  }

  String getCurMatchupHittingStatMyTeam(HittingStat stat)
  {
    switch(stat)
    {
      case HittingStat.RUNS:
        return fantasyTeamSummary.currentMatchup.homeTeamSummary.teamId.toString() == widget.teamId ? fantasyTeamSummary.currentMatchup.homeTeamSummary.runs.toString() : fantasyTeamSummary.currentMatchup.awayTeamSummary.runs.toString();
      case HittingStat.HOME_RUNS:
        return fantasyTeamSummary.currentMatchup.homeTeamSummary.teamId.toString() == widget.teamId ? fantasyTeamSummary.currentMatchup.homeTeamSummary.homeRuns.toString() : fantasyTeamSummary.currentMatchup.awayTeamSummary.homeRuns.toString();
      case HittingStat.RBIS:
        return fantasyTeamSummary.currentMatchup.homeTeamSummary.teamId.toString() == widget.teamId ? fantasyTeamSummary.currentMatchup.homeTeamSummary.rbis.toString() : fantasyTeamSummary.currentMatchup.awayTeamSummary.rbis.toString();
      case HittingStat.STOLEN_BASES:
        return fantasyTeamSummary.currentMatchup.homeTeamSummary.teamId.toString() == widget.teamId ? fantasyTeamSummary.currentMatchup.homeTeamSummary.stolenBases.toString() : fantasyTeamSummary.currentMatchup.awayTeamSummary.stolenBases.toString();
      case HittingStat.OBP:
        return fantasyTeamSummary.currentMatchup.homeTeamSummary.teamId.toString() == widget.teamId ? fantasyTeamSummary.currentMatchup.homeTeamSummary.onBasePercentage.toString() : fantasyTeamSummary.currentMatchup.awayTeamSummary.onBasePercentage.toString();
      default:
        return "";
    }
  }

  String getCurMatchupHittingStatOppTeam(HittingStat stat)
  {
    switch(stat)
    {
      case HittingStat.RUNS:
        return fantasyTeamSummary.currentMatchup.homeTeamSummary.teamId.toString() == widget.teamId ? fantasyTeamSummary.currentMatchup.awayTeamSummary.runs.toString() : fantasyTeamSummary.currentMatchup.homeTeamSummary.runs.toString();
      case HittingStat.HOME_RUNS:
        return fantasyTeamSummary.currentMatchup.homeTeamSummary.teamId.toString() == widget.teamId ? fantasyTeamSummary.currentMatchup.awayTeamSummary.homeRuns.toString() : fantasyTeamSummary.currentMatchup.homeTeamSummary.homeRuns.toString();
      case HittingStat.RBIS:
        return fantasyTeamSummary.currentMatchup.homeTeamSummary.teamId.toString() == widget.teamId ? fantasyTeamSummary.currentMatchup.awayTeamSummary.rbis.toString() : fantasyTeamSummary.currentMatchup.homeTeamSummary.rbis.toString();
      case HittingStat.STOLEN_BASES:
        return fantasyTeamSummary.currentMatchup.homeTeamSummary.teamId.toString() == widget.teamId ? fantasyTeamSummary.currentMatchup.awayTeamSummary.stolenBases.toString() : fantasyTeamSummary.currentMatchup.homeTeamSummary.stolenBases.toString();
      case HittingStat.OBP:
        return fantasyTeamSummary.currentMatchup.homeTeamSummary.teamId.toString() == widget.teamId ? fantasyTeamSummary.currentMatchup.awayTeamSummary.onBasePercentage.toStringAsFixed(3) : fantasyTeamSummary.currentMatchup.homeTeamSummary.onBasePercentage.toStringAsFixed(3);
      default:
        return "";
    }
  }

  String getCurMatchupPitchingStatMyTeam(PitchingStat stat)
  {
    switch(stat)
    {
      case PitchingStat.QUALITY_STARTS:
        return fantasyTeamSummary.currentMatchup.homeTeamSummary.teamId.toString() == widget.teamId ? fantasyTeamSummary.currentMatchup.homeTeamSummary.qualityStarts.toString() : fantasyTeamSummary.currentMatchup.awayTeamSummary.qualityStarts.toString();
      case PitchingStat.SAVES:
        return fantasyTeamSummary.currentMatchup.homeTeamSummary.teamId.toString() == widget.teamId ? fantasyTeamSummary.currentMatchup.homeTeamSummary.savesPlusHolds.toString() : fantasyTeamSummary.currentMatchup.awayTeamSummary.savesPlusHolds.toString();
      case PitchingStat.ERA:
        return fantasyTeamSummary.currentMatchup.homeTeamSummary.teamId.toString() == widget.teamId ? fantasyTeamSummary.currentMatchup.homeTeamSummary.era.toStringAsFixed(2) : fantasyTeamSummary.currentMatchup.awayTeamSummary.era.toStringAsFixed(2);
      case PitchingStat.WHIP:
        return fantasyTeamSummary.currentMatchup.homeTeamSummary.teamId.toString() == widget.teamId ? fantasyTeamSummary.currentMatchup.homeTeamSummary.whip.toStringAsFixed(2) : fantasyTeamSummary.currentMatchup.awayTeamSummary.whip.toStringAsFixed(2);
      case PitchingStat.KS_PER_NINE:
        return fantasyTeamSummary.currentMatchup.homeTeamSummary.teamId.toString() == widget.teamId ? fantasyTeamSummary.currentMatchup.homeTeamSummary.ksPerNine.toStringAsFixed(1) : fantasyTeamSummary.currentMatchup.awayTeamSummary.ksPerNine.toStringAsFixed(1);
      default:
        return "";
    }
  }

  String getCurMatchupPitchingStatOppTeam(PitchingStat stat)
  {
    switch(stat)
    {
      case PitchingStat.QUALITY_STARTS:
        return fantasyTeamSummary.currentMatchup.homeTeamSummary.teamId.toString() == widget.teamId ? fantasyTeamSummary.currentMatchup.awayTeamSummary.qualityStarts.toString() : fantasyTeamSummary.currentMatchup.homeTeamSummary.qualityStarts.toString();
      case PitchingStat.SAVES:
        return fantasyTeamSummary.currentMatchup.homeTeamSummary.teamId.toString() == widget.teamId ? fantasyTeamSummary.currentMatchup.awayTeamSummary.savesPlusHolds.toString() : fantasyTeamSummary.currentMatchup.homeTeamSummary.savesPlusHolds.toString();
      case PitchingStat.ERA:
        return fantasyTeamSummary.currentMatchup.homeTeamSummary.teamId.toString() == widget.teamId ? fantasyTeamSummary.currentMatchup.awayTeamSummary.era.toStringAsFixed(2) : fantasyTeamSummary.currentMatchup.homeTeamSummary.era.toStringAsFixed(2);
      case PitchingStat.WHIP:
        return fantasyTeamSummary.currentMatchup.homeTeamSummary.teamId.toString() == widget.teamId ? fantasyTeamSummary.currentMatchup.awayTeamSummary.whip.toStringAsFixed(2) : fantasyTeamSummary.currentMatchup.homeTeamSummary.whip.toStringAsFixed(2);
      case PitchingStat.KS_PER_NINE:
        return fantasyTeamSummary.currentMatchup.homeTeamSummary.teamId.toString() == widget.teamId ? fantasyTeamSummary.currentMatchup.awayTeamSummary.ksPerNine.toStringAsFixed(1) : fantasyTeamSummary.currentMatchup.homeTeamSummary.ksPerNine.toStringAsFixed(1);
      default:
        return "";
    }
  }

  String getMyWinsCurMatchup()
  {
    return fantasyTeamSummary.currentMatchup.homeTeamSummary.teamId.toString() == widget.teamId ? fantasyTeamSummary.currentMatchup.homeTeamSummary.wins.toString() : fantasyTeamSummary.currentMatchup.awayTeamSummary.wins.toString();
  }

  String getOppWinsCurMatchup()
  {
    return fantasyTeamSummary.currentMatchup.homeTeamSummary.teamId.toString() == widget.teamId ? fantasyTeamSummary.currentMatchup.homeTeamSummary.wins.toString() : fantasyTeamSummary.currentMatchup.awayTeamSummary.wins.toString();
  }

  String getMyLossesCurMatchup()
  {
    return fantasyTeamSummary.currentMatchup.homeTeamSummary.teamId.toString() == widget.teamId ? fantasyTeamSummary.currentMatchup.homeTeamSummary.losses.toString() : fantasyTeamSummary.currentMatchup.awayTeamSummary.losses.toString();
  }

  String getOppLossesCurMatchup()
  {
    return fantasyTeamSummary.currentMatchup.homeTeamSummary.teamId.toString() == widget.teamId ? fantasyTeamSummary.currentMatchup.homeTeamSummary.losses.toString() : fantasyTeamSummary.currentMatchup.awayTeamSummary.losses.toString();
  }

  String getMyTiesCurMatchup()
  {
    return fantasyTeamSummary.currentMatchup.homeTeamSummary.teamId.toString() == widget.teamId ? fantasyTeamSummary.currentMatchup.homeTeamSummary.ties.toString() : fantasyTeamSummary.currentMatchup.awayTeamSummary.ties.toString();
  }

  String getOppTiesCurMatchup()
  {
    return fantasyTeamSummary.currentMatchup.homeTeamSummary.teamId.toString() == widget.teamId ? fantasyTeamSummary.currentMatchup.homeTeamSummary.ties.toString() : fantasyTeamSummary.currentMatchup.awayTeamSummary.ties.toString();
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

  Map<String, String> getTeamPerStatHittingGrades(List<HitterModel> hitterSummaries)
  {
    double overallPercentileSum     = 0.0;
    double percentileRunsSum        = 0.0;
    double percentileHomeRunsSum    = 0.0;
    double percentileRbisSum        = 0.0;
    double percentileStolenBasesSum = 0.0;
    double percentileObpSum         = 0.0;

    for (final hitter in hitterSummaries)
    {
      overallPercentileSum      += hitter.overallPercentile;
      percentileRunsSum         += hitter.overallPercentileRuns;
      percentileHomeRunsSum     += hitter.overallPercentileHomeRuns;
      percentileRbisSum         += hitter.overallPercentileRbis;
      percentileStolenBasesSum  += hitter.overallPercentileStolenBases;
      percentileObpSum          += hitter.overallPercentileObp;
    }

    double overallPercentileMean      = fantasyTeamSummary.hitterSummaries.isEmpty ? 0.0 : overallPercentileSum     / fantasyTeamSummary.hitterSummaries.length;
    double percentileRunsMean         = fantasyTeamSummary.hitterSummaries.isEmpty ? 0.0 : percentileRunsSum        / fantasyTeamSummary.hitterSummaries.length;
    double percentileHomeRunsMean     = fantasyTeamSummary.hitterSummaries.isEmpty ? 0.0 : percentileHomeRunsSum    / fantasyTeamSummary.hitterSummaries.length;
    double percentileRbisMean         = fantasyTeamSummary.hitterSummaries.isEmpty ? 0.0 : percentileRbisSum        / fantasyTeamSummary.hitterSummaries.length;
    double percentileStolenBasesMean  = fantasyTeamSummary.hitterSummaries.isEmpty ? 0.0 : percentileStolenBasesSum / fantasyTeamSummary.hitterSummaries.length;
    double percentileObpMean          = fantasyTeamSummary.hitterSummaries.isEmpty ? 0.0 : percentileObpSum         / fantasyTeamSummary.hitterSummaries.length;

    Map<String, String> statToGrade = {};

    statToGrade["overall" ] = getLetterGradeFromPercentile(overallPercentileMean);
    statToGrade["runs"    ] = getLetterGradeFromPercentile(percentileRunsMean);
    statToGrade["homeRuns"] = getLetterGradeFromPercentile(percentileHomeRunsMean);
    statToGrade["rbis"    ] = getLetterGradeFromPercentile(percentileRbisMean);
    statToGrade["sbs"     ] = getLetterGradeFromPercentile(percentileStolenBasesMean);
    statToGrade["obp"     ] = getLetterGradeFromPercentile(percentileObpMean);

    return statToGrade;
  }

  Map<String, String> getTeamPerStatStartingPitchingGrades(List<StartingPitcherSummary> startingPitcherSummaries)
  {
    double overallPercentileSum       = 0.0;
    double percentileQualityStartsSum = 0.0;
    double percentileEraSum           = 0.0;
    double percentileWhipSum          = 0.0;
    double percentileKsPerNineSum     = 0.0;

    for (final pitcher in startingPitcherSummaries)
    {
      overallPercentileSum        += pitcher.overallPercentile;
      percentileQualityStartsSum  += pitcher.overallPercentileQualityStarts;
      percentileEraSum            += pitcher.overallPercentileEra;
      percentileWhipSum           += pitcher.overallPercentileWhip;
      percentileKsPerNineSum      += pitcher.overallPercentileKsPerNine;
    }

    double overallPercentileMean          = fantasyTeamSummary.startingPitcherSummaries.isEmpty ? 0.0 : overallPercentileSum        / fantasyTeamSummary.startingPitcherSummaries.length;
    double overallPercentileQualityStarts = fantasyTeamSummary.startingPitcherSummaries.isEmpty ? 0.0 : percentileQualityStartsSum  / fantasyTeamSummary.startingPitcherSummaries.length;
    double overallPercentileEra           = fantasyTeamSummary.startingPitcherSummaries.isEmpty ? 0.0 : percentileEraSum            / fantasyTeamSummary.startingPitcherSummaries.length;
    double overallPercentileWhip          = fantasyTeamSummary.startingPitcherSummaries.isEmpty ? 0.0 : percentileWhipSum           / fantasyTeamSummary.startingPitcherSummaries.length;
    double overallPercentileKsPerNine     = fantasyTeamSummary.startingPitcherSummaries.isEmpty ? 0.0 : percentileKsPerNineSum      / fantasyTeamSummary.startingPitcherSummaries.length;

    Map<String, String> statToGrade = {};

    statToGrade["overall" ] = getLetterGradeFromPercentile(overallPercentileMean);
    statToGrade["qs"      ] = getLetterGradeFromPercentile(overallPercentileQualityStarts);
    statToGrade["era"     ] = getLetterGradeFromPercentile(overallPercentileEra);
    statToGrade["whip"    ] = getLetterGradeFromPercentile(overallPercentileWhip);
    statToGrade["ks"      ] = getLetterGradeFromPercentile(overallPercentileKsPerNine);

    return statToGrade;
  }

  Map<String, String> getTeamPerStatReliefPitchingGrade(List<ReliefPitcherSummary> reliefPitcherSummaries)
  {
    double overallPercentileSum       = 0.0;
    double percentileSavesAndHolds    = 0.0;
    double percentileEraSum           = 0.0;
    double percentileWhipSum          = 0.0;
    double percentileKsPerNineSum     = 0.0;


    for (final pitcher in reliefPitcherSummaries)
    {
      overallPercentileSum    += pitcher.overallPercentile;
      percentileSavesAndHolds += pitcher.overallPercentileSavesAndHolds;
      percentileEraSum        += pitcher.overallPercentileEra;
      percentileWhipSum       += pitcher.overallPercentileWhip;
      percentileKsPerNineSum  += pitcher.overallPercentileKsPerNine;
    }

    double overallPercentileMean        = fantasyTeamSummary.reliefPitcherSummaries.isEmpty ? 0.0 : overallPercentileSum    / fantasyTeamSummary.reliefPitcherSummaries.length;
    double percentileSavesAndHoldsMean  = fantasyTeamSummary.reliefPitcherSummaries.isEmpty ? 0.0 : percentileSavesAndHolds / fantasyTeamSummary.reliefPitcherSummaries.length;
    double percentileEraMean            = fantasyTeamSummary.reliefPitcherSummaries.isEmpty ? 0.0 : percentileEraSum        / fantasyTeamSummary.reliefPitcherSummaries.length;
    double percentileWhipMean           = fantasyTeamSummary.reliefPitcherSummaries.isEmpty ? 0.0 : percentileWhipSum       / fantasyTeamSummary.reliefPitcherSummaries.length;
    double percentileKsPerNineMean      = fantasyTeamSummary.reliefPitcherSummaries.isEmpty ? 0.0 : percentileKsPerNineSum  / fantasyTeamSummary.reliefPitcherSummaries.length;

    Map<String, String> statToGrade = {};

    statToGrade["overall" ] = getLetterGradeFromPercentile(overallPercentileMean);
    statToGrade["sh"      ] = getLetterGradeFromPercentile(percentileSavesAndHoldsMean);
    statToGrade["era"     ] = getLetterGradeFromPercentile(percentileEraMean);
    statToGrade["whip"    ] = getLetterGradeFromPercentile(percentileWhipMean);
    statToGrade["ks"      ] = getLetterGradeFromPercentile(percentileKsPerNineMean);

    return statToGrade;
  }
}
