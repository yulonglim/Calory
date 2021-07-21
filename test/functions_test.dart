import 'package:flutter_app/AppData/warm_up_data.dart';
import 'package:flutter_app/Functions.dart';
import 'package:test/test.dart';

void main() {
  group('Time related', () {
    test('datetime() function in homepage', () {
      var string = Functions().dateTime();
      expect(string, equals('21st July 2021')); //change according to day
    });

    test('durationMMSS function used in Warmup/workout/cooldown pages', () {
      var duration = Functions().durationMMSS(0);
      expect(duration, equals('0m 0s'));
    });

    test('durationMMSS function used in Warmup/workout/cooldown pages', () {
      var duration = Functions().durationMMSS(60);
      expect(duration, equals('1m 0s'));
    });

    test('durationMMSS function used in Warmup/workout/cooldown pages', () {
      var duration = Functions().durationMMSS(90);
      expect(duration, equals('1m 30s'));
    });

    test('totalduration function with warmup data', () {
      var duration = Functions().totalduration(warmUpData);
      expect(duration,equals('3m 0s'));
    });

    test('totalduration function with no data', () {
      var duration = Functions().totalduration([]);
      expect(duration,equals('0m 0s'));
    });
  });

  group('Switches ',() {
    test('Feedback switch with a double', () {
      var str = Functions().feedbackToString(0.123);
      expect(str, equals('Too Easy'));
    });

    test('Feedback switch with a 0', () {
      var str = Functions().feedbackToString(0);
      expect(str, equals('Too Easy'));
    });

    test('Feedback switch with a 3', () {
      var str = Functions().feedbackToString(3);
      expect(str, equals('Difficult'));
    });

    test('Feedback switch under intended range', () {
      var str = Functions().feedbackToString(-1);
      expect(str, equals(''));
    });

    test('Feedback switch over intended range', () {
      var str = Functions().feedbackToString(5);
      expect(str, equals(''));
    });

    test('Goal switch with a 0', () {
      var str = Functions().goalToString(0);
      expect(str, equals('Weight Loss'));
    });

    test('Goal switch with a 2', () {
      var str = Functions().goalToString(2);
      expect(str, equals('Endurance'));
    });

    test('Goal switch unintended value', () {
      var str = Functions().goalToString(-2);
      expect(str, equals('Not Set'));
    });


    test('Difficulty switch with a 2', () {
      var str = Functions().difficultyToString(2);
      expect(str, equals('Hard'));
    });

    test('Difficulty switch with a 0', () {
      var str = Functions().difficultyToString(0);
      expect(str, equals('Easy'));
    });

    test('Difficulty switch with unintended value', () {
      var str = Functions().difficultyToString(10);
      expect(str, equals(''));
    });

    test('Muscle group switch with a 2', () {
      var str = Functions().MuscleGroup(2);
      expect(str, equals('Core'));
    });

    test('Difficulty switch with a 0', () {
      var str = Functions().MuscleGroup(0);
      expect(str, equals('Upper Body'));
    });

    test('Difficulty switch with unintended value', () {
      var str = Functions().MuscleGroup(10);
      expect(str, equals(''));
    });

  });



}
