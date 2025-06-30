import 'package:flutter/material.dart';

class ManagersDashboardScreen extends StatelessWidget {
  const ManagersDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manager's Dashboard")),
      body: const Center(
        child: Text("Manager's Dashboard Page"),
      ),
    );
  }
}
