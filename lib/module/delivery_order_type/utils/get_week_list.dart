import 'date_model.dart';

List<DateModel> getNext15DaysWithWeekdays() {
  final List<DateModel> result = [];

  DateTime currentDate = DateTime.now();

  for (int i = 0; i < 14; i++) {
    int dayOfWeek = currentDate.weekday;

    result.add(DateModel(currentDate, dayOfWeek));

    currentDate = currentDate.add(const Duration(days: 1));
  }

  return result;
}