import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

const Color coffeeBrown = Color(0xFF6F4E37); // Coffee brown
const Color lightCoffee = Color(0xFFD7CCC8); // Light coffee brown

class NotificationItem {
  final String title;
  final String body;
  final String type;
  final DateTime timestamp;

  NotificationItem({
    required this.title,
    required this.body,
    required this.type,
    required this.timestamp,
  });

  factory NotificationItem.fromFirestore(Map<String, dynamic> data) {
    return NotificationItem(
      title: data['title'] ?? '',
      body: data['body'] ?? '',
      type: data['type'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String? get userId => FirebaseAuth.instance.currentUser?.uid;
  late final FirebaseMessaging _messaging;

  @override
  void initState() {
    super.initState();
    _initFCM();
  }

  void _initFCM() async {
    _messaging = FirebaseMessaging.instance;
    // Request permissions on iOS
    await _messaging.requestPermission();
    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        final notif = message.notification!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${notif.title ?? ''}\n${notif.body ?? ''}'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Notifications')),
        body: const Center(child: Text('Not logged in')),
      );
    }

    return Scaffold(
      backgroundColor: lightCoffee,
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: coffeeBrown,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('notifications')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No notifications'));
          }
          final notifications = snapshot.data!.docs
              .map((doc) => NotificationItem.fromFirestore(doc.data() as Map<String, dynamic>))
              .toList();

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            itemCount: notifications.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final notif = notifications[index];
              return Card(
                color: Colors.white,
                child: ListTile(
                  leading: Icon(_getIcon(notif.type), color: coffeeBrown),
                  title: Text(
                    notif.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: coffeeBrown),
                  ),
                  subtitle: Text(
                    notif.body,
                    style: const TextStyle(color: Colors.brown),
                  ),
                  trailing: Text(
                    '${notif.timestamp.hour}:${notif.timestamp.minute}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.brown[100],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: coffeeBrown,
        unselectedItemColor: lightCoffee,
        currentIndex: 1, // Notifications tab
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/dashboard');
              break;
            case 1:
              // Already on notifications
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/profile');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/manager');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.cases_rounded), label: 'Manager'),
        ],
      ),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'booking_confirmed':
        return Icons.check_circle_outline;
      case 'checkin_reminder':
        return Icons.calendar_today;
      case 'hostel_update':
        return Icons.notifications;
      case 'booking_canceled':
        return Icons.cancel_outlined;
      case 'new_review':
        return Icons.star_border;
      default:
        return Icons.notifications_none;
    }
  }

  Future<void> addNotificationToFirestore({
    required String userId,
    required String title,
    required String body,
    required String type,
    DateTime? timestamp,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .add({
      'title': title,
      'body': body,
      'type': type,
      'timestamp': timestamp ?? DateTime.now(),
    });
  }
}
