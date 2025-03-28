import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:petappgroup/pet_utils.dart';

class RemindersScreen extends StatefulWidget {
  @override
  _RemindersScreenState createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  List<Reminder> _reminders = [];
  final TextEditingController _reminderController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _initializeNotifications();
    _loadReminders();
    tz_data.initializeTimeZones();
    _requestNotificationPermissions();
  }

  Future<void> _requestNotificationPermissions() async {
    try {
      final bool? result = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      
      debugPrint('Notification permission granted: $result');
    } catch (e) {
      debugPrint('Error requesting notification permissions: $e');
    }
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification tap
      },
    );
  }

  Future<void> _scheduleNotification(Reminder reminder) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'pet_reminders_channel',
      'Pet Reminders',
      channelDescription: 'Channel for pet care reminders',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      visibility: NotificationVisibility.public,
      playSound: true,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      reminder.id,
      'Pet Reminder',
      reminder.text,
      tz.TZDateTime.from(
        DateTime(
          reminder.date.year,
          reminder.date.month,
          reminder.date.day,
          reminder.time.hour,
          reminder.time.minute,
        ),
        tz.local,
      ),
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
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

  Future<void> _loadReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final reminders = prefs.getStringList('reminders') ?? [];
    
    setState(() {
      _reminders = reminders.map((json) => Reminder.fromJson(json)).toList();
    });
  }

  Future<void> _saveReminders() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'reminders',
      _reminders.map((reminder) => reminder.toJson()).toList(),
    );
  }

  void _addReminder() {
    if (_reminderController.text.isEmpty) return;

    final newReminder = Reminder(
      id: DateTime.now().millisecondsSinceEpoch,
      text: _reminderController.text,
      date: _selectedDate,
      time: _selectedTime,
    );

    setState(() {
      _reminders.add(newReminder);
      _reminderController.clear();
    });

    _scheduleNotification(newReminder);
    _saveReminders();
  }

  Future<void> _deleteReminder(int index) async {
    final reminder = _reminders[index];
    
    await flutterLocalNotificationsPlugin.cancel(reminder.id);
    
    setState(() {
      _reminders.removeAt(index);
    });
    
    await _saveReminders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reminders')),
      body: Column(
        children: [
          // Replace the existing container with PetUtils widget
          PetUtils.createPetWidget(context),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _reminderController,
                  decoration: const InputDecoration(
                    labelText: 'Reminder Note',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: const Text('Set Date'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _selectTime(context),
                        child: const Text('Set Time'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _addReminder,
                  child: const Text('Add Reminder'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: _reminders.isEmpty
                ? const Center(child: Text('No reminders yet'))
                : ListView.builder(
                    itemCount: _reminders.length,
                    itemBuilder: (context, index) {
                      final reminder = _reminders[index];
                      return Dismissible(
                        key: Key(reminder.id.toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) => _deleteReminder(index),
                        child: ListTile(
                          title: Text(reminder.text),
                          subtitle: Text(
                            '${reminder.date.toLocal().toString().split(' ')[0]} '
                            'at ${reminder.time.format(context)}',
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteReminder(index),
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

class Reminder {
  final int id;
  final String text;
  final DateTime date;
  final TimeOfDay time;

  Reminder({
    required this.id,
    required this.text,
    required this.date,
    required this.time,
  });

  String toJson() {
    return '$id|$text|${date.millisecondsSinceEpoch}|${time.hour}|${time.minute}';
  }

  factory Reminder.fromJson(String json) {
    final parts = json.split('|');
    return Reminder(
      id: int.parse(parts[0]),
      text: parts[1],
      date: DateTime.fromMillisecondsSinceEpoch(int.parse(parts[2])),
      time: TimeOfDay(hour: int.parse(parts[3]), minute: int.parse(parts[4])),
    );
  }
}