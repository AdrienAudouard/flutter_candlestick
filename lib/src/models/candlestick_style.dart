import 'package:flutter/material.dart';

class CandlestickStyle {
  /// Color of the candlestick if the open value is greater than the close
  final Color bearishColor;

  /// Color of the candlestick if the close value is greater than the open
  final Color bullishColor;

  const CandlestickStyle({this.bearishColor = Colors.red, this.bullishColor = Colors.green});
}
