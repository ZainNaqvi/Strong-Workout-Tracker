import 'package:flutter/material.dart';

class EditWorkoutScreen extends StatelessWidget {
  const EditWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercises"),
        leading: BackButton(onPressed: () {}),
      ),
      body: const Center(child: Text("Body of the scaffold")),
    );
  }
}
