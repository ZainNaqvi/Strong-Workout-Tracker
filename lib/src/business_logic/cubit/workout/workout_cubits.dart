import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_flutter_app/src/data/model/workout_model.dart';

import 'workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(const WorkoutInitial());

  editWorkouts(Workout workout, int index) => emit(WorkoutEdit(workout, index));
}
