enum TodoPriority {
  low,
  medium,
  high;

  bool get isHigh => this == TodoPriority.high;
  bool get isMedium => this == TodoPriority.medium;
  bool get isLow => this == TodoPriority.low;
}
