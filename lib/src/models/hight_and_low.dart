class HightAndLow {
  final num hight;
  final num low;

  const HightAndLow({required this.hight, required this.low});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HightAndLow && runtimeType == other.runtimeType && hight == other.hight && low == other.low;

  @override
  int get hashCode => hight.hashCode ^ low.hashCode;
}
