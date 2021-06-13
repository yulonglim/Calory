import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(70, (index) => index),
    key: (item) => DateTime(Now.year, Now.month - 4, item*3),
    value: (item) => [
          Event('Did workout'),
        ]);

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
