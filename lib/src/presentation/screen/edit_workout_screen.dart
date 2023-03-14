import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:workout_flutter_app/core/app_extension.dart';
import 'package:workout_flutter_app/core/app_style.dart';
import 'package:workout_flutter_app/src/business_logic/cubit/workout/workout_state.dart';
import 'package:workout_flutter_app/src/data/model/exercise_model.dart';
import 'package:workout_flutter_app/src/data/model/workout_model.dart';

import '../../business_logic/cubit/workout/workout_cubits.dart';
import '../../business_logic/cubit/workouts/workouts_cubit.dart';
import 'exercise_editing_screen.dart';

class EditWorkoutScreen extends StatelessWidget {
  const EditWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutCubit, WorkoutState>(
      builder: (context, state) {
        WorkoutEditing we = state as WorkoutEditing;
        return WillPopScope(
          onWillPop: () async {
            BlocProvider.of<WorkoutCubit>(context).goHome();
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              title: InkWell(
                onLongPress: () async {
                  TextEditingController controller = TextEditingController(
                    text: we.workout!.title,
                  );

                  return (await showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      content: TextField(
                        controller: controller,
                        decoration:
                            const InputDecoration(labelText: 'Workout Title'),
                        keyboardType: TextInputType.text,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            if (controller.text.isNotEmpty) {
                              Navigator.pop(context);
                              Workout newWorkout =
                                  we.workout!.copyWith(title: controller.text);
                              BlocProvider.of<WorkoutsCubit>(context)
                                  .saveWorkout(newWorkout, we.index);
                              BlocProvider.of<WorkoutCubit>(context)
                                  .editWorkouts(newWorkout, we.index);
                            }
                          },
                          child: const Text('rename'),
                        )
                      ],
                    ),
                  ));
                },
                child: Text(
                  we.workout!.title!,
                  style: h2Style,
                ),
              ),
              leading: BackButton(
                  color: Colors.white,
                  onPressed: () {
                    BlocProvider.of<WorkoutCubit>(context).goHome();
                  }),
            ),
            body: ListView.builder(
              itemCount: we.workout!.exercises.length,
              itemBuilder: (context, index) {
                Exercises ex = we.workout!.exercises[index];

                if (we.exIndex == index) {
                  return ExerciseEditingScreen(
                    workout: we.workout!,
                    exIndex: we.exIndex!,
                    index: we.index,
                  );
                }
                return ListTile(
                  leading:
                      Text(formatTime(ex.prelude!, true)).fadeAnimation(0.2),
                  trailing:
                      Text(formatTime(ex.duration!, true)).fadeAnimation(0.2),
                  title: Text(ex.title!).fadeAnimation(0.2),
                  onTap: () => BlocProvider.of<WorkoutCubit>(context)
                      .editExercise(index),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
