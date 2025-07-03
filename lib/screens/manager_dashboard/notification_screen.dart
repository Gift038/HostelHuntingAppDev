import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  // Color scheme
  static const Color coffeeBrown = Color(0xFF4B2E19); // Dark coffee brown
  static const Color dashboarcofffeebrownlight = Colors.white;

  static const List<String> notifications = [
    'The gym equipment is broken',
    'The elevator is not working',
    'The wifi is slow',
  ];

  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF3E3),
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: coffeeBrown,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: notifications
            .map((note) => ListTile(
                  title: Text(note, style: const TextStyle(color: coffeeBrown)),
                ))
            .toList(),
      ),
    );
  }
}
