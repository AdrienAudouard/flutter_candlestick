import 'package:flutter/cupertino.dart';
import 'package:flutter_candlesticks/src/models/candlestick_chart_line_style.dart';

class CandlestickChartYLegendStyle {
  /// Text style of the y legend text
  final TextStyle? textStyle;

  /// Number of digits displayed
  final int? fractionDigits;

  /// If the style is not provided the lines are not displayed
  final CandlestickChartLineStyle? lineStyle;

  /// Number of legend you want to display
  final int numberOfLabels;

  const CandlestickChartYLegendStyle(
      {this.textStyle, this.lineStyle, this.numberOfLabels = 2, this.fractionDigits = 2});
}
