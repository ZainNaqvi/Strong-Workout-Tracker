import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_flutter_app/core/app_extension.dart';
import 'package:workout_flutter_app/src/business_logic/cubit/workout/workout_state.dart';
import 'package:workout_flutter_app/src/data/model/exercise_model.dart';

import '../../business_logic/cubit/workout/workout_cubits.dart';

class EditWorkoutScreen extends StatelessWidget {
  const EditWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkoutCubit, WorkoutState>(
      builder: (context, state) {
        WorkoutEdit we = state as WorkoutEdit;
        print(we);
        return WillPopScope(
          onWillPop: () async {
            BlocProvider.of<WorkoutCubit>(context).goHome();
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Exercises"),
              leading: BackButton(onPressed: () {
                BlocProvider.of<WorkoutCubit>(context).goHome();
              }),
            ),
            body: ListView.builder(
              itemCount: we.workout!.exercises.length,
              itemBuilder: (context, index) {
                Exercises ex = we.workout!.exercises[index];
                return ListTile(
                  leading:
                      Text(formatTime(ex.prelude!, true)).fadeAnimation(0.2),
                  trailing:
                      Text(formatTime(ex.duration!, true)).fadeAnimation(0.2),
                  title: Text(ex.title!).fadeAnimation(0.2),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
