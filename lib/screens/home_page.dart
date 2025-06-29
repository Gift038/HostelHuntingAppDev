import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Hostel Hunt',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          // 🔍 Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: const [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Search for hostels',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 🏘 Hostel Listings
          const Text(
            'Hostel Listings',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                HostelCard(
                  imagePath: 'assets/hostel1.jpg',
                  title: 'Makerere University Hostels',
                  subtitle: 'Find hostels near Makerere University',
                ),
                HostelCard(
                  imagePath: 'assets/hostel2.jpg',
                  title: 'Kyambogo University Hostels',
                  subtitle: 'Find hostels near Kyambogo University',
                ),
                HostelCard(
                  imagePath: 'assets/hostel3.jpg',
                  title: 'Uganda Christian University Hostels',
                  subtitle: 'Find hostels near UCU',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 🛠 Services
          const Text(
            'All Services',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: const [
              ServiceCard(
                icon: Icons.auto_awesome,
                title: 'Smart Recommendations',
                subtitle: 'Personalized hostel suggestions',
              ),
              ServiceCard(
                icon: Icons.home_work,
                title: 'Hostel Listings',
                subtitle: 'Browse available hostels',
              ),
              ServiceCard(
                icon: Icons.person,
                title: 'Tenant Records',
                subtitle: 'Manage tenant information',
              ),
              ServiceCard(
                icon: Icons.build,
                title: 'Maintenance Tracking',
                subtitle: 'Track maintenance requests',
              ),
              ServiceCard(
                icon: Icons.event_note,
                title: 'Repair Scheduling',
                subtitle: 'Schedule repairs',
              ),
              ServiceCard(
                icon: Icons.announcement,
                title: 'Announcements',
                subtitle: 'Receive management updates',
              ),
              ServiceCard(
                icon: Icons.payment,
                title: 'Online Booking & Payment',
                subtitle: 'Book and pay online',
              ),
              ServiceCard(
                icon: Icons.description,
                title: 'Digital Lease & Docs',
                subtitle: 'Access lease and documents',
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.manage_accounts), label: 'Manager'),
        ],
      ),
    );
  }
}

// 🧱 Hostel Card Widget
class HostelCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const HostelCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black.withOpacity(0.4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

// 🛎 Service Card Widget
class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const ServiceCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
