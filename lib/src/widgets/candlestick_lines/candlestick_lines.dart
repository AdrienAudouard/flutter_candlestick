import 'package:flutter/material.dart';
import 'package:flutter_candlesticks/src/models/candlestick_chart_line_style.dart';
import 'package:flutter_candlesticks/src/widgets/candlestick_lines/candlesticks_lines_painter.dart';

class CandlestickLines extends StatelessWidget {
  final num allTimeHight;
  final num allTimeLow;
  final List<num> legendValues;
  final CandlestickChartLineStyle lineStyle;

  const CandlestickLines(
      {required this.allTimeHight,
      required this.allTimeLow,
      required this.legendValues,
      required this.lineStyle,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: CandlestickLinesPainter(
            allTimeHight: allTimeHight, allTimeLow: allTimeLow, legendValues: legendValues, lineStyle: lineStyle),
      ),
    );
  }
}
