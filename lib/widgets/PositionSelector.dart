import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fantasy_baseball_app/model/PageType.dart';
import 'package:fantasy_baseball_app/notifiers/HitterListModel.dart';
import 'package:fantasy_baseball_app/notifiers/HitterProjectionsModel.dart';

class PositionSelector extends StatefulWidget
{
  final List<String>          positions = ["All", "OF", "1B", "2B", "SS", "3B", "C", "DH", "TWP"];
  final PageType              pageType;
  final void Function(String) callback;

  PositionSelector({super.key, required this.pageType, required this.callback});

  @override
  PositionSelectorState createState() => PositionSelectorState();
}

class PositionSelectorState extends State<PositionSelector>
{
  String selectedPosition = "All";

  @override
  Widget build(BuildContext context)
  {
   String modelPosition = "All";

   if (widget.pageType == PageType.HITTER_RANKINGS)
   {
     modelPosition = context.read<HitterListModel>().getPosition();
   }
   else if (widget.pageType == PageType.HITTER_PROJECTIONS)
   {
     modelPosition = context.read<HitterProjectionsModel>().getPosition();
   }

    return DropdownButton(
      value: modelPosition,
      items: widget.positions.map((String position){
        return DropdownMenuItem(value: position, child: Text(position));
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedPosition = newValue!;

          widget.callback(selectedPosition);
        });
      },
    );
  }
}