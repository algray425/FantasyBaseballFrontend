import 'package:flutter/material.dart';

class DateRangeSelector extends StatefulWidget
{
  final void Function(({String startDate, String endDate})) callback;

  const DateRangeSelector({super.key, required this.callback});

  @override
  DateRangeSelectorState createState() => DateRangeSelectorState();
}

class DateRangeSelectorState extends State<DateRangeSelector>
{
  String startDate = "";
  String endDate   = "";

  Color unhoveredButtonColor = Colors.green;
  Color hoveredButtonColor = Colors.green.withValues(alpha: 0.8);

  Color currentButtonColor = Colors.green;

  @override
  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children:[
        Container(
          margin: EdgeInsets.fromLTRB(20, 0, 0, 15),
          width: 150,
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Start Date',
            ),
            onChanged: (String? text)
            {
              startDate = text!;
            },
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 0, 0, 15),
          width: 150,
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'End Date',
            ),
            onChanged: (String? text)
            {
              endDate = text!;
            },
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 10, 0, 15),
          width: 100,
          height: 50,
          decoration: BoxDecoration(
              color: currentButtonColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 5),
                )
              ]
          ),
          child: InkWell(
            onHover: (bool? isHovering)
            {
              setState(() {
                currentButtonColor = isHovering! ? hoveredButtonColor : unhoveredButtonColor;
              });
            },
            onTap: (){
              widget.callback((startDate: startDate, endDate: endDate));
            },
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: Center(child: Text("Update Dates")),
          ),
        ),
      ]
    );
  }
}