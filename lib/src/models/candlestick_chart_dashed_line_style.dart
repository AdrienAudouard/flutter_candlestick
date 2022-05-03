import 'package:flutter/material.dart';
import 'package:flutter_simple_candlesticks/flutter_simple_candlesticks.dart';

class CandlestickChartDashedLineStyle extends CandlestickChartLineStyle {
  /// Dash width
  final double dashWidth;

  /// Space between each dash
  final double dashSpace;

  const CandlestickChartDashedLineStyle(
      {required double width, required Color color, this.dashWidth = 4, this.dashSpace = 4})
      : super(width: width, color: color);
}
