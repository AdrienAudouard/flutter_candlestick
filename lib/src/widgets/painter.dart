import 'package:flutter/material.dart';

mixin Painter {
  late final num allTimeHight;
  late final num allTimeLow;

  num getYValue(Size size, num value) {
    return size.height - ((value - allTimeLow) / yMax) * size.height;
  }

  num get yMax {
    return allTimeHight - allTimeLow;
  }
}
