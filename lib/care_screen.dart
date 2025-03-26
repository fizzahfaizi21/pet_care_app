import 'package:flutter/material.dart';

class CareScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Care Screen'),
      ),
      body: Column(
        children: [
          // Narrower & taller rectangle with "Pet" label
          Container(
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
          ),
          Expanded(
            child: Center(
              child: Text('Welcome to the Care Screen!'),
            ),
          ),
        ],
      ),
    );
  }
}