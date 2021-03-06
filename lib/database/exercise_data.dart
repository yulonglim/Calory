import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

List<ExerciseData> upperBodyData2 = [];
List<ExerciseData> lowerBodyData2 = [];
List<ExerciseData> coreExerciseData2 = [];
List<ExerciseData> cardioData2 = [];

void openExcel() async {
  ByteData data = await rootBundle.load("assets/Database.xlsx");
  var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  var excel = Excel.decodeBytes(bytes);

  for (var table in excel.tables.keys) {
    for (int rowIndex = 1;
        rowIndex <= excel.tables[table]!.maxRows;
        rowIndex++) {
      Sheet sheetObject = excel['$table'];

      String exerciseId = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex))
          .value
          .toString();
      if (exerciseId == "null") {
        break;
      }
      int? exerciseValue = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: rowIndex))
          .value;
      int exerciseTime = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: rowIndex))
          .value;
      String exerciseName = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: rowIndex))
          .value
          .toString();
      String exerciseDescription = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: rowIndex))
          .value
          .toString();

      ExerciseData excelDetails = new ExerciseData(
          exerciseId: exerciseId,
          exerciseValue: exerciseValue,
          exerciseTime: exerciseTime,
          exerciseName: exerciseName,
          exerciseDescription: exerciseDescription);
      exerciseId.contains('U')
          ? upperBodyData2.add(excelDetails)
          : exerciseId.contains('L')
              ? lowerBodyData2.add(excelDetails)
              : exerciseId.contains('C')
                  ? coreExerciseData2.add(excelDetails)
                  : cardioData2.add(excelDetails);
    }
  }
}

class ExerciseData {
  String exerciseId;
  int? exerciseValue;
  int exerciseTime;
  String exerciseName;
  String exerciseDescription;

  ExerciseData(
      {required this.exerciseId,
      this.exerciseValue,
      required this.exerciseTime,
      required this.exerciseName,
      required this.exerciseDescription});

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

  static ExerciseData fromMap(Map<String, dynamic> map) {
    String exerciseId = map['exerciseId'];
    int? exerciseValue = map['exerciseValue'];
    int exerciseTime = map['exerciseTime'];
    String exerciseName = map['exerciseName'];
    String exerciseDescription = map['exerciseDescription'];

    return ExerciseData(
        exerciseId: exerciseId,
        exerciseValue: exerciseValue,
        exerciseTime: exerciseTime,
        exerciseName: exerciseName,
        exerciseDescription: exerciseDescription);
  }
}
