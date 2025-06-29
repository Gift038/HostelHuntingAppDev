import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final coffeeBrown = const Color(0xFF4B2E05);
  final lightCoffeeBrown = const Color(0xFF9C7A5F);

  late ScrollController _scrollController;
  late AnimationController _autoScrollController;
  late Animation<double> _scrollAnimation;

  Timer? _scrollTimer;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _autoScrollController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _scrollAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _autoScrollController, curve: Curves.easeInOut),
    );

    _autoScrollController.addListener(() {
      if (!_scrollController.hasClients) return;

      final maxScroll = _scrollController.position.maxScrollExtent;
      final value = _scrollAnimation.value;

      // Ping-pong scroll: 0->max and back to 0
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
    _scrollTimer?.cancel();
    super.dispose();
  }

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
          title: Text(
            'HostelFinder',
            style: TextStyle(
              color: coffeeBrown,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            // 🔍 Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.brown[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: lightCoffeeBrown),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Search for hostels',
                      style: TextStyle(color: Colors.brown),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),

            //Hostel Listings
            Text(
              'Hostel Listings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: coffeeBrown),
            ),
            const SizedBox(height: 12),

            SizedBox(
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
                  HostelCard(
                    imagePath: 'assets/hostel5.jpg',
                    title: 'Ndejje University Hostels',
                    subtitle: 'Find hostels near Ndejje University',
                  ),
                  HostelCard(
                    imagePath: 'assets/hostel6.jpg',
                    title: 'Mbarara University Hostels',
                    subtitle: 'Find hostels near Mbarara University',
                  ),
                  HostelCard(
                    imagePath: 'assets/hostel3.jpg',
                    title: 'Victoria University Hostels',
                    subtitle: 'Find hostels near Victoria University',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // All Services
            Text(
              'All Services',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: coffeeBrown),
            ),
            const SizedBox(height: 16),
            SizedBox(
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  ServiceCard(
                    icon: Icons.auto_awesome,
                    title: 'Smart Recommendations',
                    subtitle: 'Personalized hostel suggestions',
                    coffeeBrown: coffeeBrown,
                    lightCoffeeBrown: lightCoffeeBrown,
                  ),
                  ServiceCard(
                    icon: Icons.home_work,
                    title: 'Hostel Listings',
                    subtitle: 'Browse available hostels',
                    coffeeBrown: coffeeBrown,
                    lightCoffeeBrown: lightCoffeeBrown,
                  ),
                  ServiceCard(
                    icon: Icons.person,
                    title: 'Tenant Records',
                    subtitle: 'Manage tenant information',
                    coffeeBrown: coffeeBrown,
                    lightCoffeeBrown: lightCoffeeBrown,
                  ),
                  ServiceCard(
                    icon: Icons.build,
                    title: 'Maintenance Tracking',
                    subtitle: 'Track maintenance requests',
                    coffeeBrown: coffeeBrown,
                    lightCoffeeBrown: lightCoffeeBrown,
                  ),
                  ServiceCard(
                    icon: Icons.event_note,
                    title: 'Repair Scheduling',
                    subtitle: 'Schedule repairs',
                    coffeeBrown: coffeeBrown,
                    lightCoffeeBrown: lightCoffeeBrown,
                  ),
                  ServiceCard(
                    icon: Icons.announcement,
                    title: 'Announcements',
                    subtitle: 'Receive management updates',
                    coffeeBrown: coffeeBrown,
                    lightCoffeeBrown: lightCoffeeBrown,
                  ),
                  ServiceCard(
                    icon: Icons.payment,
                    title: 'Online Booking & Payment',
                    subtitle: 'Book and pay online',
                    coffeeBrown: coffeeBrown,
                    lightCoffeeBrown: lightCoffeeBrown,
                  ),
                  ServiceCard(
                    icon: Icons.description,
                    title: 'Digital Lease & Docs',
                    subtitle: 'Access lease and documents',
                    coffeeBrown: coffeeBrown,
                    lightCoffeeBrown: lightCoffeeBrown,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.brown[100],
        type: BottomNavigationBarType.fixed, // Ensures labels are always shown
        selectedItemColor: coffeeBrown,
        unselectedItemColor: lightCoffeeBrown,
        currentIndex: 0,
        showUnselectedLabels: true, // Optional: Show labels for unselected items too
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.house_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Tenant's Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cases_rounded),
            label: "Manager's Dashboard",
          ),
        ],
      ),

    );
  }
}

// Hostel Card Widget
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
        child: Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 🛎 Service Card Widget with hover effect and animations
class ServiceCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color coffeeBrown;
  final Color lightCoffeeBrown;

  const ServiceCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.coffeeBrown,
    required this.lightCoffeeBrown,
  }) : super(key: key);

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final bgColor = _hovering ? widget.lightCoffeeBrown : Colors.transparent;
    final textColor = _hovering ? Colors.white : widget.coffeeBrown;
    final iconColor = _hovering ? Colors.white : widget.lightCoffeeBrown;

    return MouseRegion(
      onEnter: (_) => setState(() {
        _hovering = true;
      }),
      onExit: (_) => setState(() {
        _hovering = false;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: bgColor,
          border: Border.all(color: widget.lightCoffeeBrown),
          boxShadow: _hovering
              ? [
            BoxShadow(
              color: widget.lightCoffeeBrown.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ]
              : null,
        ),
        child: Row(
          children: [
            AnimatedScale(
              duration: const Duration(milliseconds: 250),
              scale: _hovering ? 1.1 : 1,
              child: Icon(widget.icon, color: iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                      child: Text(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      style: TextStyle(
                        color: _hovering ? Colors.white70 : widget.lightCoffeeBrown,
                        fontSize: 12,
                      ),
                      child: Text(
                        widget.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
