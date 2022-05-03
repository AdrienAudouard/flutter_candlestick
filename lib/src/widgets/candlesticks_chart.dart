import 'package:flutter/material.dart';
import 'package:flutter_simple_candlesticks/flutter_simple_candlesticks.dart';
import 'package:flutter_simple_candlesticks/src/models/candlestick.dart';
import 'package:flutter_simple_candlesticks/src/utils/candlesticks_utils.dart';
import 'package:flutter_simple_candlesticks/src/widgets/candlestick_lines/candlestick_lines.dart';
import 'package:flutter_simple_candlesticks/src/widgets/candlestick_widget/candlestick_widget.dart';
import 'package:flutter_simple_candlesticks/src/widgets/candlesticks_container.dart';
import 'package:flutter_simple_candlesticks/src/widgets/candlesticks_non_scrollable_container.dart';
import 'package:flutter_simple_candlesticks/src/widgets/candlesticks_scrollable_container.dart';

typedef ValueMapper<T> = num Function(T);
typedef ValueDateMapper<T> = DateTime Function(T);

class CandlesticksChart<T> extends StatefulWidget {
  /// List of candlestick to display
  final List<T> data;

  /// Height of the chart
  final double height;

  /// Style of the chart
  final CandlestickChartStyle style;

  /// Options of the chart
  final CandlestickChartOptions options;

  /// Mapper function used to get the low value of each candle
  final ValueMapper<T> getLowCallback;

  /// Mapper function used to get the hight value of each candle
  final ValueMapper<T> getHightCallback;

  /// Mapper function used to get the open value of each candle
  final ValueMapper<T> getOpenCallback;

  /// Mapper function used to get the close value of each candle
  final ValueMapper<T> getCloseCallback;

  /// Mapper function used to get the date of each candle
  final ValueDateMapper<T> getTimeCallback;

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
    final legendValues = _getLegendValues(allTimeHight, allTimeLow, widget.style.yLegendStyle);

    return SizedBox(
      width: double.infinity,
      height: widget.height,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Flexible(child: _buildChart(legendValues)), _buildYLegend(legendValues)],
      ),
    );
  }

  Widget _buildChart(List<num> legendValues) {
    return Stack(
      children: [
        if (widget.style.yLegendStyle.lineStyle != null)
          CandlestickLines(
            allTimeHight: allTimeHight,
            allTimeLow: allTimeLow,
            legendValues: legendValues,
            lineStyle: widget.style.yLegendStyle.lineStyle!,
          ),
        _buildContainer()
      ],
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

  Widget _buildYLegend(List<num> values) {
    final style = widget.style.yLegendStyle;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      verticalDirection: VerticalDirection.up,
      children: values
          .map((e) => Text(CandlesticksUtils.formatCandlestickValue(e, widget.style.yLegendStyle.fractionDigits),
              style: style.textStyle))
          .toList(),
    );
  }

  List<num> _getLegendValues(num allTimeHight, num allTimeLow, CandlestickChartYLegendStyle style) {
    final interval = (allTimeHight - allTimeLow) / 4;
    final values = <num>[];

    for (var i = 0; i < style.numberOfLabels; i++) {
      values.add(allTimeLow + interval * i);
    }
    return values;
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
