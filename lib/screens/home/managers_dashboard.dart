import 'package:flutter/material.dart';
import '../manager_dashboard/payments_screen.dart';
import '../manager_dashboard/addresident_screen.dart';
import '../manager_dashboard/notification_screen.dart';
import '../manager_dashboard/settings.dart';


void main() {
  runApp(const ManagerDashboard());
}

// Define your main light coffee brown color
const Color coffeeBrown = Color.fromARGB(
  255,
  241,
  236,
  230,
); // Light coffee brown
const Color coffeeBrownDark = Color.fromARGB(
  255,
  218,
  203,
  190,
); // Slightly darker light coffee brown
const Color lightcoffeeBrownDark = Color.fromARGB(
  255,
  218,
  203,
  190,
); // Slightly darker light coffee brown

class ManagerDashboard extends StatelessWidget {
  const ManagerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manager Dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.brown,
          accentColor: const Color.fromARGB(255, 235, 227, 219),
        ).copyWith(surface: coffeeBrownDark),
        scaffoldBackgroundColor: coffeeBrown,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 249, 246, 242),
          foregroundColor: Colors.black,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 245, 220, 195),
            foregroundColor: Colors.black,
          ),
        ),
      ),
      home: const DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    DashboardContent(),
    PaymentsScreen(),
    AddResidentScreen(),
    NotificationScreen(),
    SettingsScreen(),
    //PlaceholderWidget(label: "Residents"),
    //PlaceholderWidget(label: "Notifications"),
    //PlaceholderWidget(label: "Settings"),
  ];

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manager\'s Dashboard'),
        centerTitle: true,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
        selectedItemColor: Colors.black,
        unselectedItemColor: coffeeBrownDark.withAlpha((0.7 * 255).toInt()),
        selectedLabelStyle: const TextStyle(color: Colors.black),
        unselectedLabelStyle: TextStyle(
          color: coffeeBrownDark.withAlpha((0.7 * 255).toInt()),
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Payments'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Residents'),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      backgroundColor: coffeeBrown, // Set Scaffold background to light brown
    );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          QuickActions(),
          SizedBox(height: 20),
          Overview(),
          SizedBox(height: 20),
          KeyMetrics(),
          SizedBox(height: 20),
          PaymentStatus(),
          SizedBox(height: 20),
          RecentActivity(),
        ],
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final String label;
  const PlaceholderWidget({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$label Page',
        style: const TextStyle(fontSize: 22, color: Colors.black),
      ),
    );
  }
}

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            ActionButton(label: 'Add Resident'),
            ActionButton(label: 'Room Management'),
            ActionButton(label: 'Tenant Listing'),
            ActionButton(label: 'Maintenance Requests'),
          ],
        ),
      ],
    );
  }
}

class ActionButton extends StatefulWidget {
  final String label;

  const ActionButton({super.key, required this.label});

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool _isHovering = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final Color baseColor = const Color.fromARGB(255, 227, 219, 212);
    final Color hoverColor = coffeeBrownDark;
    final Color pressedColor = coffeeBrownDark.withAlpha((0.85 * 255).toInt());

    Color getButtonColor() {
      if (_isPressed) return pressedColor;
      if (_isHovering) return hoverColor;
      return baseColor;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: getButtonColor(),
            foregroundColor: Colors.black,
          ),
          onPressed: () {
            setState(() {
              _isPressed = true;
            });
            Future.delayed(const Duration(milliseconds: 100), () {
              setState(() {
                _isPressed = false;
              });
            });
          },
          child: Text(widget.label),
        ),
      ),
    );
  }
}

class Overview extends StatelessWidget {
  const Overview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overview',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 253, 253, 253),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: const [
            Expanded(
              child: OverviewCard(title: 'Occupancy Rate', value: '85%'),
            ),
            SizedBox(width: 10),
            Expanded(
              child: OverviewCard(title: 'Average Rent', value: 'Ugx 750,000'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const OverviewCard(title: 'Total Revenue', value: 'Ugx 20,000,000'),
      ],
    );
  }
}

class OverviewCard extends StatelessWidget {
  final String title;
  final String value;

  const OverviewCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: coffeeBrown,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class KeyMetrics extends StatelessWidget {
  const KeyMetrics({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Key Metrics',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Card(
          elevation: 2,
          color: coffeeBrown,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Monthly Revenue',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Ugx 5,000,000',
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Last 6 months: +15%',
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 100,
                  color: coffeeBrownDark,
                  alignment: Alignment.center,
                  child: const Text(
                    'Line Chart Placeholder',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PaymentStatus extends StatelessWidget {
  const PaymentStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Status',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Card(
          elevation: 2,
          color: coffeeBrown,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('90% Paid', style: TextStyle(color: Colors.black)),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: 0.9,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  backgroundColor: coffeeBrownDark,
                ),
                const SizedBox(height: 8),
                const Text(
                  'This month: +5%',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class RecentActivity extends StatelessWidget {
  const RecentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Activity',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        const ActivityItem(
          icon: Icons.person_add,
          title: 'New Resident: Ethan Carter',
          subtitle: 'Room 203',
        ),
        const ActivityItem(
          icon: Icons.plumbing,
          title: 'Maintenance: Leaky Faucet',
          subtitle: 'Room 101',
        ),
        const ActivityItem(
          icon: Icons.payment,
          title: 'Payment Received: Ugx 750,000',
          subtitle: 'Room 205',
        ),
      ],
    );
  }
}

class ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const ActivityItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: coffeeBrown,
        child: Icon(icon, color: Colors.black),
      ),
      title: Text(title, style: const TextStyle(color: Colors.black)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.black54)),
    );
  }
}
