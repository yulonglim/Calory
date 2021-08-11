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

  String dateTime2(String formattedDate) {
    String day;
    String month = DateFormat.MMMM().format(DateTime.parse(formattedDate));
    String year = DateTime.parse(formattedDate).year.toString();

    if (DateTime.parse(formattedDate).day == 11 ||
        DateTime.parse(formattedDate).day == 12 ||
        DateTime.parse(formattedDate).day == 13) {
      day = DateTime.parse(formattedDate).day.toString() + "th";
    } else if (DateTime.parse(formattedDate).day % 10 == 1) {
      day = DateTime.parse(formattedDate).day.toString() + "st";
    } else if (DateTime.parse(formattedDate).day % 10 == 2) {
      day = DateTime.parse(formattedDate).day.toString() + "nd";
    } else if (DateTime.parse(formattedDate).day % 10 == 3) {
      day = DateTime.parse(formattedDate).day.toString() + "rd";
    } else {
      day = DateTime.parse(formattedDate).day.toString() + "th";
    }

    return day + " " + month + " " + year;
  }

  String durationMMSS(int duration) {
    int min = 0;
    int temp = duration;
    while (temp >= 60) {
      temp -= 60;
      min++;
    }
    return min.toString() + 'm ' + temp.toString() + 's';
  }

  String totalDuration(List<ExerciseData> items) {
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

  String muscleGroup(int muscle) {
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

  int newDifficulty(int currentDifficulty, double sliderValue) {
    if (currentDifficulty + 5 - sliderValue.round() * 2 > 60) {
      return 2;
    } else if (currentDifficulty + 5 - sliderValue.round() * 2 > 40) {
      return 1;
    } else {
      return 0;
    }
  }

  int newMultiplier(int currentMultiplier, double sliderValue) {
    return currentMultiplier + 5 - sliderValue.round() * 2 >= 100
        ? 100
        : currentMultiplier + 5 - sliderValue.round() * 2;
  }

  int daysWorkedOut(String startDate, String endDate, int daysAWeek) {
    return ((DateTime.parse(endDate).difference(DateTime.parse(startDate)).inDays + 1) / 7 * daysAWeek).round();
  }
}
