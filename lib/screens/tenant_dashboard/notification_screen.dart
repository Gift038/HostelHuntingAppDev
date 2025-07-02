import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final List<_NotificationItem> notifications = [
    _NotificationItem(
      icon: Icons.check_circle_outline,
      title: 'Booking Confirmed',
      subtitle: 'Your booking at The Wanderlust Hostel is confirmed.',
      iconColor: Colors.green,
    ),
    _NotificationItem(
      icon: Icons.calendar_today_outlined,
      title: 'Check-in Reminder',
      subtitle: 'Check-in for your stay at The Urban Retreat is tomorrow.',
      iconColor: Colors.blue,
    ),
    _NotificationItem(
      icon: Icons.info_outline,
      title: 'Hostel Update',
      subtitle: 'The Wanderlust Hostel has updated its amenities.',
      iconColor: Colors.orange,
    ),
    _NotificationItem(
      icon: Icons.cancel_outlined,
      title: 'Booking Canceled',
      subtitle: 'Your booking at The Urban Retreat has been canceled.',
      iconColor: Colors.red,
    ),
    _NotificationItem(
      icon: Icons.star_border,
      title: 'New Review',
      subtitle: 'The Wanderlust Hostel has a new review.',
      iconColor: Colors.amber,
    ),
  ];

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
    );
  }
}

class _NotificationItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;

  _NotificationItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
  });
}
