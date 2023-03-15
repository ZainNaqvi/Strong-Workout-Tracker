import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_flutter_app/core/app_extension.dart';
import 'package:workout_flutter_app/core/app_style.dart';
import 'package:workout_flutter_app/src/business_logic/cubit/workout/workout_cubits.dart';
import 'package:workout_flutter_app/src/business_logic/cubit/workout/workout_state.dart';
import 'package:workout_flutter_app/src/data/model/exercise_model.dart';

import '../../data/model/workout_model.dart';

class StartWorkout extends StatelessWidget {
  const StartWorkout({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _getStates(Workout workout, int workoutElapsed) {
      int workoutTotal = workout.getTotalTime();
      Exercises exercise = workout.getExercise(workoutElapsed);
      int exerciseElapsed = workoutElapsed - exercise.startTime!;

      int exerciseRenaming = exercise.prelude! - workoutElapsed;
      bool isPrelude = exerciseElapsed < exercise.prelude!;
      int exerciseTotal = isPrelude ? exercise.prelude! : exercise.duration!;

      if (!isPrelude) {
        exerciseElapsed -= exercise.prelude!;
        exerciseRenaming += exercise.duration!;
      }

      return {
        "workoutTitle": workout.title,
        "workoutProgress": workoutElapsed / workoutTotal,
        "workoutElapsed": workoutElapsed,
        "totalExercises": workout.exercises.length,
        "currentExerciseIndex": exercise.index!.toDouble(),
        "workoutRemaining": workoutTotal - workoutElapsed,
        "exerciseRemaining": exerciseRenaming,
        "exerciseProgress": exerciseElapsed / exerciseTotal,
        "isPrelude": isPrelude,
      };
    }

    return BlocConsumer<WorkoutCubit, WorkoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        var stats = _getStates(state.workout!, state.elapsed!);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              state.workout!.title.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            leading: BackButton(
              color: Colors.white,
              onPressed: () => BlocProvider.of<WorkoutCubit>(context).goHome(),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                LinearProgressIndicator(
                  backgroundColor: Colors.blue[100],
                  minHeight: 18,
                  value: stats['workoutProgress'],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(formatTime(stats['workoutElapsed'], true)),
                      DotsIndicator(
                        dotsCount: stats['totalExercises'],
                        position: stats['currentExerciseIndex'],
                      ),
                      Text('-${formatTime(stats['workoutRemaining'], true)}'),
                    ],
                  ),
                ),
                const Spacer(),
                InkWell(
                  child: Stack(
                    alignment: const Alignment(0, 0),
                    children: [
                      Center(
                        child: SizedBox(
                          width: 220,
                          height: 220,
                          child: CircularProgressIndicator(
                            strokeWidth: 25,
                            value: stats['exerciseProgress'],
                            valueColor: AlwaysStoppedAnimation<Color>(
                                stats['isPrelude'] ? Colors.red : Colors.blue),
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                            width: 300,
                            height: 300,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Image.asset('assets/stopwatch.png'),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
