import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_candlesticks/flutter_simple_candlesticks.dart';
import 'package:flutter_simple_candlesticks/src/models/candlestick.dart';
import 'package:flutter_simple_candlesticks/src/widgets/painter.dart';

class CandleStickPainter extends CustomPainter with Painter {
  final Candlestick candlestick;
  final CandlestickStyle candlestickStyle;
  final CandlestickStyle candlestickSelectedStyle;
  final bool isSelected;

  CandleStickPainter(
      {required this.candlestick,
      required this.candlestickSelectedStyle,
      required num allTimeHight,
      required num allTimeLow,
      required this.isSelected,
      required this.candlestickStyle}) {
    this.allTimeLow = allTimeLow;
    this.allTimeHight = allTimeHight;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = getColor();

    final padding = size.width * 0.20;
    final openY = getOpenY(size).toDouble();
    final closeY = getCloseY(size).toDouble();
    final lowY = getLowY(size).toDouble();
    final hightY = getHightY(size).toDouble();

    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTRB(padding, closeY, size.width - padding, openY), const Radius.circular(2)),
        paint);

    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTRB(size.width / 2 - 1, hightY, size.width / 2 + 1, lowY), const Radius.circular(2)),
        paint);
  }

  Color getColor() {
    final style = isSelected ? candlestickSelectedStyle : candlestickStyle;

    return candlestick.open > candlestick.close ? style.bearishColor : style.bullishColor;
  }

  num getLowY(Size size) {
    return getYValue(size, candlestick.low);
  }

  num getHightY(Size size) {
    return getYValue(size, candlestick.hight);
  }

  num getOpenY(Size size) {
    return getYValue(size, candlestick.open);
  }

  num getCloseY(Size size) {
    return getYValue(size, candlestick.close);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
