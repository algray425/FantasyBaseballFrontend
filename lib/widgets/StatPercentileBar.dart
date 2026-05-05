import 'package:flutter/material.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';

class StatPercentileBar extends StatelessWidget
{
  final String statName;
  final double? percentile;

  const StatPercentileBar({super.key, required this.statName, required this.percentile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                alignment: Alignment.center,
                child: Text(
                  statName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              )
            )
          ],
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LinearPercentIndicator(
                width: 340.0,
                lineHeight: 18.0,
                barRadius: const Radius.circular(10.0),
                percent: getConvertedPercentile(percentile),
                backgroundColor: Colors.grey,
                progressColor: getProgressColor(percentile),
                center: Text(
                  percentile!.toStringAsFixed(2),
                  style: TextStyle(fontSize: 12.0),
                ),
              )
            ]
        )
      ],
    );
  }

  Color getProgressColor(double? percentile)
  {
    if (percentile == null || percentile <= 33.3)
    {
      return Colors.redAccent;
    }
    else if (percentile <= 66.6)
    {
      return Colors.yellowAccent;
    }
    else
    {
      return Colors.greenAccent;
    }
  }

  double getConvertedPercentile(double? percentile)
  {
    if (percentile == null)
    {
      return 0.0;
    }

    return percentile / 100.0;
  }
}