List<DateTime> getNext15DaysWithWeekdays() {
  final List<DateTime> result = [];

  DateTime currentDate = DateTime.now();

  for (int i = 0; i < 14; i++) {
    result.add(currentDate);

    currentDate = currentDate.add(const Duration(days: 1));
  }

  return result;
}
