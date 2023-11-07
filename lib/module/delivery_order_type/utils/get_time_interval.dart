import '../../outlet_details/shift/outlet_shift_details_model.dart';

List<String> getTimeIntervals(ShiftItem shiftData, DateTime selectedDate) {
 List<String> timeIntervalList=[];
  String startTime = shiftData.startTime ?? "";
  String endTime = shiftData.endTime ?? "";
  int cutoffTimeMinutes = parseTimeToMinutes(shiftData.cutoffTime ?? "");
  int intervalTimeMinutes = parseTimeToMinutes(shiftData.intervalTime ?? "");

  DateTime now = DateTime.now();

  int startTimeMinutes = parseTimeToMinutes(startTime);
  int endTimeMinutes = parseTimeToMinutes(endTime);

  int intervalStartTime = startTimeMinutes + cutoffTimeMinutes;
  int intervalEndTime = endTimeMinutes - cutoffTimeMinutes;

  for (int time = intervalStartTime;
  time <= intervalEndTime;
  time += intervalTimeMinutes) {
    int hours = time ~/ 60;
    int minutes = time % 60;

    DateTime intervalDateTime =
    selectedDate.add(Duration(hours: hours, minutes: minutes));

    if (intervalDateTime.isAfter(now)) {
      String period = hours >= 12 ? 'PM' : 'AM';
      hours = hours % 12;
      if (hours == 0) {
        hours = 12;
      }

      String formattedTime =
          '$hours:${minutes.toString().padLeft(2, '0')} $period';
      timeIntervalList.add(formattedTime);
    }
  }

  return timeIntervalList;
} int parseTimeToMinutes(String time) {
  List<String> parts = time.split(':');
  int hours = int.parse(parts[0]);
  int minutes = int.parse(parts[1]);
  return hours * 60 + minutes;
}
