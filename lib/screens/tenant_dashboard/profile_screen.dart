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
  final UserProfile user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightCoffee,
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: coffeeBrown,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              CircleAvatar(
                radius: 48,
                backgroundColor: coffeeBrown.withOpacity(0.2),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: user.avatarUrl,
                    width: 96,
                    height: 96,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Icon(
                      Icons.person,
                      size: 48,
                      color: coffeeBrown,
                    ),
                    placeholder: (context, url) => SizedBox(
                      width: 32,
                      height: 32,
                      child: CircularProgressIndicator(strokeWidth: 2, color: coffeeBrown),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                user.name,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: coffeeBrown),
              ),
              const SizedBox(height: 4),
              Text(
                'Joined ${user.joinedYear}',
                style: const TextStyle(color: Colors.brown, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                user.email,
                style: const TextStyle(color: Colors.brown, fontSize: 14),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Personal Information',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: coffeeBrown),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                color: Colors.white,
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Contact Info', style: TextStyle(color: coffeeBrown)),
                  subtitle: Text(user.contactInfo, style: const TextStyle(color: Colors.brown)),
                ),
              ),
              Card(
                color: Colors.white,
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Gender', style: TextStyle(color: coffeeBrown)),
                  subtitle: Text(user.gender, style: const TextStyle(color: Colors.brown)),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Payment History',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: coffeeBrown),
                ),
              ),
              const SizedBox(height: 12),
              ...user.paymentHistory.map((p) => _buildPaymentRow(p)).toList(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildPaymentRow(PaymentHistory payment) {
  return Card(
    color: Colors.white,
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(payment.title, style: const TextStyle(fontWeight: FontWeight.w500, color: coffeeBrown)),
                Text(payment.date, style: const TextStyle(fontSize: 12, color: Colors.brown)),
                Text(payment.roomType, style: const TextStyle(fontSize: 12, color: Colors.brown)),
              ],
            ),
          ),
          Text(payment.amount, style: const TextStyle(fontWeight: FontWeight.bold, color: coffeeBrown)),
        ],
      ),
    ),
  );
}

// Example usage for demonstration
class DemoProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = UserProfile(
      name: 'Ethan Carter',
      email: 'ethan.carter@email.com',
      gender: 'Male',
      contactInfo: '+256 7012452667',
      joinedYear: '2021',
      avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
      paymentHistory: [
        PaymentHistory(
          title: 'Booking Payment',
          date: '2024-01-15',
          roomType: 'Double Room',
          amount: 'Ugx 300,000',
        ),
        PaymentHistory(
          title: 'Semester 1 Payment',
          date: '2024-02-01',
          roomType: 'Double Room',
          amount: 'Ugx 700,000',
        ),
        PaymentHistory(
          title: 'Semester 2 Payment',
          date: '2024-08-01',
          roomType: 'Single Room',
          amount: 'Ugx 1,000,000',
        ),
      ],
    );
    return ProfileScreen(user: user);
  }
}

// Add bottom navigation bar to ProfileScreen
class ProfileScreenWithNav extends StatefulWidget {
  @override
  State<ProfileScreenWithNav> createState() => _ProfileScreenWithNavState();
}

class _ProfileScreenWithNavState extends State<ProfileScreenWithNav> {
  int _currentIndex = 2;
  UserProfile? _userProfile;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    setState(() { _loading = true; _error = null; });
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        setState(() { _error = 'Not logged in.'; _loading = false; });
        return;
      }
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (!doc.exists) {
        setState(() { _error = 'Profile not found.'; _loading = false; });
        return;
      }
      final data = doc.data()!;
      setState(() {
        _userProfile = UserProfile(
          name: data['name'] ?? '',
          email: data['email'] ?? '',
          gender: data['gender'] ?? '',
          contactInfo: data['phone'] ?? '',
          joinedYear: data['joinedYear'] ?? '',
          avatarUrl: data['photoUrl'] ?? 'https://randomuser.me/api/portraits/men/32.jpg',
          paymentHistory: [], // You can fetch payment history if stored
        );
        _loading = false;
      });
    } catch (e) {
      setState(() { _error = e.toString(); _loading = false; });
    }
  }

  void _onNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/dashboard');
        break;
      case 1:
        Navigator.pushNamed(context, '/notifications');
        break;
      case 2:
        // Already on profile
        break;
      case 3:
        Navigator.pushNamed(context, '/documents');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightCoffee,
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: coffeeBrown,
        foregroundColor: Colors.white,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!, style: const TextStyle(color: Colors.red)))
              : _userProfile == null
                  ? const Center(child: Text('No profile data.'))
                  : ProfileScreen(user: _userProfile!),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.brown[100],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: coffeeBrown,
        unselectedItemColor: lightCoffee,
        currentIndex: _currentIndex,
        onTap: _onNavTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.house_rounded),
            label: 'Dashboard',
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
            icon: Icon(Icons.cases_rounded),
            label: 'Documents',
          ),
        ],
      ),
    );
  }
}
