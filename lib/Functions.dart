import 'package:flutter_app/database/exercise_data.dart';
import 'package:intl/intl.dart';

class Functions {
  //class filled with all the functions use in the app
  String dateTime() {
    String day;
    String month = DateFormat.MMMM().format(DateTime.now());
    String year = DateTime.now().year.toString();

    if (DateTime.now().day == 11 ||
        DateTime.now().day == 12 ||
        DateTime.now().day == 13) {
      day = DateTime.now().day.toString() + "th";
    } else if (DateTime.now().day % 10 == 1) {
      day = DateTime.now().day.toString() + "st";
    } else if (DateTime.now().day % 10 == 2) {
      day = DateTime.now().day.toString() + "nd";
    } else if (DateTime.now().day % 10 == 3) {
      day = DateTime.now().day.toString() + "rd";
    } else {
      day = DateTime.now().day.toString() + "th";
    }

    return day + " " + month + " " + year;
  }

  String durationMMSS(int duration) {
    int mins = 0;
    int temp = duration;
    while (temp >= 60) {
      temp -= 60;
      mins++;
    }
    return mins.toString() + 'm ' + temp.toString() + 's';
  }

  String totalduration(List<exerciseData> items) {
    int duration = 0;
    for (int counter = 0; counter < items.length; counter++) {
      duration += items[counter].exerciseTime;
    }
    return durationMMSS(duration);
  }

  String difficultyToString(int i) {
    switch (i.round()) {
      case 0:
        {
          return 'Easy';
        }
      case 1:
        {
          return 'Medium';
        }
      case 2:
        {
          return 'Hard';
        }
      default:
        {
          return "";
        }
    }
  }

  String feedbackToString(double i) {
    switch (i.round()) {
      case 0:
        {
          return 'Too Easy';
        }
      case 1:
        {
          return 'Easy';
        }
      case 2:
        {
          return 'Manageable';
        }
      case 3:
        {
          return 'Difficult';
        }
      case 4:
        {
          return 'Too Difficult';
        }
      default:
        {
          return "";
        }
    }
  }

  String goalToString(int goalType) {
    switch (goalType) {
      case 0:
        {
          return 'Weight Loss';
        }
      case 1:
        {
          return 'Strength';
        }
      case 2:
        {
          return 'Endurance';
        }
      default:
        {
          return 'Not Set';
        }
    }
  }

  String MuscleGroup(int muscle) {
    switch (muscle) {
      case 0:
        {
          return 'Upper Body';
        }
      case 1:
        {
          return 'Lower Body';
        }
      case 2:
        {
          return 'Core';
        }
      case 3:
        {
          return 'Balanced';
        }
      default:
        {
          return '';
        }
    }
  }
}
