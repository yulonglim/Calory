import 'dart:collection';

import 'package:flutter_app/database/DBHelper.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}



int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final Now = DateTime.now();
final FirstDay = DateTime(Now.year, Now.month - 4, Now.day);
final LastDay = DateTime(Now.year, Now.month + 4, Now.day);
