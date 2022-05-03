import 'package:flutter/material.dart';
import 'package:flutter_candlesticks/src/models/candlestick_chart_y_legend_style.dart';
import 'package:flutter_candlesticks/src/models/candlestick_style.dart';

class CandlestickChartStyle {
  final CandlestickStyle candlestickStyle;
  final CandlestickStyle candlestickSelectedStyle;
  final CandlestickChartYLegendStyle yLegendStyle;
  final int? fractionDigits;
  final Color tooltipColor;

  const CandlestickChartStyle(
      {this.candlestickStyle = const CandlestickStyle(),
      this.candlestickSelectedStyle = const CandlestickStyle(),
      this.yLegendStyle = const CandlestickChartYLegendStyle(),
      this.tooltipColor = const Color(0xFF0b112e),
      this.fractionDigits = 2});
}
