import 'dart:async';
import 'package:flutter/material.dart';
import '../../widgets/hostel_card.dart';

class TenantsDashboardScreen extends StatefulWidget {
  const TenantsDashboardScreen({super.key});

  @override
  State<TenantsDashboardScreen> createState() => _TenantsDashboardScreenState();
}

class _TenantsDashboardScreenState extends State<TenantsDashboardScreen>
    with SingleTickerProviderStateMixin {
  final Color coffeeBrown = const Color(0xFF4B2E05);
  final Color lightCoffeeBrown = const Color(0xFF9C7A5F);

  late ScrollController _scrollController;
  late AnimationController _autoScrollController;
  late Animation<double> _scrollAnimation;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _autoScrollController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );

    _scrollAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _autoScrollController, curve: Curves.linear),
    );

    _autoScrollController.addListener(() {
      if (!_scrollController.hasClients) return;

      final maxScroll = _scrollController.position.maxScrollExtent;
      final value = _scrollAnimation.value;

      final scrollPos = value < 0.5
          ? (value * 2) * maxScroll
          : (1 - (value - 0.5) * 2) * maxScroll;

      _scrollController.jumpTo(scrollPos);
    });

    _autoScrollController.repeat();
  }

  @override
  void dispose() {
    _autoScrollController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Navigation logic here
    switch (index) {
      case 0:
      // Already on dashboard
        break;
      case 1:
        Navigator.pushNamed(context, '/notifications');
        break;
      case 2:
        Navigator.pushNamed(context, '/profile');
        break;
      case 3:
        Navigator.pushNamed(context, '/documents');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tenant's Dashboard"),
        backgroundColor: coffeeBrown,
        foregroundColor: Colors.white,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.brown[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search for hostels',
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Hostel Listings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: coffeeBrown,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 150,
              child: ListView(
                controller: _scrollController,
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
                  HostelCard(
                    imagePath: 'assets/hostel4.jpg',
                    title: 'Busitema University Hostels',
                    subtitle: 'Find hostels near Busitema University',
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 24),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.brown[100],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: coffeeBrown,
        unselectedItemColor: lightCoffeeBrown,
        currentIndex: _currentIndex,
        onTap: _onNavTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.house_rounded),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Payments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cases_rounded),
            label: "Documents",
          ),
        ],
      ),
    );
  }
}
