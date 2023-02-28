import 'package:equatable/equatable.dart';
import 'package:workout_flutter_app/src/data/model/workout_model.dart';

abstract class WorkoutState extends Equatable {
  final Workout? workout;
  final int? elapsed;

  const WorkoutState(this.workout, this.elapsed);
}

class WorkoutInitial extends WorkoutState {
  const WorkoutInitial() : super(null, 0);
  @override
  List<Object?> get props => [];
}

class WorkoutEdit extends WorkoutState {
  final int index;
  const WorkoutEdit(Workout workout, this.index) : super(workout, index);

  @override
  List<Object?> get props => [workout, index];
}
