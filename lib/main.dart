import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workout_flutter_app/core/app_theme.dart';
import 'package:workout_flutter_app/src/business_logic/cubit/workout/workout_cubits.dart';
import 'package:workout_flutter_app/src/business_logic/cubit/workout/workout_state.dart';
import 'package:workout_flutter_app/src/business_logic/cubit/workouts/workouts_cubit.dart';
import 'package:workout_flutter_app/src/presentation/screen/home_screen.dart';

import 'src/presentation/screen/edit_workout_screen.dart';
import 'src/presentation/screen/start_workout_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<WorkoutsCubit>(
            create: (context) {
              WorkoutsCubit workoutCubit = WorkoutsCubit();
              if (workoutCubit.state.isEmpty) {
                workoutCubit.loadWorkout();
              }
              return workoutCubit;
            },
          ),
          BlocProvider(
            create: (context) => WorkoutCubit(),
          ),
        ],
        child: BlocBuilder<WorkoutCubit, WorkoutState>(
          builder: (context, state) {
            if (state is WorkoutInitial) {
              return const HomeScreen();
            } else if (state is WorkoutEditing) {
              return const EditWorkoutScreen();
            }
            return const StartWorkout();
          },
        ),
      ),
    );
  }
}
