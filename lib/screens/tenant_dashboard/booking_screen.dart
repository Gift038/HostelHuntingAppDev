import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book Hostel")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: "Room Type"),
              items: ['Single', 'Double']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (_) {},
            ),
            TextFormField(decoration: InputDecoration(labelText: 'Duration of Stay')),
            TextFormField(decoration: InputDecoration(labelText: 'Move-in Date')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/payment'),
              child: Text('Next'),
            )
          ],
        ),
      ),
    );
  }
}
