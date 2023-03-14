import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:workout_flutter_app/src/data/model/workout_model.dart';

import 'workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(const WorkoutInitial());

  editWorkouts(Workout workout, int index) =>
      emit(WorkoutEditing(workout, index, null));

  editExercise(int index) {
    Logger logger = Logger();
    logger.d('... Selected index : $index');
    emit(
        WorkoutEditing(state.workout!, (state as WorkoutEditing).index, index));
  }

  void goHome() => emit(const WorkoutInitial());
}
