import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/database/DBHelper.dart';
import 'package:flutter_app/database/workout.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../Functions.dart';
import '../database/Event.dart';

class ProgressPage extends StatefulWidget {
  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  late DateTime startDate = DateTime.now();
  late DateTime endDate = DateTime.now();
  late String difficulty = 'Not Set';
  late String goal = 'Not Set';
  late int progress = 0;
  late List<Workout> workouts = [];
  late Map<DateTime, List<Event>> _kEventSource = new Map();
  late LinkedHashMap<DateTime, List<Event>> kEvents = new LinkedHashMap();

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    DBHelper().getWorkOut().then((value) => workouts = value);
    DBHelper().getGoals().then((value) => value.isNotEmpty
        ? setState(() {
            value.last.difficultyLevel == 0
                ? this.difficulty = 'Easy'
                : value.last.difficultyLevel == 1
                    ? this.difficulty = 'Medium'
                    : this.difficulty = 'Hard';
            this.goal = Functions().goalToString(value.last.goal);
            this.startDate = DateTime.parse(value.last.startDate);
            this.endDate = DateTime.parse(value.last.endDate);
            this.progress = value.last.progress;
            this._kEventSource = Map.fromIterable(workouts, //populating event source
                key: (item) => DateTime.parse(item.workoutDate),
                value: (item) => [
                      Event(item.toString()),
                    ]);
            this.kEvents = LinkedHashMap<DateTime, List<Event>>( //populating event hashmaps to be read by calendar widget
              equals: isSameDay,
              hashCode: getHashCode,
            )..addAll(_kEventSource);
            _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
          })
        : setState(() {
            this._kEventSource = Map.fromIterable(workouts,
                key: (item) => DateTime.parse(item.workoutDate),
                value: (item) => [
                      Event(item.toString()),
                    ]);
            this.kEvents = LinkedHashMap<DateTime, List<Event>>(
              equals: isSameDay,
              hashCode: getHashCode,
            )..addAll(_kEventSource);
            _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
          }));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }


  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          title: Text(
            "Your Progress",
            style: Theme.of(context).textTheme.headline5,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 16, top: 20, right: 16),
          child: ListView(
            children: [
              // SizedBox(
              //   height: 4,
              // ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Calendar Tracker",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.52,
                child: Column(
                  children: [
                    TableCalendar<Event>(
                      firstDay: firstDay,
                      lastDay: lastDay,
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      rangeStartDay: _rangeStart,
                      rangeEndDay: _rangeEnd,
                      eventLoader: _getEventsForDay,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      calendarStyle: CalendarStyle(
                        selectedDecoration: BoxDecoration( // Changes how icon looks when selected
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                          //shape: BoxShape.rectangle,
                        ),
                        todayDecoration: BoxDecoration( // Changes how icon looks for today's date
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        rangeHighlightColor: Theme.of(context).primaryColor,
                        markerDecoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        /* uncomment to change how the event indicator will look like
                         image: DecorationImage(
                             fit: BoxFit.fill,
                             image: AssetImage('assets/images/check-mark.png'))),*/
                        outsideDaysVisible: false,
                      ),
                      onDaySelected: _onDaySelected,
                      calendarFormat: _calendarFormat,
                      onFormatChanged: (format) { //
                        if (_calendarFormat != format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        }
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                    ),
                    Expanded(
                      child: ValueListenableBuilder<List<Event>>(
                        valueListenable: _selectedEvents,
                        builder: (context, value, _) {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: ListTile(
                                  onTap: () => showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: Text('What you did!',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1),
                                      content: Text(
                                          _getEventsForDay(_selectedDay!)
                                              .last
                                              .title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  title: Text(
                                    'Click to see workout!',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Current Goal",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Start Date:",
                      style: Theme.of(context).textTheme.bodyText2),
                  Text(
                    DateFormat.MMMM().format(startDate) +
                        " " +
                        startDate.day.toString(),
                    style:
                        Theme.of(context).textTheme.bodyText2!.merge(TextStyle(
                              color: Colors.grey[600],
                            )),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("End Date:",
                      style: Theme.of(context).textTheme.bodyText2),
                  Text(
                    DateFormat.MMMM().format(endDate) +
                        " " +
                        endDate.day.toString(),
                    style:
                        Theme.of(context).textTheme.bodyText2!.merge(TextStyle(
                              color: Colors.grey[600],
                            )),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Current Difficulty Level:",
                      style: Theme.of(context).textTheme.bodyText2),
                  Text(
                    difficulty,
                    style:
                        Theme.of(context).textTheme.bodyText2!.merge(TextStyle(
                              color: Colors.grey[600],
                            )),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Current Goal Type:",
                      style: Theme.of(context).textTheme.bodyText2),
                  Text(
                    goal,
                    style:
                        Theme.of(context).textTheme.bodyText2!.merge(TextStyle(
                              color: Colors.grey[600],
                            )),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Days Left:",
                      style: Theme.of(context).textTheme.bodyText2),
                  Text(
                    (endDate.difference(DateTime.now()).inDays + 1 <= 0 ? 0 : endDate.difference(DateTime.now()).inDays + 1).toString(),
                    style:
                        Theme.of(context).textTheme.bodyText2!.merge(TextStyle(
                              color: Colors.grey[600],
                            )),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("No. of days of workout left:",
                      style: Theme.of(context).textTheme.bodyText2),
                  Text(
                    progress <= 0 ? "0" : progress.toString(),
                    style:
                        Theme.of(context).textTheme.bodyText2!.merge(TextStyle(
                              color: Colors.grey[600],
                            )),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
