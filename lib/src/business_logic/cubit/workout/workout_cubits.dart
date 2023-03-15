import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:wakelock/wakelock.dart';
import 'package:workout_flutter_app/src/data/model/workout_model.dart';

import 'workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(const WorkoutInitial());
  Timer? _timer;
  editWorkouts(Workout workout, int index) =>
      emit(WorkoutEditing(workout, index, null));

  editExercise(int index) => emit(
      WorkoutEditing(state.workout!, (state as WorkoutEditing).index, index));

  onTick(Timer timer) {
    if (state is WorkoutInProgress) {
      WorkoutInProgress wip = state as WorkoutInProgress;
      if (wip.elapsed! < wip.workout!.getTotalTime()) {
        emit(WorkoutInProgress(wip.workout, wip.elapsed! + 1));
        Logger logger = Logger();
        logger.d("... My elapsed time ${wip.elapsed}");
      } else {
        _timer!.cancel();
        Wakelock.disable();
        emit(const WorkoutInitial());
      }
    }
  }

  startWorkout(Workout? workout, [int? index]) {
    Wakelock.enable();
    if (index != null) {
    } else {
      emit(WorkoutInProgress(workout, 0));
    }
    _timer = Timer.periodic(const Duration(seconds: 1), onTick);
  }

  void goHome() => emit(const WorkoutInitial());
}
