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

class WorkoutEditing extends WorkoutState {
  final int index;
  final int? exIndex;
  const WorkoutEditing(Workout workout, this.index, this.exIndex)
      : super(workout, index);

  @override
  List<Object?> get props => [workout, index, exIndex];
}

class WorkoutInProgress extends WorkoutState {
  const WorkoutInProgress(Workout? workout, int? elapsed)
      : super(workout, elapsed);

  @override
  List<Object?> get props => [workout, elapsed];
}
