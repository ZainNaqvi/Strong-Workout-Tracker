import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_flutter_app/core/app_theme.dart';
import 'package:workout_flutter_app/src/business_logic/cubit/workout/workouts_cubit.dart';
import 'package:workout_flutter_app/src/presentation/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: BlocProvider<WorkoutCubit>(
        create: (context) {
          WorkoutCubit workoutCubit = WorkoutCubit();
          if (workoutCubit.state.isEmpty) {
            workoutCubit.loadWorkout();
          }
          return workoutCubit;
        },
        child: const HomeScreen(),
      ),
    );
  }
}
