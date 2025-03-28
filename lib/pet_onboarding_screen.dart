import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'package:petappgroup/pet_utils.dart';

class PetOnboardingScreen extends StatefulWidget {
  @override
  _PetOnboardingScreenState createState() => _PetOnboardingScreenState();
}

class _PetOnboardingScreenState extends State<PetOnboardingScreen> {
  final TextEditingController _nameController = TextEditingController();
  String _selectedColor = 'black'; // Default color

  // List of available cat colors
  final List<String> _catColors = ['black', 'grey', 'brown', 'orange', 'white'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meet Your Pet')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Let\'s set up your pet profile!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Enter Your Cat\'s Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Cat Color',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              value: _selectedColor,
              items:
                  _catColors.map((color) {
                    return DropdownMenuItem(
                      value: color,
                      child: Text(
                        color.substring(0, 1).toUpperCase() +
                            color.substring(1),
                      ),
                    );
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedColor = value!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _savePetProfile,
              child: Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _savePetProfile() async {
    // Validate inputs
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please enter your cat\'s name')));
      return;
    }

    // Save to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('petName', _nameController.text.trim());
    await prefs.setString('petColor', _selectedColor);

    // Navigate to main app
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => MyApp()));
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
