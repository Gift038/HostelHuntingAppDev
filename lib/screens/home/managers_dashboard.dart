import 'package:flutter/material.dart';

void main() {
  runApp(const ManagerDashboard());
}

class ManagerDashboard extends StatelessWidget {
  const ManagerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manager Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color.fromARGB(255, 243, 241, 244),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.brown,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
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
    PlaceholderWidget(label: "Payments"),
    PlaceholderWidget(label: "Residents"),
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
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.brown.shade200,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Payments'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Residents'),
        ],
      ),
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
        style: const TextStyle(fontSize: 22, color: Colors.brown),
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
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
    final Color baseColor = Colors.brown;
    final Color hoverColor = Colors.brown.shade300;
    final Color pressedColor = Colors.brown.shade800;

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
          style: ElevatedButton.styleFrom(backgroundColor: getButtonColor()),
          onPressed: () {},
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
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 16)),
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
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Monthly Revenue',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('Ugx 5,000,000'),
                const SizedBox(height: 8),
                const Text('Last 6 months: +15%'),
                const SizedBox(height: 20),
                Container(
                  height: 100,
                  color: Colors.brown.shade100,
                  alignment: Alignment.center,
                  child: const Text('Line Chart Placeholder'),
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
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('90% Paid'),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: 0.9,
                  color: Colors.brown,
                  backgroundColor: Colors.brown.shade100,
                ),
                const SizedBox(height: 8),
                const Text('This month: +5%'),
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
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
        backgroundColor: Colors.brown,
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
