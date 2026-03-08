import 'package:fantasy_baseball_app/pages/ReliefPitcherRankingsPage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:fantasy_baseball_app/pages/HitterProjectionsPage.dart';
import 'package:fantasy_baseball_app/pages/HitterRankingsPage.dart';
import 'package:fantasy_baseball_app/pages/ProfilePage.dart';
import 'package:fantasy_baseball_app/pages/StartingPitcherRankingsPage.dart';

class NavigationList extends StatelessWidget
{
  const NavigationList({super.key});

  @override
  Widget build(BuildContext context)
  {
    return ListView(
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.lightBlue,
          ),
          child: Text('Navigation'),
        ),
        ListTile(
          title: const Text('Profile'),
          onTap: () {
            context.go(ProfilePage.routeName);
          },
        ),
        ListTile(
          title: const Text('Hitter Rankings'),
          onTap: () {
            context.go(HitterRankingsPage.routeName);
          },
        ),
        ListTile(
          title: const Text('Hitter Projections'),
          onTap: () {
            context.go(HitterProjectionsPage.routeName);
          },
        ),
        ListTile(
          title: const Text('Starting Pitcher Rankings'),
          onTap: () {
            context.go(StartingPitcherRankingsPage.routeName);
          },
        ),
        ListTile(
          title: const Text('Relief Pitcher Rankings'),
          onTap: () {
            context.go(ReliefPitcherRankingsPage.routeName);
          },
        ),
      ]
    );
  }
}