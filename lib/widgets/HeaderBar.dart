import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/LoginPage.dart';

class HeaderBar extends StatelessWidget implements PreferredSizeWidget
{
  final String title;

  const HeaderBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.lightBlue,
      actions: [
        IconButton(onPressed: (){
          context.go(LoginPage.routeName);
        },
        icon: Icon(Icons.account_circle_outlined))
      ],
    );
  }

  @override
  // Defines the preferred height of the AppBar
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}