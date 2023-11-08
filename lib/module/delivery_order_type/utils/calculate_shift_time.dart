DateTime calculateShiftEndTime(String endTime, String cutoffTime) {
  List<String> endTimeParts = endTime.split(':');
  List<String> cutoffTimeParts = cutoffTime.split(':');

  int endHour = int.parse(endTimeParts[0]);
  int endMinute = int.parse(endTimeParts[1]);
  int endSecond = int.parse(endTimeParts[2]);

  int cutoffHour = int.parse(cutoffTimeParts[0]);
  int cutoffMinute = int.parse(cutoffTimeParts[1]);
  int cutoffSecond = int.parse(cutoffTimeParts[2]);

  DateTime currentTime = DateTime.now();
  DateTime shiftEndTime = DateTime(
    currentTime.year,
    currentTime.month,
    currentTime.day,
    endHour - cutoffHour,
    endMinute - cutoffMinute,
    endSecond - cutoffSecond,
  );

  return shiftEndTime;
}
