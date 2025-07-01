
import 'package:flutter/material.dart';

class SearchFilterScreen extends StatelessWidget {
  const SearchFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search & Filter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: "Distance from university"),
              items: ['<1km', '1-5km', '>5km']
                  .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                  .toList(),
              onChanged: (value) {},
            ),
            TextFormField(decoration: InputDecoration(labelText: 'Price Range')),
            TextFormField(decoration: InputDecoration(labelText: 'Academic Program')),
            SwitchListTile(title: Text('Disability Accommodation'), value: false, onChanged: (_) {}),
            CheckboxListTile(title: Text('WiFi'), value: true, onChanged: (_) {}),
            CheckboxListTile(title: Text('Laundry'), value: false, onChanged: (_) {}),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/results');
              },
              child: Text("Search"),
            ),
          ],
        ),
      ),
    );
  }
}
