// hostel_list_screen.dart
import 'package:flutter/material.dart';

class HostelListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> hostels = [
    {"name": "Greenwood Hostel", "price": "UGX 300,000", "image": "https://via.placeholder.com/150"},
    {"name": "Kampala Hostel", "price": "UGX 350,000", "image": "https://via.placeholder.com/150"},
  ];

  HostelListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Matching Hostels")),
      body: ListView.builder(
        itemCount: hostels.length,
        itemBuilder: (context, index) {
          final hostel = hostels[index];
          return ListTile(
            leading: Image.network(hostel['image']),
            title: Text(hostel['name']),
            subtitle: Text(hostel['price']),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.pushNamed(context, '/hostel_detail', arguments: hostel),
          );
        },
      ),
    );
  }
}
