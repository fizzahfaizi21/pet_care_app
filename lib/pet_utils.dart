import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PetUtils {
  // Retrieve pet name
  static Future<String?> getPetName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('petName');
  }

  // Retrieve pet color
  static Future<String?> getPetColor() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('petColor');
  }

  // Generate image path based on color
  static String getPetImagePath(String color) {
    // Assuming you'll have these images in your assets
    switch (color.toLowerCase()) {
      case 'black':
        return 'lib/assets/blackcat.png';
      case 'grey':
        return 'lib/assets/greycat.png';
      case 'brown':
        return 'lib/assets/browncat.png';
      case 'orange':
        return 'lib/assets/orangecat.png';
      case 'white':
        return 'lib/assets/whitecat.png';
      default:
        return 'lib/assets/blackcat.png'; // Default fallback
    }
  }

  // Method to create a reusable pet widget
  static Widget createPetWidget(BuildContext context) {
    return FutureBuilder<String?>(
      future: Future.wait([
        getPetName(),
        getPetColor(),
      ]).then((values) => values[1]),
      builder: (context, colorSnapshot) {
        if (!colorSnapshot.hasData) {
          return _defaultPetContainer(context);
        }

        return FutureBuilder<String?>(
          future: getPetName(),
          builder: (context, nameSnapshot) {
            if (!nameSnapshot.hasData) {
              return _defaultPetContainer(context);
            }

            return Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 120,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    getPetImagePath(colorSnapshot.data!),
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 16),
                  Text(
                    nameSnapshot.data!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Fallback method for default pet container
  static Widget _defaultPetContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 120,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
    );
  }
}
