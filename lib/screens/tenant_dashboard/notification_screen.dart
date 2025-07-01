import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final List<String> notifications = [
    'Booking confirmed at Greenwood Hostel',
    'Payment successful',
    'New hostel listings available',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notifications")),
      body: ListView(
        children: notifications.map((note) => ListTile(title: Text(note))).toList(),
      ),
    );
  }
}
