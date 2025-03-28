import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'care_screen.dart';
import 'illness_screen.dart';
import 'reminders_screen.dart';
import 'pet_onboarding_screen.dart';
import 'package:petappgroup/pet_utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Care App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PetProfileChecker(),
    );
  }
}

class PetProfileChecker extends StatefulWidget {
  @override
  _PetProfileCheckerState createState() => _PetProfileCheckerState();
}

class _PetProfileCheckerState extends State<PetProfileChecker> {
  @override
  void initState() {
    super.initState();
    _checkPetProfile();
  }

  Future<void> _checkPetProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final petName = prefs.getString('petName');
    final petColor = prefs.getString('petColor');

    if (petName == null || petColor == null) {
      // No pet profile, navigate to onboarding
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => PetOnboardingScreen()),
      );
    } else {
      // Pet profile exists, go to main app
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    CareScreen(),
    IllnessScreen(),
    RemindersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type:
            BottomNavigationBarType
                .fixed, // Added this line to support more than 3 items
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.blue[200],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Care'),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Illness',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Reminders',
          ),
        ],
      ),
    );
  }
}
