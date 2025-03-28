import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:petappgroup/pet_utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _foodController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  List<Map<String, dynamic>> _feedingLogs = [];

  @override
  void initState() {
    super.initState();
    _loadFeedingLogs();
  }

  Future<void> _loadFeedingLogs() async {
    final prefs = await SharedPreferences.getInstance();
    final logsJson = prefs.getStringList('feedingLogs') ?? [];
    setState(() {
      _feedingLogs =
          logsJson
              .map((log) => json.decode(log))
              .cast<Map<String, dynamic>>()
              .toList();
    });
  }

  Future<void> _saveFeedingLogs() async {
    final prefs = await SharedPreferences.getInstance();
    final logsJson = _feedingLogs.map((log) => json.encode(log)).toList();
    await prefs.setStringList('feedingLogs', logsJson);
  }

  void _addFeedingLog() {
    if (_foodController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please enter the food type')));
      return;
    }

    final newLog = {
      'food': _foodController.text.trim(),
      'date': _selectedDate.toIso8601String(),
      'time':
          '${_selectedTime.hour}:${_selectedTime.minute.toString().padLeft(2, '0')}',
    };

    setState(() {
      _feedingLogs.add(newLog);
      _foodController.clear();
      _selectedDate = DateTime.now();
      _selectedTime = TimeOfDay.now();
    });

    _saveFeedingLogs();
  }

  void _deleteLog(int index) {
    setState(() {
      _feedingLogs.removeAt(index);
    });
    _saveFeedingLogs();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Column(
        children: [
          // Pet Widget
          PetUtils.createPetWidget(context),

          // Feeding Log Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Feeding Log',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _foodController,
                  decoration: InputDecoration(
                    labelText: 'Food Type',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: Text(
                          'Date: ${_selectedDate.toLocal().toString().split(' ')[0]}',
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _selectTime(context),
                        child: Text('Time: ${_selectedTime.format(context)}'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _addFeedingLog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Log Feeding'),
                ),

                // Feeding Logs List
                SizedBox(height: 20),
                Text(
                  'Feeding History',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 150,
                  child:
                      _feedingLogs.isEmpty
                          ? Center(child: Text('No feeding logs yet'))
                          : ListView.builder(
                            itemCount: _feedingLogs.length,
                            itemBuilder: (context, index) {
                              final log =
                                  _feedingLogs[_feedingLogs.length - 1 - index];
                              return Dismissible(
                                key: Key(log.toString()),
                                background: Container(color: Colors.red),
                                onDismissed: (direction) {
                                  _deleteLog(_feedingLogs.length - 1 - index);
                                },
                                child: ListTile(
                                  title: Text('Food: ${log['food']}'),
                                  subtitle: Text(
                                    'Date: ${log['date'].split('T')[0]}, Time: ${log['time']}',
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed:
                                        () => _deleteLog(
                                          _feedingLogs.length - 1 - index,
                                        ),
                                  ),
                                ),
                              );
                            },
                          ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
