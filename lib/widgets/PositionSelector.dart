import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PositionSelector extends StatefulWidget
{
  final List<String>          positions = ["All", "OF", "1B", "2B", "SS", "3B", "C", "DH", "TWP"];
  final void Function(String) callback;

  PositionSelector({super.key, required this.callback});

  @override
  PositionSelectorState createState() => PositionSelectorState();
}

//TODO: For these maybe add a callback to update the specific provider so they are more re-usable
class PositionSelectorState extends State<PositionSelector>
{
  String selectedPosition = "All";

  @override
  Widget build(BuildContext context)
  {
    return DropdownButton(
      value: selectedPosition,
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