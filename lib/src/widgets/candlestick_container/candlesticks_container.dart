import 'package:flutter/material.dart';
import 'package:flutter_simple_candlesticks/src/models/candlestick.dart';
import 'package:flutter_simple_candlesticks/src/models/hight_and_low.dart';
import 'package:flutter_simple_candlesticks/src/widgets/candlestick_widget/candlestick_widget.dart';

typedef CandlestickBuilder = CandlestickWidget Function(Candlestick, num, num);

abstract class CandlesticksContainer extends StatefulWidget {
  final CandlestickBuilder candlestickBuilder;
  final List<Candlestick> candlesticks;
  final Function(HightAndLow) onHightAndLowChange;

  const CandlesticksContainer(
      {required this.candlestickBuilder, required this.candlesticks, required this.onHightAndLowChange});
}
