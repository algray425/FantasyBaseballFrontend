import 'package:flutter/material.dart';

import 'package:fantasy_baseball_app/model/PitchingStat.dart';

class PitcherListHeader extends StatefulWidget
{
  final String                        text;
  final PitchingStat                  pitchingStat;
  final void Function(PitchingStat)   callback;

  const PitcherListHeader({super.key, required this.text, required this.pitchingStat, required this.callback});

  @override
  PitcherListHeaderState createState() => PitcherListHeaderState();
}

class PitcherListHeaderState extends State<PitcherListHeader>
{
  bool showSortArrow = false;

  @override
  Widget build(BuildContext context)
  {
    return Expanded(child: InkWell(
        hoverColor: Colors.grey.withValues(alpha: 0.15),
        onTap: ()
        {
          widget.callback(widget.pitchingStat);
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