import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> notifications = [
      'Booking confirmed at Greenwood Hostel',
      'Payment successful',
      'New hostel listings available',
    ];
    return Scaffold(
      appBar: AppBar(title: Text("Notifications")),
      body: ListView(
        children: notifications.map((note) => ListTile(title: Text(note))).toList(),
      ),
    );
  }
}
