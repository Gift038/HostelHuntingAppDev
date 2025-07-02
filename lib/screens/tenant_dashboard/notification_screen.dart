import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

const Color coffeeBrown = Color(0xFF6F4E37); // Coffee brown
const Color lightCoffee = Color(0xFFD7CCC8); // Light coffee brown

<<<<<<< HEAD
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
=======
  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(item.icon, color: item.iconColor, size: 28),
              ),
              title: Text(
                item.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                item.subtitle,
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Notifications is selected
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Manager',
          ),
        ],
        onTap: (index) {
          // TODO: Implement navigation logic
          // Example:
          // if (index == 0) Navigator.pushReplacementNamed(context, '/home');
        },
      ),
>>>>>>> 9bc979c30b8a5fedccad210e58fd64f1bd4d58a5
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

  // Notification categories with icons
  final List<Map<String, dynamic>> _categories = [
    {'label': 'All', 'icon': Icons.all_inclusive},
    {'label': 'Booking Status', 'icon': Icons.check_circle_outline},
    {'label': 'Check-in Reminder', 'icon': Icons.calendar_today},
    {'label': 'Hostel Update', 'icon': Icons.notifications},
    {'label': 'New Review', 'icon': Icons.star_border},
  ];
  String _selectedCategory = 'All';

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

  List<NotificationItem> _filterNotifications(List<NotificationItem> notifications) {
    switch (_selectedCategory) {
      case 'Booking Status':
        return notifications.where((n) => n.type == 'booking_confirmed' || n.type == 'booking_canceled').toList();
      case 'Check-in Reminder':
        return notifications.where((n) => n.type == 'checkin_reminder').toList();
      case 'Hostel Update':
        return notifications.where((n) => n.type == 'hostel_update').toList();
      case 'New Review':
        return notifications.where((n) => n.type == 'new_review').toList();
      case 'All':
      default:
        return notifications;
    }
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
      body: Column(
        children: [
          // Category filter chips (modern horizontal scrollable row)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Row(
              children: _categories.map((cat) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  avatar: Icon(cat['icon'], size: 20, color: _selectedCategory == cat['label'] ? Colors.white : coffeeBrown),
                  label: Text(cat['label']),
                  selected: _selectedCategory == cat['label'],
                  onSelected: (selected) {
                    if (selected) setState(() => _selectedCategory = cat['label']);
                  },
                  selectedColor: coffeeBrown,
                  backgroundColor: lightCoffee,
                  labelStyle: TextStyle(
                    color: _selectedCategory == cat['label'] ? Colors.white : coffeeBrown,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )).toList(),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
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
                final filtered = _filterNotifications(notifications);
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final notif = filtered[index];
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
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: coffeeBrown,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: lightCoffee,
        currentIndex: 1, // Notifications tab
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/dashboard'); // Home
              break;
            case 1:
              // Already on notifications
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/profile'); // Profile
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/manager'); // Manager
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
