import 'package:flutter/material.dart';
import 'package:petappgroup/pet_utils.dart';
import 'illness_details_screen.dart';

class IllnessScreen extends StatelessWidget {
  final List<String> illnesses = [
    "Upper Respiratory Infection (URI)",
    "Feline Lower Urinary Tract Disease (FLUTD)",
    "Hairballs",
    "Fleas & Ticks",
    "Worms",
    "Dental Disease",
    "Ear Mites",
    "Diarrhea",
    "Vomiting",
    "Obesity",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Illness Screen')),
      body: Column(
        children: [
          // Replace the existing container with PetUtils widget
          PetUtils.createPetWidget(context),

          // Rest of the existing code remains the same
          Expanded(
            child: ListView.builder(
              itemCount: illnesses.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[100],
                      foregroundColor: Colors.blue[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => IllnessDetailsScreen(
                                illnessName: illnesses[index],
                              ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        illnesses[index],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
