import 'package:flutter/material.dart';

import 'package:fantasy_baseball_app/model/HittingStat.dart';

class HitterListHeader extends StatefulWidget
{
  final String                      text;
  final HittingStat                 hittingStat;
  final void Function(HittingStat)  callback;

  const HitterListHeader({super.key, required this.text, required this.hittingStat, required this.callback});

  @override
  HitterListHeaderState createState() => HitterListHeaderState();
}

class HitterListHeaderState extends State<HitterListHeader>
{
  bool showSortArrow = false;

  @override
  Widget build(BuildContext context)
  {
    return Expanded(child: InkWell(
      hoverColor: Colors.grey.withValues(alpha: 0.15),
      onTap: ()
      {
        widget.callback(widget.hittingStat);
      },
      onHover: (isHovering)
      {
        setState(() {
          showSortArrow = isHovering;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
        Center(child: Text(widget.text)),
        if (showSortArrow)...[
          Center(child: Icon(Icons.compare_arrows_outlined))
        ]
      ])
    ));
  }
}