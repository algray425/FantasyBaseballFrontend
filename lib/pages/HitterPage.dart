import 'package:flutter/material.dart';

import 'package:fantasy_baseball_app/widgets/HeaderBar.dart';
import 'package:fantasy_baseball_app/widgets/HitterPageHeader.dart';
import 'package:fantasy_baseball_app/widgets/NavigationDrawer.dart';

class HitterPage extends StatelessWidget
{
  static const simpleRouteName = '/hitter/';
  static const routeName = '/hitter/:id';

  final String id;

  const HitterPage({super.key, required this.id});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: HeaderBar(title: "Hitter Stats"),
      drawer: Drawer(
          child: NavigationList()
      ),
      body: SingleChildScrollView(scrollDirection: Axis.vertical, child: HitterPageHeader(id: id))
    );
  }
}