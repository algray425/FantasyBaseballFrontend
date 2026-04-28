import 'package:flutter/material.dart';

import 'package:fantasy_baseball_app/widgets/HeaderBar.dart';
import 'package:fantasy_baseball_app/widgets/NavigationDrawer.dart';
import 'package:provider/provider.dart';

import '../notifiers/AuthorizationModel.dart';
import '../widgets/LoginPanel.dart';

class LoginPage extends StatelessWidget
{
  static const routeName = "/login";

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: HeaderBar(title: "Hitter Rankings"),
      drawer: Drawer(
          child: NavigationList()
      ),
      body: Consumer<AuthorizationModel>(
        builder: (context, authorizationModel, child)
        {
          return LoginPanel();
        }
      )
    );
  }
}