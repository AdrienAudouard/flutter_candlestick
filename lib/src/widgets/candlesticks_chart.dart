import 'package:flutter/material.dart';
import 'package:flutter_candlesticks/flutter_candlesticks.dart';
import 'package:flutter_candlesticks/src/models/candlestick.dart';
import 'package:flutter_candlesticks/src/models/candlestick_chart_options.dart';
import 'package:flutter_candlesticks/src/utils/candlesticks_utils.dart';
import 'package:flutter_candlesticks/src/widgets/candlestick_widget.dart';
import 'package:flutter_candlesticks/src/widgets/candlesticks_container.dart';
import 'package:flutter_candlesticks/src/widgets/candlesticks_non_scrollable_container.dart';
import 'package:flutter_candlesticks/src/widgets/candlesticks_scrollable_container.dart';

class CandlesticksChart<T> extends StatefulWidget {
  final List<T> data;
  final double height;
  final CandlestickChartStyle style;
  final CandlestickChartOptions options;
  final num Function(T) getLowCallback;
  final num Function(T) getHightCallback;
  final num Function(T) getOpenCallback;
  final num Function(T) getCloseCallback;
  final DateTime Function(T) getTimeCallback;

  const CandlesticksChart(
      {required this.data,
      required this.height,
      required this.getLowCallback,
      required this.getHightCallback,
      required this.getOpenCallback,
      required this.getCloseCallback,
      required this.getTimeCallback,
      this.style = const CandlestickChartStyle(),
      this.options = const CandlestickChartOptions(),
      Key? key})
      : super(key: key);

  @override
  State<CandlesticksChart<T>> createState() => _CandlesticksChartState<T>();
}

class _CandlesticksChartState<T> extends State<CandlesticksChart<T>> {
  late final List<Candlestick> candlesticks;
  late final num allTimeHight;
  late final num allTimeLow;

  @override
  void initState() {
    candlesticks = _mapDataToCandlesticks();
    allTimeHight = CandlesticksUtils.getAllTimeHight(candlesticks);
    allTimeLow = CandlesticksUtils.getAllTimeLow(candlesticks);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: widget.height,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Flexible(child: _buildContainer()), _buildYLegend(allTimeHight, allTimeLow)],
      ),
    );
  }

  CandlesticksContainer _buildContainer() {
    if (widget.options.isScrollable) {
      return CandlesticksScrollableContainer(candlestickBuilder: _buildCandlestick, candlesticks: candlesticks);
    }

    return CandlesticksNonScrollableContainer(candlestickBuilder: _buildCandlestick, candlesticks: candlesticks);
  }

  CandlestickWidget _buildCandlestick(Candlestick candlestick, num hight, num low) {
    return CandlestickWidget(
      candlestick: candlestick,
      allTimeHight: hight,
      allTimeLow: low,
      chartStyle: widget.style,
    );
  }

  Widget _buildYLegend(num allTimeHight, num allTimeLow) {
    final style = widget.style.yLegendStyle;

    final interval = (allTimeHight - allTimeLow) / 4;
    final values = <num>[];

    for (var i = 0; i < style.numberOfLabels; i++) {
      values.add(allTimeLow + interval * i);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      verticalDirection: VerticalDirection.up,
      children: values
          .map((e) =>
              Text(CandlesticksUtils.formatCandlestickValue(e, widget.style.fractionDigits), style: style.textStyle))
          .toList(),
    );
  }

  Widget _mapCandleToWidget(Candlestick candlestick) {
    return Expanded(
        child: CandlestickWidget(
          candlestick: candlestick,
          allTimeHight: allTimeHight,
          allTimeLow: allTimeLow,
          chartStyle: widget.style,
        ),
        flex: 1);
  }

  List<Candlestick> _mapDataToCandlesticks() {
    return widget.data
        .map((e) => Candlestick(
            date: widget.getTimeCallback(e),
            hight: widget.getHightCallback(e),
            low: widget.getLowCallback(e),
            open: widget.getOpenCallback(e),
            close: widget.getCloseCallback(e)))
        .toList();
  }
}
