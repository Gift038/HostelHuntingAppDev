import 'package:flutter/material.dart';
import '../manager_dashboard/addresident_screen.dart';
import '../manager_dashboard/notification_screen.dart' as manager;
import '../manager_dashboard/settings_screen.dart';
import '../manager_dashboard/bookings_request.dart';
import '../manager_dashboard/maintenance_repair.dart';
import '../manager_dashboard/room_management_screen.dart';
import '../manager_dashboard/payments_screen.dart';
import '../tenant_dashboard/notification_screen.dart' as tenant;
import '../auth/register_account_screen.dart';

void main() {
  runApp(const ManagerDashboard());
}

const Color coffeeBrown = Color(0xFF4B2E19);
const Color whiteBeige = Color(0xFFF5F5DC); // White beige

class ManagerDashboard extends StatelessWidget {
  const ManagerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manager Dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.brown)
            .copyWith(
              secondary: coffeeBrown,
              surface: whiteBeige,
            ),
        scaffoldBackgroundColor: whiteBeige,
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
      routes: {
        '/room_management': (_) => const RoomManagementScreen(),
        '/maintenance': (_) => const MaintenanceRepairsScreen(),
      },
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

  final List<Widget> _pages = [
    const DashboardContent(),
    const PaymentsScreen(),
    const AddResidentScreen(),
    const manager.NotificationScreen(),
    const SettingsScreen(),
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
        backgroundColor: coffeeBrown,
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
        selectedItemColor: whiteBeige,
        unselectedItemColor: whiteBeige.withOpacity(0.7),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddResidentScreen()),
                );
              },
            ),
            ActionButton(
              label: 'Room Management',
              onTap: () {
                Navigator.pushNamed(context, '/room_management');
              },
            ),
            ActionButton(
              label: 'Room Matching',
              onTap: () {
                Navigator.pushNamed(context, '/room_matching');
              },
            ),
            ActionButton(
              label: 'Tenant Listing',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) =>
                      const AlertDialog(content: Text('Tenant Listing')),
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
    Color getButtonColor() {
      if (_isPressed || _isHovering) return coffeeBrown;
      return whiteBeige;
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
        transform: _isHovering
            ? (Matrix4.identity()..scale(1.05))
            : Matrix4.identity(),
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
      color: whiteBeige,
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
          color: whiteBeige,
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
                    style: TextStyle(color: whiteBeige),
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
          color: whiteBeige,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('90% Paid', style: TextStyle(color: coffeeBrown)),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: 0.9,
                  valueColor: const AlwaysStoppedAnimation<Color>(coffeeBrown),
                  backgroundColor: whiteBeige,
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
      children: const [
        Text(
          'Recent Activity',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: coffeeBrown,
          ),
        ),
        SizedBox(height: 10),
        ActivityItem(
          icon: Icons.person_add,
          title: 'New Resident: Ethan Carter',
          subtitle: 'Room 203',
        ),
        ActivityItem(
          icon: Icons.plumbing,
          title: 'Maintenance: Leaky Faucet',
          subtitle: 'Room 101',
        ),
        ActivityItem(
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
      subtitle: Text(subtitle, style: const TextStyle(color: coffeeBrown)),
    );
  }
}
