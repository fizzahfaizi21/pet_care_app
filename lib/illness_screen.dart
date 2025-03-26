import 'package:flutter/material.dart';
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
    "Obesity"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Illness Screen'),
      ),
      body: Column(
        children: [
          // Pet placeholder rectangle
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 120,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue),
            ),
            child: Center(
              child: Text(
                'Pet',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
            ),
          ),
          
          // Scrollable list of illness buttons
          Expanded(
            child: ListView.builder(
              itemCount: illnesses.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[100],
                      foregroundColor: Colors.blue[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () { // Ensure this is recognized
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IllnessDetailsScreen(
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
