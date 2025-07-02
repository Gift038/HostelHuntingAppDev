import 'package:flutter/material.dart';

class HostelDetailScreen extends StatelessWidget {
  const HostelDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hostel = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(title: Text(hostel['name'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(hostel['image']),
            Text('Facilities: WiFi, Security, Laundry, Power backup'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/booking'),
              child: Text('Book Now'),
            )
          ],
        ),
      ),
    );
  }
}
