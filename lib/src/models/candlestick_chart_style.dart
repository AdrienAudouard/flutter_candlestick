import 'package:flutter/material.dart';
import 'package:flutter_simple_candlesticks/flutter_simple_candlesticks.dart';

class CandlestickChartStyle {
  /// Color of each candlesticks
  final CandlestickStyle candlestickStyle;

  /// Color of a selected (long press) candlestick
  final CandlestickStyle candlestickSelectedStyle;

  /// Style of the y legend
  final CandlestickChartYLegendStyle yLegendStyle;

  final Color tooltipColor;

  const CandlestickChartStyle(
      {this.candlestickStyle = const CandlestickStyle(),
      this.candlestickSelectedStyle = const CandlestickStyle(),
      this.yLegendStyle = const CandlestickChartYLegendStyle(),
      this.tooltipColor = const Color(0xFF0b112e)});
}
