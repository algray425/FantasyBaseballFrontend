import 'package:flutter/material.dart';

import 'package:fantasy_baseball_app/widgets/HeaderBar.dart';
import 'package:fantasy_baseball_app/widgets/NavigationDrawer.dart';
import 'package:fantasy_baseball_app/widgets/PitcherSummaryBody.dart';

class PitcherPage extends StatelessWidget
{
  static const simpleRouteName  = '/pitcher/';
  static const routeName        = '/pitcher/:id';

  final String id;

  const PitcherPage({super.key, required this.id});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: HeaderBar(title: "Pitcher Stats"),
      drawer: Drawer(
        child: NavigationList()
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: PitcherSummaryBody(id: id)
      )
    );
  }
}