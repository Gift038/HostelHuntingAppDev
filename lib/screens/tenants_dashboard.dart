import 'package:flutter/material.dart';

class TenantsDashboardScreen extends StatelessWidget {
  const TenantsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tenant's Dashboard")),
      body: const Center(
        child: Text("Tenant's Dashboard Page"),
      ),
    );
  }
}
