import 'package:flutter/material.dart';
import 'package:petappgroup/pet_utils.dart';

class RemindersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reminders Screen')),
      body: Column(
        children: [
          // Replace the existing container with PetUtils widget
          PetUtils.createPetWidget(context),

          Expanded(
            child: Center(child: Text('Welcome to the Reminders Screen!')),
          ),
        ],
      ),
    );
  }
}
