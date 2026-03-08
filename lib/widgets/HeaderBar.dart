import 'package:flutter/material.dart';

class HeaderBar extends StatelessWidget implements PreferredSizeWidget
{
  final String title;

  const HeaderBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.lightBlue
    );
  }

  @override
  // Defines the preferred height of the AppBar
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}