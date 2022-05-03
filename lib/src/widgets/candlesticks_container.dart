import 'package:flutter/material.dart';
import 'package:flutter_candlesticks/src/models/candlestick.dart';
import 'package:flutter_candlesticks/src/widgets/candlestick_widget/candlestick_widget.dart';

typedef CandlestickBuilder = CandlestickWidget Function(Candlestick, num, num);

abstract class CandlesticksContainer extends StatefulWidget {
  final CandlestickBuilder candlestickBuilder;
  final List<Candlestick> candlesticks;

  const CandlesticksContainer({required this.candlestickBuilder, required this.candlesticks});
}
