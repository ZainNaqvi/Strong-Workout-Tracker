import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:workout_flutter_app/core/app_asset.dart';
import 'package:workout_flutter_app/src/data/model/exercise_model.dart';
import 'package:workout_flutter_app/src/data/model/workout_model.dart';

class WorkoutsCubit extends HydratedCubit<List<Workout>> {
  WorkoutsCubit() : super([]);

  void loadWorkout() async {
    List<Workout> workout = [];
    final workoutJson =
        jsonDecode(await rootBundle.loadString(AppAsset.workoutsJson));
    for (var ex in (workoutJson as Iterable)) {
      workout.add(Workout.fromJson(ex));
    }

    emit(workout);
  }

  saveWorkout(Workout workout, int index) {
    Workout newWorkout = Workout(title: workout.title, exercises: []);
    int exIndex = 0;
    int startIndex = 0;
    for (var ex in workout.exercises) {
      newWorkout.exercises.add(
        Exercises(
          title: ex.title,
          prelude: ex.prelude,
          duration: ex.duration,
          startTime: startIndex,
          index: index,
        ),
      );
      exIndex++;
      startIndex += ex.prelude! + ex.duration!;
    }
    state[index] = newWorkout;
    emit([...state]);
  }

  @override
  List<Workout>? fromJson(Map<String, dynamic> json) {
    List<Workout> workouts = [];
    json['workouts'].forEach((el) => workouts.add(Workout.fromJson(el)));
    return workouts;
  }

  @override
  Map<String, dynamic>? toJson(List<Workout> state) {
    if (state is List<Workout>) {
      var json = {'workouts': []};
      for (var workout in state) {
        json['workouts']!.add(workout.toJson());
      }
      return json;
    } else {
      return null;
    }
  }
}
