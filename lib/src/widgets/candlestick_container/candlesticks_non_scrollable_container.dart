import 'package:flutter/material.dart';
import 'package:flutter_simple_candlesticks/src/models/candlestick.dart';
import 'package:flutter_simple_candlesticks/src/models/hight_and_low.dart';
import 'package:flutter_simple_candlesticks/src/utils/candlesticks_utils.dart';
import 'package:flutter_simple_candlesticks/src/widgets/candlestick_container/candlesticks_container.dart';

class CandlesticksNonScrollableContainer extends CandlesticksContainer {
  const CandlesticksNonScrollableContainer(
      {required CandlestickBuilder candlestickBuilder,
      required List<Candlestick> candlesticks,
      required Function(HightAndLow) onHightAndLowChange})
      : super(
            candlestickBuilder: candlestickBuilder,
            candlesticks: candlesticks,
            onHightAndLowChange: onHightAndLowChange);

  @override
  State<CandlesticksNonScrollableContainer> createState() => _CandlesticksNonScrollableContainer();
}

class _CandlesticksNonScrollableContainer extends State<CandlesticksNonScrollableContainer> {
  late final num allTimeHight;
  late final num allTimeLow;

  @override
  void initState() {
    allTimeHight = CandlesticksUtils.getAllTimeHight(widget.candlesticks);
    allTimeLow = CandlesticksUtils.getAllTimeLow(widget.candlesticks);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [...widget.candlesticks.map(_mapCandleToWidget)],
    );
  }

  Widget _mapCandleToWidget(Candlestick candlestick) {
    return Expanded(child: widget.candlestickBuilder(candlestick, allTimeHight, allTimeLow), flex: 1);
  }
}
