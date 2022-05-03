import 'dart:math';

import 'package:flutter_candlesticks/src/models/candlestick.dart';

class CandlesticksUtils {
  static num getAllTimeHight(List<Candlestick> candlesticks) {
    var ath = candlesticks[0].hight;

    candlesticks.forEach((element) {
      ath = max(ath, element.hight);
    });

    return ath;
  }

  static num getAllTimeLow(List<Candlestick> candlesticks) {
    var atl = candlesticks[0].low;

    candlesticks.forEach((element) {
      atl = min(atl, element.low);
    });

    return atl;
  }

  static String formatCandlestickValue(num value, int? fractionDigits) {
    return fractionDigits == null ? value.toString() : value.toStringAsFixed(fractionDigits);
  }
}
