import 'package:flutter/material.dart';
import 'package:flutter_simple_candlesticks/flutter_simple_candlesticks.dart';
import 'package:flutter_simple_candlesticks/src/widgets/painter.dart';

class CandlestickLinesPainter extends CustomPainter with Painter {
  final List<num> legendValues;
  final CandlestickChartLineStyle lineStyle;

  CandlestickLinesPainter({
    required this.legendValues,
    required this.lineStyle,
    required num allTimeHight,
    required num allTimeLow,
  }) {
    this.allTimeLow = allTimeLow;
    this.allTimeHight = allTimeHight;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = lineStyle.width
      ..color = lineStyle.color;

    for (var value in legendValues) {
      final y = getYValue(size, value).toDouble();
      final p1 = Offset(0, y);
      final p2 = Offset(size.width, y);

      if (lineStyle is CandlestickChartDashedLineStyle) {
        _drawDashedLine(canvas, p1, p2, paint);
      } else {
        canvas.drawLine(p1, p2, paint);
      }
    }
  }

  void _drawDashedLine(Canvas canvas, Offset p1, Offset p2, Paint paint) {
    final dashedStyle = lineStyle as CandlestickChartDashedLineStyle;
    var startX = p1.dx;
    final y = p1.dy;

    while (startX < p2.dx) {
      canvas.drawLine(Offset(startX, y), Offset(startX + dashedStyle.dashWidth, y), paint);
      startX += dashedStyle.dashWidth + dashedStyle.dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
