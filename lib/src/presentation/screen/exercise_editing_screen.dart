import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:workout_flutter_app/core/app_extension.dart';
import 'package:workout_flutter_app/src/data/model/workout_model.dart';

import '../../business_logic/cubit/workouts/workouts_cubit.dart';

class ExerciseEditingScreen extends StatefulWidget {
  final Workout workout;
  int exIndex;
  final int index;
  ExerciseEditingScreen(
      {super.key,
      required this.workout,
      required this.exIndex,
      required this.index});

  @override
  State<ExerciseEditingScreen> createState() => _ExerciseEditingScreenState();
}

class _ExerciseEditingScreenState extends State<ExerciseEditingScreen> {
  TextEditingController? _title;
  @override
  void initState() {
    _title = TextEditingController(
        text: widget.workout.exercises[widget.exIndex].title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: InkWell(
                  onLongPress: () async {
                    TextEditingController controller = TextEditingController(
                        text: widget.workout.exercises[widget.exIndex].prelude!
                            .toString());

                    return (await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: TextField(
                          controller: controller,
                          decoration:
                              const InputDecoration(labelText: 'Prelude'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {
                                widget.workout.exercises[widget.exIndex] =
                                    widget.workout.exercises[widget.exIndex]
                                        .copyWith(
                                  prelude: int.parse(controller.text),
                                );
                              });

                              BlocProvider.of<WorkoutsCubit>(context)
                                  .saveWorkout(widget.workout, widget.index);
                            },
                            child: const Text('save'),
                          )
                        ],
                      ),
                    ));
                  },
                  child: NumberPicker(
                    onChanged: (value) {
                      setState(() {
                        widget.workout.exercises[widget.exIndex] = widget
                            .workout.exercises[widget.exIndex]
                            .copyWith(prelude: value);
                      });

                      BlocProvider.of<WorkoutsCubit>(context)
                          .saveWorkout(widget.workout, widget.index);
                    },
                    maxValue: 3500,
                    minValue: 0,
                    itemHeight: 30,
                    value: widget.workout.exercises[widget.exIndex].prelude!,
                    textMapper: (numberText) =>
                        formatTime(int.parse(numberText), false),
                  )),
            ),
            Expanded(
              flex: 4,
              child: TextField(
                textAlign: TextAlign.center,
                controller: _title,
                onChanged: (value) => setState(() {
                  setState(() {
                    widget.workout.exercises[widget.exIndex] = widget
                        .workout.exercises[widget.exIndex]
                        .copyWith(title: value);
                  });
                  BlocProvider.of<WorkoutsCubit>(context)
                      .saveWorkout(widget.workout, widget.index);
                }),
              ),
            ),
            Expanded(
              child: InkWell(
                  onLongPress: () async {
                    TextEditingController controller = TextEditingController(
                        text: widget.workout.exercises[widget.exIndex].duration!
                            .toString());

                    return (await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: TextField(
                          controller: controller,
                          decoration:
                              const InputDecoration(labelText: 'Duration'),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {
                                widget.workout.exercises[widget.exIndex] =
                                    widget.workout.exercises[widget.exIndex]
                                        .copyWith(
                                  duration: int.parse(controller.text),
                                );
                              });

                              BlocProvider.of<WorkoutsCubit>(context)
                                  .saveWorkout(widget.workout, widget.index);
                            },
                            child: const Text('save'),
                          )
                        ],
                      ),
                    ));
                  },
                  child: NumberPicker(
                    maxValue: 3500,
                    minValue: 0,
                    itemHeight: 30,
                    value: widget.workout.exercises[widget.exIndex].duration!,
                    textMapper: (numberText) =>
                        formatTime(int.parse(numberText), false),
                    onChanged: (value) => setState(() {
                      widget.workout.exercises[widget.exIndex] = widget
                          .workout.exercises[widget.exIndex]
                          .copyWith(duration: value);
                      BlocProvider.of<WorkoutsCubit>(context)
                          .saveWorkout(widget.workout, widget.index);
                    }),
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
