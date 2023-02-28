import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_flutter_app/core/app_extension.dart';
import 'package:workout_flutter_app/src/business_logic/cubit/workout/workout_cubits.dart';

import '../../../core/app_style.dart';
import '../../business_logic/cubit/workouts/workouts_cubit.dart';
import '../../data/model/workout_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bloc Cubits",
          style: h2Style,
        ),
      ),
      body: SingleChildScrollView(
          child: BlocBuilder<WorkoutsCubit, List<Workout>>(
        builder: (context, workout) {
          return ExpansionPanelList.radio(
            children: workout
                .map(
                  (workouts) => ExpansionPanelRadio(
                    value: workouts,
                    headerBuilder: (ctx, isExpanded) => ListTile(
                      onTap: null,
                      leading: IconButton(
                        onPressed: () => BlocProvider.of<WorkoutCubit>(context)
                            .editWorkouts(
                                workouts, (workout).indexOf(workouts)),
                        icon: const Icon(Icons.edit),
                      ),
                      visualDensity: const VisualDensity(
                        horizontal: 0,
                        vertical: VisualDensity.maximumDensity,
                      ),
                      title: Text(
                        workouts.title!.addOverFlow,
                        maxLines: 1,
                      ),
                      trailing: Text(formatTime(workouts.getTotalTime(), true)),
                    ),
                    body: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: workouts.exercises.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => ListTile(
                        onTap: null,
                        leading: IconButton(
                          onPressed: null,
                          icon: Text(
                            formatTime(
                                workouts.exercises[index].prelude!, true),
                            textAlign: TextAlign.end,
                          ).fadeAnimation(0.2),
                        ),
                        visualDensity: const VisualDensity(
                          horizontal: 0,
                          vertical: VisualDensity.maximumDensity,
                        ),
                        title: Text(workouts.exercises[index].title!)
                            .fadeAnimation(0.2),
                        trailing: Text(
                          formatTime(workouts.exercises[index].duration!, true),
                          textAlign: TextAlign.center,
                        ).fadeAnimation(0.2),
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        },
      )),
    );
  }
}
