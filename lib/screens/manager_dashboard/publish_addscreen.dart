import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PublishAdScreen extends StatefulWidget {
  const PublishAdScreen({super.key});

  @override
  State<PublishAdScreen> createState() => _PublishAdScreenState();
}

class _PublishAdScreenState extends State<PublishAdScreen> {
  final _formKey = GlobalKey<FormState>();
  final _adNameController = TextEditingController();
  final _adDescController = TextEditingController();
  final _adDurationController = TextEditingController();
  final _targetAudienceController = TextEditingController();
  final _budgetController = TextEditingController();

  @override
  void dispose() {
    _adNameController.dispose();
    _adDescController.dispose();
    _adDurationController.dispose();
    _targetAudienceController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  Future<void> _publishAd() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('ads').add({
        'adName': _adNameController.text.trim(),
        'adDescription': _adDescController.text.trim(),
        'adDuration': _adDurationController.text.trim(),
        'targetAudience': _targetAudienceController.text.trim(),
        'budget': _budgetController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ad published!')),
      );
      _formKey.currentState!.reset();
    }
  }

  InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _adNameController,
                decoration: _inputDecoration('Ad Name'),
                validator: (val) => val == null || val.isEmpty ? 'Enter ad name' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _adDescController,
                decoration: _inputDecoration('Ad Description'),
                minLines: 1,
                maxLines: 3,
                validator: (val) => val == null || val.isEmpty ? 'Enter ad description' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _adDurationController,
                decoration: _inputDecoration('Ad Duration'),
                validator: (val) => val == null || val.isEmpty ? 'Enter ad duration' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _targetAudienceController,
                decoration: _inputDecoration('Target Audience'),
                validator: (val) => val == null || val.isEmpty ? 'Enter target audience' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _budgetController,
                decoration: _inputDecoration('Budget'),
                keyboardType: TextInputType.number,
                validator: (val) => val == null || val.isEmpty ? 'Enter budget' : null,
              ),
              const SizedBox(height: 32),
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
                  onPressed: _publishAd,
                  child: const Text('Publish Ad'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
