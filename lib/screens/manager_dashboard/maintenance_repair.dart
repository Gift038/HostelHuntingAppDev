import 'package:flutter/material.dart';

class MaintenanceRepairsScreen extends StatefulWidget {
  const MaintenanceRepairsScreen({super.key});

  @override
  State<MaintenanceRepairsScreen> createState() => _MaintenanceRepairsScreenState();
}

class _MaintenanceRepairsScreenState extends State<MaintenanceRepairsScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedIssue;
  final _roomController = TextEditingController();
  final _descController = TextEditingController();

  final List<String> _issueTypes = [
    'Plumbing',
    'Electrical',
    'Furniture',
    'Internet',
    'Other',
  ];

  final List<Map<String, String>> _announcements = [
    {'title': 'New hostel rules', 'date': '2 days ago'},
    {'title': 'Facility updates', 'date': '1 week ago'},
  ];

  @override
  void dispose() {
    _roomController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO: Send data to backend or Firestore
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Issue submitted!')),
      );
      _formKey.currentState!.reset();
      setState(() {
        _selectedIssue = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('Maintenance & Repairs'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: ListView(
          children: [
            const SizedBox(height: 8),
            const Text(
              'Report an Issue',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedIssue,
                    items: _issueTypes
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                    onChanged: (val) => setState(() => _selectedIssue = val),
                    decoration: InputDecoration(
                      hintText: 'Select',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (val) => val == null ? 'Please select an issue' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _roomController,
                    decoration: InputDecoration(
                      hintText: 'Room Number',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (val) => val == null || val.isEmpty ? 'Enter room number' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _descController,
                    minLines: 3,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Describe the issue',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (val) => val == null || val.isEmpty ? 'Enter a description' : null,
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _submit,
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'Announcements',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            ..._announcements.map((a) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(a['title']!, style: const TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: Text(a['date']!, style: const TextStyle(color: Colors.grey)),
                )),
          ],
        ),
      ),
    );
  }
}
