import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_flutter_app/core/app_extension.dart';

import '../../../core/app_style.dart';
import '../../business_logic/cubit/workout/workouts_cubit.dart';
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
      body:
          SingleChildScrollView(child: BlocBuilder<WorkoutCubit, List<Workout>>(
        builder: (context, workouts) {
          return ExpansionPanelList.radio(
            children: workouts
                .map(
                  (workouts) => ExpansionPanelRadio(
                    value: workouts,
                    headerBuilder: (context, isExpanded) => ListTile(
                      onTap: null,
                      leading: const IconButton(
                        onPressed: null,
                        icon: Icon(Icons.edit),
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
                        leading: const Text("00:23"),
                        visualDensity: const VisualDensity(
                          horizontal: 0,
                          vertical: VisualDensity.maximumDensity,
                        ),
                        title: Text(workouts.exercises[index].title!),
                        trailing: const IconButton(
                          onPressed: null,
                          icon: Icon(Icons.star),
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
