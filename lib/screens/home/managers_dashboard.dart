import 'package:flutter/material.dart';
import '../manager_dashboard/payments_screen.dart';
import '../manager_dashboard/addresident_screen.dart';
import '../manager_dashboard/notification_screen.dart';
import '../manager_dashboard/settings.dart';
import '../manager_dashboard/bookings_request.dart';
import '../manager_dashboard/maintance_repair.dart';
import '../manager_dashboard/room_management_screen.dart';

void main() {
  runApp(const ManagerDashboard());
}

// Define your main dark coffee brown and white color scheme
const Color coffeeBrown = Color(0xFF4B2E19); // Dark coffee brown
// const Color coffeeBrownLight = Color(0xFFD7CCC8); // Light brown for accents (removed)
const Color dirtyBrownWhite = Color(0xFFFAF3E3); // Dirty brown white background

class ManagerDashboard extends StatelessWidget {
  const ManagerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manager Dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.brown,
          accentColor: dirtyBrownWhite,
        ).copyWith(
          surface: dirtyBrownWhite,
          background: dirtyBrownWhite,
        ),
        scaffoldBackgroundColor: dirtyBrownWhite,
        appBarTheme: const AppBarTheme(
          backgroundColor: coffeeBrown,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: coffeeBrown,
            foregroundColor: Colors.white,
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
        backgroundColor: Color(0xFFD5C9C4),
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(color: Colors.white),
        unselectedLabelStyle: const TextStyle(color: Colors.white),
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
      backgroundColor: dirtyBrownWhite, // Set Scaffold background to dirty brown white
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
        style: const TextStyle(fontSize: 22, color: coffeeBrown),
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
            color: coffeeBrown,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ActionButton(
              label: 'Add Resident',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const AddResidentScreen()));
              },
            ),
            ActionButton(
              label: 'Room Management',
              onTap: () {
                Navigator.pushNamed(context, '/room_management');
              },
            ),
            ActionButton(
              label: 'Tenant Listing',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => const AlertDialog(content: Text('Tenant Listing')),
                );
              },
            ),
            ActionButton(
              label: 'Maintenance Requests',
              onTap: () {
                Navigator.pushNamed(context, '/maintenance');
              },
            ),
          ],
        ),
      ],
    );
  }
}

class ActionButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;

  const ActionButton({super.key, required this.label, this.onTap});

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool _isHovering = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final Color hoverColor = coffeeBrown;
    final Color pressedColor = coffeeBrown;
    final Color newBaseColor = dirtyBrownWhite;

    Color getButtonColor() {
      if (_isPressed) return pressedColor;
      if (_isHovering) return hoverColor;
      return newBaseColor;
    }

    Color getTextColor() {
      if (_isPressed || _isHovering) return Colors.white;
      return coffeeBrown;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform: _isHovering ? (Matrix4.identity()..scale(1.05)) : Matrix4.identity(),
        decoration: BoxDecoration(
          color: getButtonColor(),
          borderRadius: BorderRadius.circular(8),
          boxShadow: _isHovering
              ? [
                  BoxShadow(
                    color: coffeeBrown.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              setState(() {
                _isPressed = true;
              });
              Future.delayed(const Duration(milliseconds: 100), () {
                setState(() {
                  _isPressed = false;
                });
                if (widget.onTap != null) widget.onTap!();
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              alignment: Alignment.center,
              child: Text(
                widget.label,
                style: TextStyle(
                  color: getTextColor(),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
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
            color: coffeeBrown,
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
      color: dirtyBrownWhite,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: coffeeBrown,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 16, color: coffeeBrown),
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
            color: coffeeBrown,
          ),
        ),
        const SizedBox(height: 10),
        Card(
          elevation: 2,
          color: dirtyBrownWhite,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Monthly Revenue',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: coffeeBrown,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Ugx 5,000,000',
                  style: TextStyle(color: coffeeBrown),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Last 6 months: +15%',
                  style: TextStyle(color: coffeeBrown),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 100,
                  color: coffeeBrown,
                  alignment: Alignment.center,
                  child: const Text(
                    'Line Chart Placeholder',
                    style: TextStyle(color: dirtyBrownWhite),
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
            color: coffeeBrown,
          ),
        ),
        const SizedBox(height: 10),
        Card(
          elevation: 2,
          color: dirtyBrownWhite,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('90% Paid', style: TextStyle(color: coffeeBrown)),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: 0.9,
                  valueColor: AlwaysStoppedAnimation<Color>(coffeeBrown),
                  backgroundColor: dirtyBrownWhite,
                ),
                const SizedBox(height: 8),
                const Text(
                  'This month: +5%',
                  style: TextStyle(color: coffeeBrown),
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
            color: coffeeBrown,
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
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(title, style: const TextStyle(color: coffeeBrown)),
      subtitle: Text(subtitle, style: const TextStyle(color: dirtyBrownWhite)),
    );
  }
}
