import 'package:flutter/material.dart';
import 'package:flutter_candlesticks/flutter_candlesticks.dart';
import 'package:flutter_candlesticks/src/models/candlestick.dart';
import 'package:flutter_candlesticks/src/utils/candlesticks_utils.dart';
import 'package:flutter_candlesticks/src/widgets/candlestick_widget/candlestick_painter.dart';

class CandlestickWidget extends StatelessWidget {
  final _isSelected = ValueNotifier(false);
  final _toolTipKey = GlobalKey();

  final Candlestick candlestick;
  final CandlestickChartStyle chartStyle;
  final num allTimeHight;
  final num allTimeLow;

  CandlestickWidget(
      {required this.candlestick,
      required this.allTimeHight,
      required this.allTimeLow,
      required this.chartStyle,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      key: _toolTipKey,
      decoration: BoxDecoration(color: chartStyle.tooltipColor),
      message:
          'L: ${_format(candlestick.low)} O: ${_format(candlestick.open)} C: ${_format(candlestick.close)} H: ${_format(candlestick.hight)}',
      verticalOffset: 150,
      preferBelow: false,
      triggerMode: TooltipTriggerMode.longPress,
      child: GestureDetector(
        onLongPressStart: (_) {
          final dynamic _toolTip = _toolTipKey.currentState;
          _toolTip.ensureTooltipVisible();

          _isSelected.value = true;
        },
        onLongPressEnd: (_) => _isSelected.value = false,
        behavior: HitTestBehavior.translucent,
        child: ValueListenableBuilder<bool>(
            valueListenable: _isSelected,
            builder: (_, isSelected, __) {
              return SizedBox(
                height: double.infinity,
                child: CustomPaint(
                    painter: CandleStickPainter(
                        candlestick: candlestick,
                        allTimeHight: allTimeHight,
                        allTimeLow: allTimeLow,
                        isSelected: isSelected,
                        candlestickSelectedStyle: chartStyle.candlestickSelectedStyle,
                        candlestickStyle: chartStyle.candlestickStyle)),
              );
            }),
      ),
    );
  }

  String _format(num value) {
    return CandlesticksUtils.formatCandlestickValue(value, chartStyle.yLegendStyle.fractionDigits);
  }
}
