import 'dart:math';

class CandleModel {
  final DateTime date;
  final num hight;
  final num low;
  final num open;
  final num close;

  CandleModel({required this.date, required this.hight, required this.low, required this.open, required this.close});

  factory CandleModel.generate(DateTime dateTime) {
    final rng = Random();

    return CandleModel(
        date: dateTime,
        hight: rng.nextDouble() * 50 + 150,
        low: rng.nextDouble() * 50,
        open: rng.nextDouble() * 50 + 50,
        close: rng.nextDouble() * 100);
  }
}

final data = [
  CandleModel(date: DateTime.now(), hight: 50, low: 10, open: 2, close: 30),
  CandleModel(date: DateTime.now(), hight: 70, low: 40, open: 55, close: 45),
  CandleModel(date: DateTime.now(), hight: 20, low: 10, open: 12, close: 18),
  CandleModel(date: DateTime.now(), hight: 30, low: 10, open: 20, close: 25),
  CandleModel(date: DateTime.now(), hight: 60, low: 25, open: 30, close: 50),
  CandleModel(date: DateTime.now(), hight: 100, low: 55, open: 55, close: 90),
  CandleModel(date: DateTime.now(), hight: 180, low: 70, open: 90, close: 120),
  CandleModel(date: DateTime.now(), hight: 100, low: 40, open: 90, close: 55),
  CandleModel(date: DateTime.now(), hight: 45, low: 30, open: 40, close: 35),
  CandleModel(date: DateTime.now(), hight: 55, low: 40, open: 45, close: 55),
  CandleModel(date: DateTime.now(), hight: 20, low: 10, open: 18, close: 14),
  CandleModel(date: DateTime.now(), hight: 25, low: 17, open: 17, close: 20),
  CandleModel(date: DateTime.now(), hight: 100, low: 38, open: 40, close: 90),
  CandleModel(date: DateTime.now(), hight: 140, low: 45, open: 60, close: 110),
  CandleModel(date: DateTime.now(), hight: 100, low: 30, open: 90, close: 60),
];
