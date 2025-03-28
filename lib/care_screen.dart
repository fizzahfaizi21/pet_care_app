import 'package:flutter/material.dart';
import 'package:petappgroup/pet_utils.dart';

class CareScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Care Screen')),
      body: Column(
        children: [
          // Replace the existing container with PetUtils widget
          PetUtils.createPetWidget(context),

          Expanded(child: Center(child: Text('Welcome to the Care Screen!'))),
        ],
      ),
    );
  }
}
