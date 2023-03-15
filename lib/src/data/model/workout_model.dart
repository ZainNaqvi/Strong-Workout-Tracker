// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:workout_flutter_app/src/data/model/exercise_model.dart';

class Workout extends Equatable {
  final String? title;
  final List<Exercises> exercises;

  const Workout({required this.title, required this.exercises});

  factory Workout.fromJson(Map<String, dynamic> json) {
    List<Exercises> exercises = [];
    int index = 0;
    int startTime = 0;
    for (var ex in (json['exercises'] as Iterable)) {
      exercises.add(Exercises.fromJson(ex, index, startTime));
      index++;
      startTime += exercises.last.prelude! + exercises.last.duration!;
    }

    return Workout(title: json['title'], exercises: exercises);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'exercises': exercises,
    };
  }

  Workout copyWith({String? title}) =>
      Workout(title: title ?? this.title, exercises: exercises);

  int getTotalTime() =>
      exercises.fold(0, (prev, ex) => prev + ex.duration! + ex.prelude!);

  Exercises getExercise(int? elapsed) =>
      exercises.lastWhere((element) => element.startTime! <= elapsed!);
  @override
  List<Object?> get props => [title, exercises];
}
