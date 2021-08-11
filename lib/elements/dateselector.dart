import 'package:flutter/material.dart';
import 'package:flutter_app/database/DBHelper.dart';

// Used for the 3 square buttons at the bottom of the HomePage
class DateSelector extends StatefulWidget {
  final Function result;

  DateSelector(this.result);

  @override
  _DateSelectorState createState() => _DateSelectorState(result);
}

class _DateSelectorState extends State<DateSelector> {
  late DateTime selectedDate = DateTime.now();
  final Function result;

  _DateSelectorState(this.result);

  @override
  void initState() {
    super.initState();
    DBHelper().getGoals().then((value) => value.isNotEmpty
        ? setState(() {
            this.selectedDate =
                DateTime.parse(value.last.endDate).isBefore(DateTime.now())
                    ? DateTime.now()
                    : DateTime.parse(value.last.endDate);
          })
        : setState(() {
            this.selectedDate = DateTime.now();
          }));
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _selectDate(context), // Refer step 3
      child: Text(
        'Select date',
        style: Theme.of(context).textTheme.bodyText1!
          .merge(TextStyle(color: Theme.of(context).secondaryHeaderColor))
      ),

      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor,
      ),
    );
  }

  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(Duration(days: 100))))) {
      return true;
    }
    return false;
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      helpText: 'Select Date to Reach Your Goal',
      cancelText: 'Not now',
      confirmText: 'Let\'s get started!',
      selectableDayPredicate:
          _decideWhichDayToEnable, //Decides which days can be selected
    ))!;
    if (picked != selectedDate)
      setState(() {
        selectedDate = picked;
        result(selectedDate
            .add(Duration(hours: 23, minutes: 59, seconds: 59))
            .toIso8601String());
      });
  }
}
