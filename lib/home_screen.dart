import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Column(
        children: [
          // Narrower & taller rectangle with "Pet" label
          Container(
            width: MediaQuery.of(context).size.width * 0.7, // 70% of screen width
            height: 120, // Slightly taller
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Adjusted margin
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
          Expanded(
            child: Center(
              child: Text('Welcome to the Home Screen!'),
            ),
          ),
        ],
      ),
    );
  }
}