import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const Color coffeeBrown = Color(0xFF6F4E37); // Coffee brown
const Color lightCoffee = Color(0xFFD7CCC8); // Light coffee brown

class UserProfile {
  final String name;
  final String email;
  final String gender;
  final String contactInfo;
  final String joinedYear;
  final String avatarUrl;
  final List<PaymentHistory> paymentHistory;

  UserProfile({
    required this.name,
    required this.email,
    required this.gender,
    required this.contactInfo,
    required this.joinedYear,
    required this.avatarUrl,
    required this.paymentHistory,
  });
}

class PaymentHistory {
  final String title;
  final String date;
  final String roomType;
  final String amount;

  PaymentHistory({
    required this.title,
    required this.date,
    required this.roomType,
    required this.amount,
  });
}

class ProfileScreen extends StatelessWidget {
  final Map<String, String> user = {
    "name": "Ethan Carter",
    "gender": "Male",
    "email": "ethan@hostelhunt.com"
  };

  @override
  Widget build(BuildContext context) {
    final Color coffeeBrown = const Color(0xFF4B2E05);
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
