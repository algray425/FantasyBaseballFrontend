import 'package:fantasy_baseball_app/model/CurrentMatchup.dart';
import 'package:fantasy_baseball_app/model/ReliefPitcherSummary.dart';
import 'package:fantasy_baseball_app/model/StartingPitcherSummary.dart';

import 'HitterModel.dart';

class FantasyTeamSummary
{
  final List<HitterModel>             hitterSummaries;
  final List<StartingPitcherSummary>  startingPitcherSummaries;
  final List<ReliefPitcherSummary>    reliefPitcherSummaries;

  final CurrentMatchup                currentMatchup;

  final List<HitterModel>             upcomingMatchupHitterSummaries;
  final List<StartingPitcherSummary>  upcomingMatchupStartingPitcherSummaries;
  final List<ReliefPitcherSummary>    upcomingMatchupReliefPitcherSummaries;

  final List<HitterModel>             bestAvailableHitters;
  final List<StartingPitcherSummary>  bestAvailableStartingPitchers;
  final List<ReliefPitcherSummary>    bestAvailableReliefPitchers;

  const FantasyTeamSummary({required this.hitterSummaries, required this.startingPitcherSummaries, required this.reliefPitcherSummaries,
  required this.currentMatchup, required this.upcomingMatchupHitterSummaries, required this.upcomingMatchupStartingPitcherSummaries,
    required this .upcomingMatchupReliefPitcherSummaries, required this.bestAvailableHitters, required this.bestAvailableStartingPitchers,
    required this.bestAvailableReliefPitchers});

  factory FantasyTeamSummary.fromJson(Map<String, dynamic> json)
  {
    List<HitterModel            > teamHitters           = [];
    List<StartingPitcherSummary > teamStartingPitchers  = [];
    List<ReliefPitcherSummary   > teamReliefPitchers    = [];

    List<dynamic> rosterGrades = json['rosterGrades'];

    for (final grade in rosterGrades)
    {
      String type                 = grade["type"                ];
      String id                   = grade["playerId"            ];
      String firstName            = grade["firstName"           ];
      String lastName             = grade["lastName"            ];
      String team                 = grade["currentTeam"         ];
      double percentileOverall    = grade["percentileOverall"   ];
      double percentileQualified  = grade["percentileQualified" ];

      if (type == "com.advanced_baseball_stats.v2.model.batters.Fantasy.FantasyPlayerSummaryBatting")
      {
        String position                       = grade["currentPosition"                   ];
        double  percentileOverallRuns         = grade["percentileOverallRuns"             ];
        double  percentileOverallHomeRuns     = grade["percentileOverallHomeRuns"         ];
        double  percentileOverallRbis         = grade["percentileOverallRbis"             ];
        double  percentileOverallStolenBases  = grade["percentileOverallStolenBases"      ];
        double  percentileOverallObp          = grade["percentileOverallOnBasePercentage" ];
        int     runs                          = grade["runs"                              ];
        int     homeRuns                      = grade["homeRuns"                          ];
        int     rbis                          = grade["rbis"                              ];
        int     stolenBases                   = grade["stolenBases"                       ];
        double  obp                           = grade["onBasePercentage"                  ];

        teamHitters.add(HitterModel(id: id, name: "$firstName $lastName", team: team, position: position, overallPercentile: percentileOverall, runs: runs,
            homeRuns: homeRuns, rbis: rbis, stolenBases: stolenBases, obp: obp, overallPercentileRuns: percentileOverallRuns, overallPercentileHomeRuns: percentileOverallHomeRuns,
            overallPercentileRbis: percentileOverallRbis, overallPercentileStolenBases: percentileOverallStolenBases, overallPercentileObp: percentileOverallObp
        ));
      }
      else if(type == "com.advanced_baseball_stats.v2.model.batters.Fantasy.FantasyPlayerSummaryStartingPitching")
      {
        int qualityStarts                       = grade["qualityStarts"                 ];
        double era                              = grade["era"                           ];
        double whip                             = grade["whip"                          ];
        double ksPerNine                        = grade["ksPerNine"                     ];
        double percentileOverallQualityStarts   = grade["percentileOverallQualityStarts"];
        double percentileOverallEra             = grade["percentileOverallEra"          ];
        double percentileOverallWhip            = grade["percentileOverallWhip"         ];
        double percentileOverallKsPerNine       = grade["percentileOverallKsPerNine"    ];

        StartingPitcherSummary pitcher = StartingPitcherSummary(id: id, name: "$firstName $lastName", team: team, overallPercentile: percentileOverall, qualityStarts: qualityStarts, era: era, whip: whip, ksPerNine: ksPerNine);

        pitcher.overallPercentileQualityStarts  = percentileOverallQualityStarts;
        pitcher.overallPercentileEra            = percentileOverallEra;
        pitcher.overallPercentileWhip           = percentileOverallWhip;
        pitcher.overallPercentileKsPerNine      = percentileOverallKsPerNine;

        teamStartingPitchers.add(pitcher);
      }
      else if (type == "com.advanced_baseball_stats.v2.model.batters.Fantasy.FantasyPlayerSummaryReliefPitching")
      {
        int saves                               = grade["saves"         ];
        int holds                               = grade["holds"         ];
        double era                              = grade["era"           ];
        double whip                             = grade["whip"          ];
        double ksPerNine                        = grade["ksPerNine"     ];
        double percentileOverallSavesAndHolds   = grade["percentileOverallSaveAndHolds"];
        double percentileOverallEra             = grade["percentileOverallEra"          ];
        double percentileOverallWhip            = grade["percentileOverallWhip"         ];
        double percentileOverallKsPerNine       = grade["percentileOverallKsPerNine"    ];

        ReliefPitcherSummary pitcher = ReliefPitcherSummary(id: id, name: "$firstName $lastName", team: team, overallPercentile: percentileOverall, saves: saves, holds: holds, era: era, whip: whip, ksPerNine: ksPerNine);
        pitcher.overallPercentileSavesAndHolds  = percentileOverallSavesAndHolds;
        pitcher.overallPercentileEra            = percentileOverallEra;
        pitcher.overallPercentileWhip           = percentileOverallWhip;
        pitcher.overallPercentileKsPerNine      = percentileOverallKsPerNine;

        teamReliefPitchers.add(pitcher);
      }
    }

    Map<String, dynamic> currentMatchupJson = json["currentMatchup"];

    CurrentMatchup currentMatchup = CurrentMatchup.fromJson(currentMatchupJson);

    List<dynamic> upcomingOpponentRosterGrades = json["upcomingOpponent"];

    List<HitterModel            > upcomingOpponentHitters           = [];
    List<StartingPitcherSummary > upcomingOpponentStartingPitchers  = [];
    List<ReliefPitcherSummary   > upcomingOpponentReliefPitchers    = [];

    for (final opponentGrade in upcomingOpponentRosterGrades)
    {
      String type                 = opponentGrade["type"                ];
      String id                   = opponentGrade["playerId"            ];
      String firstName            = opponentGrade["firstName"           ];
      String lastName             = opponentGrade["lastName"            ];
      String team                 = opponentGrade["currentTeam"         ];
      double percentileOverall    = opponentGrade["percentileOverall"   ];
      double percentileQualified  = opponentGrade["percentileQualified" ];

      if (type == "com.advanced_baseball_stats.v2.model.batters.Fantasy.FantasyPlayerSummaryBatting")
      {
        String position                       = opponentGrade["currentPosition"                   ];
        double  percentileOverallRuns         = opponentGrade["percentileOverallRuns"             ];
        double  percentileOverallHomeRuns     = opponentGrade["percentileOverallHomeRuns"         ];
        double  percentileOverallRbis         = opponentGrade["percentileOverallRbis"             ];
        double  percentileOverallStolenBases  = opponentGrade["percentileOverallStolenBases"      ];
        double  percentileOverallObp          = opponentGrade["percentileOverallOnBasePercentage" ];
        int     runs                          = opponentGrade["runs"                              ];
        int     homeRuns                      = opponentGrade["homeRuns"                          ];
        int     rbis                          = opponentGrade["rbis"                              ];
        int     stolenBases                   = opponentGrade["stolenBases"                       ];
        double  obp                           = opponentGrade["onBasePercentage"                  ];

        upcomingOpponentHitters.add(HitterModel(id: id, name: "$firstName $lastName", team: team, position: position, overallPercentile: percentileOverall, runs: runs,
            homeRuns: homeRuns, rbis: rbis, stolenBases: stolenBases, obp: obp, overallPercentileRuns: percentileOverallRuns, overallPercentileHomeRuns: percentileOverallHomeRuns,
            overallPercentileRbis: percentileOverallRbis, overallPercentileStolenBases: percentileOverallStolenBases, overallPercentileObp: percentileOverallObp
        ));
      }
      else if(type == "com.advanced_baseball_stats.v2.model.batters.Fantasy.FantasyPlayerSummaryStartingPitching")
      {
        int qualityStarts                       = opponentGrade["qualityStarts"                 ];
        double era                              = opponentGrade["era"                           ];
        double whip                             = opponentGrade["whip"                          ];
        double ksPerNine                        = opponentGrade["ksPerNine"                     ];
        double percentileOverallQualityStarts   = opponentGrade["percentileOverallQualityStarts"];
        double percentileOverallEra             = opponentGrade["percentileOverallEra"          ];
        double percentileOverallWhip            = opponentGrade["percentileOverallWhip"         ];
        double percentileOverallKsPerNine       = opponentGrade["percentileOverallKsPerNine"    ];

        StartingPitcherSummary pitcher = StartingPitcherSummary(id: id, name: "$firstName $lastName", team: team, overallPercentile: percentileOverall, qualityStarts: qualityStarts, era: era, whip: whip, ksPerNine: ksPerNine);

        pitcher.overallPercentileQualityStarts  = percentileOverallQualityStarts;
        pitcher.overallPercentileEra            = percentileOverallEra;
        pitcher.overallPercentileWhip           = percentileOverallWhip;
        pitcher.overallPercentileKsPerNine      = percentileOverallKsPerNine;

        upcomingOpponentStartingPitchers.add(pitcher);
      }
      else if (type == "com.advanced_baseball_stats.v2.model.batters.Fantasy.FantasyPlayerSummaryReliefPitching")
      {
        int saves                               = opponentGrade["saves"         ];
        int holds                               = opponentGrade["holds"         ];
        double era                              = opponentGrade["era"           ];
        double whip                             = opponentGrade["whip"          ];
        double ksPerNine                        = opponentGrade["ksPerNine"     ];
        double percentileOverallSavesAndHolds   = opponentGrade["percentileOverallSaveAndHolds"];
        double percentileOverallEra             = opponentGrade["percentileOverallEra"          ];
        double percentileOverallWhip            = opponentGrade["percentileOverallWhip"         ];
        double percentileOverallKsPerNine       = opponentGrade["percentileOverallKsPerNine"    ];

        ReliefPitcherSummary pitcher = ReliefPitcherSummary(id: id, name: "$firstName $lastName", team: team, overallPercentile: percentileOverall, saves: saves, holds: holds, era: era, whip: whip, ksPerNine: ksPerNine);

        pitcher.overallPercentileSavesAndHolds  = percentileOverallSavesAndHolds;
        pitcher.overallPercentileEra            = percentileOverallEra;
        pitcher.overallPercentileWhip           = percentileOverallWhip;
        pitcher.overallPercentileKsPerNine      = percentileOverallKsPerNine;

        upcomingOpponentReliefPitchers.add(pitcher);
      }
    }

    List<HitterModel> bestAvailableHitters = [];

    List<dynamic> availableHitters = json["bestAvailableHitters"];

    for (final hitter in availableHitters)
    {
      String id                   = hitter["playerId"         ];
      String firstName            = hitter["firstName"        ];
      String lastName             = hitter["lastName"         ];
      String team                 = hitter["team"             ];
      String position             = hitter["position"         ];
      double percentileOverall    = hitter["grade"            ];
      int     runs                = hitter["runs"             ];
      int     homeRuns            = hitter["homeRuns"         ];
      int     rbis                = hitter["rbis"             ];
      int     stolenBases         = hitter["stolenBases"      ];
      double  obp                 = hitter["onBasePercentage" ];

      bestAvailableHitters.add(HitterModel(id: id, name: "$firstName $lastName", team: team, position: position, overallPercentile: percentileOverall, runs: runs, homeRuns: homeRuns, rbis: rbis, stolenBases: stolenBases, obp: obp));
    }

    List<StartingPitcherSummary > bestAvailableStartingPitchers = [];

    List<dynamic> availableStartingPitchers = json["bestAvailableStartingPitchers"];

    for (final pitcher in availableStartingPitchers)
    {
      String  id                    = pitcher["playerId"      ];
      String  firstName             = pitcher["firstName"     ];
      String  lastName              = pitcher["lastName"      ];
      double  percentileOverall     = pitcher["grade"         ];
      int     qualityStarts         = pitcher["qualityStarts" ];
      double  era                   = pitcher["era"           ];
      double  whip                  = pitcher["whip"          ];
      double  ksPerNine             = pitcher["ksPerNine"     ];

      bestAvailableStartingPitchers.add(StartingPitcherSummary(id: id, name: "$firstName $lastName", team: "n/a", overallPercentile: percentileOverall, qualityStarts: qualityStarts, era: era, whip: whip, ksPerNine: ksPerNine));
    }

    List<ReliefPitcherSummary> bestAvailableReliefPitchers = [];

    List<dynamic> availableReliefPitchers = json["bestAvailableReliefPitchers"];

    for (final pitcher in availableReliefPitchers)
    {
      String  id                    = pitcher["playerId"      ];
      String  firstName             = pitcher["firstName"     ];
      String  lastName              = pitcher["lastName"      ];
      double  percentileOverall     = pitcher["grade"         ];
      int     saves                 = pitcher["saves"         ];
      int     holds                 = pitcher["holds"         ];
      double  era                   = pitcher["era"           ];
      double  whip                  = pitcher["whip"          ];
      double  ksPerNine             = pitcher["ksPerNine"     ];

      bestAvailableReliefPitchers.add(ReliefPitcherSummary(id: id, name: "$firstName $lastName", team: "n/a", overallPercentile: percentileOverall, saves: saves, holds: holds, era: era, whip: whip, ksPerNine: ksPerNine));
    }


    return FantasyTeamSummary(hitterSummaries: teamHitters, currentMatchup: currentMatchup, startingPitcherSummaries: teamStartingPitchers,
        upcomingMatchupHitterSummaries: upcomingOpponentHitters, upcomingMatchupStartingPitcherSummaries: upcomingOpponentStartingPitchers,
        upcomingMatchupReliefPitcherSummaries: upcomingOpponentReliefPitchers, reliefPitcherSummaries: teamReliefPitchers,
        bestAvailableHitters: bestAvailableHitters, bestAvailableStartingPitchers: bestAvailableStartingPitchers,
        bestAvailableReliefPitchers: bestAvailableReliefPitchers);
  }
}