import 'package:fantasy_baseball_app/notifiers/FavoritePlayersModel.dart';
import 'package:fantasy_baseball_app/widgets/UserTeamsList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/FavoritePlayerList.dart';
import '../widgets/HeaderBar.dart';
import '../widgets/NavigationDrawer.dart';

class ProfilePage extends StatelessWidget
{
  static const routeName = "/profile";

  final String userId;

  const ProfilePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        appBar: HeaderBar(title: "Profile"),
        drawer: Drawer(
            child: NavigationList()
        ),
        body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                            alignment: Alignment.center,
                            child: Text(
                              "Fantasy Teams",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0
                              ),
                            )
                          ))
                      ],
                    ),
                    UserTeamsList(userId: userId),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 40, 10, 20),
                            alignment: Alignment.center,
                            child: Text(
                              "Favorite Players",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0
                              ),
                            )
                          ))
                      ],
                    ),
                    Consumer<FavoritePlayersModel>(
                      builder: (context, favoritePlayersModel, child)
                      {
                        return FavoritePlayerList();
                      }
                    )
                  ]
                )
        )
    );
  }
}