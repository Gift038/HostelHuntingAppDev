import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> user = {
      "name": "Ethan Carter",
      "gender": "Male",
      "email": "ethan@hostelhunt.com"
    };
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: user.entries.map((e) => ListTile(title: Text(e.key), subtitle: Text(e.value))).toList(),
        ),
      ),
    );
  }
}
