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
  exerciseData(exerciseId: "U1", exerciseValue: 20,exerciseName: "Pushups", exerciseDescription: "abc"),
  exerciseData(exerciseId: "U2", exerciseValue: 10, exerciseName: "Burpees", exerciseDescription: "def"),
  exerciseData(exerciseId: "U3", exerciseValue: 10, exerciseName: "Burpees with pushups", exerciseDescription: "ghi"),
  exerciseData(exerciseId: "U4", exerciseValue: 20, exerciseName: "Tricep Dips", exerciseDescription: "jkl")
];


class exerciseData {

  final String exerciseId;
  final int? exerciseValue;
  final int? exerciseTime;
  final String exerciseName;
  final String exerciseDescription;

  const exerciseData({
    required this.exerciseId,
    this.exerciseValue,
    this.exerciseTime,
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


