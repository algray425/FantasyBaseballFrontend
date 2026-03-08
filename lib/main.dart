
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:fantasy_baseball_app/notifiers/StartingPitcherRankingListModel.dart';
import 'package:fantasy_baseball_app/notifiers/FavoritePlayersModel.dart';
import 'package:fantasy_baseball_app/pages/HitterRankingsPage.dart';
import 'package:fantasy_baseball_app/pages/FantasyTeamHomePage.dart';
import 'package:fantasy_baseball_app/pages/HitterPage.dart';
import 'package:fantasy_baseball_app/pages/HitterProjectionsPage.dart';
import 'package:fantasy_baseball_app/pages/ProfilePage.dart';
import 'package:fantasy_baseball_app/pages/StartingPitcherRankingsPage.dart';
import 'package:fantasy_baseball_app/pages/PitcherPage.dart';
import 'package:fantasy_baseball_app/pages/ReliefPitcherRankingsPage.dart';

void main()
{
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => FavoritePlayersModel()),
          ChangeNotifierProvider(create: (context) => StartingPitcherRankingListModel())
        ],
        child: MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter router = GoRouter(
    initialLocation: HitterRankingsPage.routeName,
    routes: [
      GoRoute(
        path: HitterRankingsPage.routeName,
        builder: (context, state) => HitterRankingsPage(),
      ),
      GoRoute(
        path: HitterProjectionsPage.routeName,
        builder: (context, state) => HitterProjectionsPage(),
      ),
      GoRoute(
        path: HitterPage.routeName,
        builder: (context, state)
        {
          final id = state.pathParameters['id'];
          return HitterPage(id: id!);
        }
      ),
      GoRoute(
        path: StartingPitcherRankingsPage.routeName,
        builder: (context, state) => StartingPitcherRankingsPage(),
      ),
      GoRoute(
        path: ReliefPitcherRankingsPage.routeName,
        builder: (context, state) => ReliefPitcherRankingsPage(),
      ),
      GoRoute(
          path: PitcherPage.routeName,
          builder: (context, state)
          {
            final id = state.pathParameters['id'];
            return PitcherPage(id: id!);
          }
      ),
      GoRoute(
          path: ProfilePage.routeName,
          builder: (context, state) => ProfilePage(userId: "1"),
      ),
      GoRoute(
        path: FantasyTeamHomePage.routeName,
        builder: (context, state)
        {
          final leagueType  = state.pathParameters['leagueType']!;
          final leagueId    = state.pathParameters['leagueId']!;
          final teamId      = state.pathParameters['teamId']!;
          final userId      = state.pathParameters['userId']!;

          return FantasyTeamHomePage(leagueType: leagueType, leagueId: leagueId, teamId: teamId, userId: userId);
        }
      ),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router
    );
  }
}
