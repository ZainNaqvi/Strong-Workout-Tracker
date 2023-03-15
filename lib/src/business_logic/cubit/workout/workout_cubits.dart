import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakelock/wakelock.dart';
import 'package:workout_flutter_app/src/data/model/workout_model.dart';

import 'workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(const WorkoutInitial());

  editWorkouts(Workout workout, int index) =>
      emit(WorkoutEditing(workout, index, null));

  editExercise(int index) => emit(
      WorkoutEditing(state.workout!, (state as WorkoutEditing).index, index));

  startWorkout(Workout? workout, [int? index]) {
    Wakelock.enable();
    if (index != null) {
    } else {
      emit(WorkoutInProgress(workout, 0));
    }
  }

  void goHome() => emit(const WorkoutInitial());
}
