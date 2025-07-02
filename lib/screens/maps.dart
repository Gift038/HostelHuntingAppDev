import 'package:flutter/material.dart';

class MapsScreen extends StatelessWidget {
  const MapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final String university = args != null && args['university'] != null ? args['university'] : '';
    final List hostels = args != null && args['hostels'] != null ? args['hostels'] : [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Map for $university'),
      ),
      body: Column(
        children: [
          // Placeholder for Google Map
          Container(
            height: 300,
            color: Colors.grey[300],
            child: const Center(child: Text('Google Map Placeholder')),
          ),
          const SizedBox(height: 16),
          Text('Hostels around $university:', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: hostels.length,
              itemBuilder: (context, index) {
                final hostel = hostels[index];
                return ListTile(
                  leading: Image.asset(hostel['imagePath'], width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(hostel['name']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 