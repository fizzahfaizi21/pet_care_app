import 'package:flutter/material.dart';
import 'pet_utils.dart';
import 'package:petappgroup/pet_utils.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Column(
        children: [
          // Use the new pet widget method
          PetUtils.createPetWidget(context),

          Expanded(child: Center(child: Text('Welcome to the Home Screen!'))),
        ],
      ),
    );
  }
}
