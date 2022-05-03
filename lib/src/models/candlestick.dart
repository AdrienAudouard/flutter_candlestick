class Candlestick {
  final DateTime date;
  final num hight;
  final num low;
  final num open;
  final num close;

  Candlestick({required this.date, required this.hight, required this.low, required this.open, required this.close});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Candlestick &&
          runtimeType == other.runtimeType &&
          date == other.date &&
          hight == other.hight &&
          low == other.low &&
          open == other.open &&
          close == other.close;

  @override
  int get hashCode => date.hashCode ^ hight.hashCode ^ low.hashCode ^ open.hashCode ^ close.hashCode;
}
