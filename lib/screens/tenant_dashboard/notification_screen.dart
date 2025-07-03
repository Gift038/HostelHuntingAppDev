import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final List<String> notifications = [
    'Booking confirmed at Greenwood Hostel',
    'Payment successful',
    'New hostel listings available',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF3E3),
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
                  backgroundColor: Color(0xFFFAF3E3),
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
                      color: Color(0xFFFAF3E3),
                      child: ListTile(
                        tileColor: Color(0xFFFAF3E3),
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
        backgroundColor: Colors.black,
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
