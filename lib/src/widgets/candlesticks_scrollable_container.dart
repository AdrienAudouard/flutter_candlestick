import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_simple_candlesticks/src/models/candlestick.dart';
import 'package:flutter_simple_candlesticks/src/utils/candlesticks_utils.dart';
import 'package:flutter_simple_candlesticks/src/widgets/candlesticks_container.dart';

class CandlesticksScrollableContainer extends CandlesticksContainer {
  const CandlesticksScrollableContainer(
      {required CandlestickBuilder candlestickBuilder, required List<Candlestick> candlesticks})
      : super(candlestickBuilder: candlestickBuilder, candlesticks: candlesticks);

  @override
  State<CandlesticksScrollableContainer> createState() => _CandlesticksScrollableContainerState();
}

class _CandlesticksScrollableContainerState extends State<CandlesticksScrollableContainer> {
  final _hightAndLow = ValueNotifier(const _HightAndLow(hight: 0, low: 0));
  late final ScrollController _scrollController;
  late final double _candlestickWidth = 50;

  double _widgetWidth = 0;

  @override
  void initState() {
    final allTimeHight = CandlesticksUtils.getAllTimeHight(widget.candlesticks);
    final allTimeLow = CandlesticksUtils.getAllTimeLow(widget.candlesticks);
    _hightAndLow.value = _HightAndLow(hight: allTimeHight, low: allTimeLow);

    _scrollController = ScrollController(initialScrollOffset: widget.candlesticks.length * _candlestickWidth);
    _scrollController.addListener(_scrollControllerListener);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      _widgetWidth = constraint.maxWidth;

      return ValueListenableBuilder<_HightAndLow>(
          valueListenable: _hightAndLow,
          builder: (context, value, _) {
            return ListView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              shrinkWrap: true,
              children: [...widget.candlesticks.map((e) => _mapCandleToWidget(e, value.hight, value.low))],
            );
          });
    });
  }

  Widget _mapCandleToWidget(Candlestick candlestick, num hight, num low) {
    return SizedBox(width: _candlestickWidth, child: widget.candlestickBuilder(candlestick, hight, low));
  }

  void _scrollControllerListener() {
    final onScreen = _getVisibleCandlesticks(_scrollController.offset);

    _hightAndLow.value = _HightAndLow(
        hight: CandlesticksUtils.getAllTimeHight(onScreen), low: CandlesticksUtils.getAllTimeLow(onScreen));
  }

  List<Candlestick> _getVisibleCandlesticks(double offset) {
    final firstIndex = offset == 0 ? 0 : max(offset ~/ _candlestickWidth, 0);
    final numberOfCandlestickInScreen = (_widgetWidth / _candlestickWidth).ceil();
    final end = min(firstIndex + numberOfCandlestickInScreen, widget.candlesticks.length - 1);
    return widget.candlesticks.sublist(firstIndex, end);
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.removeListener(_scrollControllerListener);
  }
}

class _HightAndLow {
  final num hight;
  final num low;

  const _HightAndLow({required this.hight, required this.low});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _HightAndLow && runtimeType == other.runtimeType && hight == other.hight && low == other.low;

  @override
  int get hashCode => hight.hashCode ^ low.hashCode;
}
