import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
//import 'package:excel/excel.dart';
/*
var file = "Path_to_pre_existing_Excel_File/excel_file.xlsx";
var bytes = File(file).readAsBytesSync();
var excel = Excel.decodeBytes(bytes);

for (var table in excel.tables.keys) async {
  print(table); //sheet Name
  print(excel.tables[table]!.maxCols);
  print(excel.tables[table]!.maxRows);
  for (var row in excel.tables[table]!.rows) {
    print("$row");
  }
}

 */

/*Code below is the hardcode version of populating the database*/

final List<exerciseData> upperBodyData = [
  exerciseData(exerciseId: "U1", exerciseValue: 60, exerciseTime: 60, exerciseName: "Pushups", exerciseDescription: "abc"),
  exerciseData(exerciseId: "U2", exerciseValue: 30, exerciseTime: 60, exerciseName: "Overhead Claps", exerciseDescription: "def"),
  exerciseData(exerciseId: "U3", exerciseValue: 60, exerciseTime: 60, exerciseName: "Tricep Dips", exerciseDescription: "ghi"),
  exerciseData(exerciseId: "U4", exerciseValue: 40, exerciseTime: 60, exerciseName: "Reverse Angels", exerciseDescription: "jkl")
];

final List<exerciseData> lowerBodyData = [
  exerciseData(exerciseId: "L1", exerciseValue: 60, exerciseTime: 60, exerciseName: "Squats", exerciseDescription: "Stand straight with your feet shoulder width apart, lower yourself till the knees are 90 degrees before pushing yourself back up."),
  exerciseData(exerciseId: "L2", exerciseValue: 60, exerciseTime: 60, exerciseName: "Split Squat", exerciseDescription: "Stand straight with one leg in front while the other behind. Lower yourself until both knees are 90 degrees before pushing yourself back up."),
  exerciseData(exerciseId: "L3", exerciseTime: 60, exerciseName: "Wall Squat", exerciseDescription: "Lean against a wall will your legs slightly forward. Lower yourself until both knees are 90 degrees and hold the position."),
  exerciseData(exerciseId: "L4", exerciseValue: 30, exerciseTime: 60, exerciseName: "Squat Jump", exerciseDescription: "Stand straight with your feet shoulder width apart, lower yourself till the knees are 90 degrees before pushing youself back up with a jump."),
];

final List<exerciseData> coreExerciseData = [
  exerciseData(exerciseId: "C1", exerciseValue: 60, exerciseTime: 60, exerciseName: "Sit-Up", exerciseDescription: "exerciseDescription1"),
  exerciseData(exerciseId: "C2", exerciseTime: 60, exerciseName: "Plank", exerciseDescription: "exerciseDescription2"),
  exerciseData(exerciseId: "C3", exerciseValue: 30, exerciseTime: 60, exerciseName: "Mountain Climbers", exerciseDescription: "exerciseDescription3"),
  exerciseData(exerciseId: "C4", exerciseValue: 40, exerciseTime: 60, exerciseName: "Single leg toe touch", exerciseDescription: "exerciseDescription4"),
];

final List<exerciseData> cardioData = [
  exerciseData(exerciseId: "H1", exerciseTime: 18000, exerciseName: "Run", exerciseDescription: "Nil"),
  exerciseData(exerciseId: "H2", exerciseTime: 18000, exerciseName: "Swim", exerciseDescription: "Nil"),
  exerciseData(exerciseId: "H3", exerciseTime: 18000, exerciseName: "Cycle", exerciseDescription: "Nil"),
];


class exerciseData {

  final String exerciseId;
  final int? exerciseValue;
  final int exerciseTime;
  final String exerciseName;
  final String exerciseDescription;

  const exerciseData({
    required this.exerciseId,
    this.exerciseValue,
    required this.exerciseTime,
    required this.exerciseName,
    required this.exerciseDescription
  });

  static exerciseData fromMap(Map<String, dynamic> map) {
    String exerciseId = map['exerciseId'];
    int exerciseValue = map['exerciseValue'];
    int exerciseTime = map['exerciseTime'];
    String exerciseName = map['exerciseName'];
    String exerciseDescription = map['exerciseDescription'];

    return exerciseData(
        exerciseId: exerciseId,
        exerciseValue: exerciseValue,
        exerciseTime: exerciseTime,
        exerciseName: exerciseName,
        exerciseDescription: exerciseDescription);
  }


  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'exerciseId': exerciseId,
      'exerciseValue': exerciseValue,
      'exerciseTime': exerciseTime,
      'exerciseName': exerciseName,
      'exerciseDescription': exerciseDescription
    };

    return map;
  }

  String toJsonEncoding() {
    return jsonEncode(this.toMap());
  }

  static exerciseData fromJsonEncoding(String jsonEncoding) {
    return fromMap(jsonDecode(jsonEncoding));
  }

}


