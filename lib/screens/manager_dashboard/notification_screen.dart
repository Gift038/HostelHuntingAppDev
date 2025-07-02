import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  // ✅ Make it static const
  static const List<String> notifications = [
    'The gym equipment is broken',
    'The elevator is not working',
    'The wifi is slow',
  ];

  const NotificationScreen({super.key}); // ✅ Const constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: ListView(
        children: notifications
            .map((note) => ListTile(title: Text(note)))
            .toList(),
      ),
    );
  }
}
