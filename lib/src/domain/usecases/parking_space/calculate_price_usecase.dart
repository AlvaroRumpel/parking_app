class CalculatePriceUsecase {
  double call(DateTime startTime, DateTime endTime, double price) {
    final duration = endTime.difference(startTime);
    final hours = duration.inHours + (duration.inMinutes % 60) / 60;
    return hours * price;
  }
}
