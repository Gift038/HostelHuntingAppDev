import 'package:flutter/material.dart';

const Color coffeeBrown = Color(0xFF4B2E19);
const Color dirtyBrownWhite = Color(0xFFFAF3E3);

class BookingRequest {
  final String tenantName;
  final String room;
  String status; // 'Pending', 'Approved', 'Rejected'

  BookingRequest({required this.tenantName, required this.room, this.status = 'Pending'});
}

class BookingsRequestScreen extends StatefulWidget {
  const BookingsRequestScreen({Key? key}) : super(key: key);

  @override
  State<BookingsRequestScreen> createState() => _BookingsRequestScreenState();
}

class _BookingsRequestScreenState extends State<BookingsRequestScreen> {
  final List<BookingRequest> _requests = [
    BookingRequest(tenantName: 'Alice Johnson', room: '101'),
    BookingRequest(tenantName: 'Bob Smith', room: '202'),
    BookingRequest(tenantName: 'Carol Lee', room: '303'),
  ];

  void _updateStatus(int index, String newStatus) {
    setState(() {
      _requests[index].status = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 1; // Booking Requests tab
    return Scaffold(
      backgroundColor: dirtyBrownWhite,
      appBar: AppBar(
        title: const Text('Booking Requests'),
        backgroundColor: coffeeBrown,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _requests.isEmpty
          ? const Center(child: Text('No booking requests'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _requests.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final req = _requests[index];
                return Card(
                  color: dirtyBrownWhite,
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: coffeeBrown,
                      child: Text(req.tenantName[0], style: const TextStyle(color: Colors.white)),
                    ),
                    title: Text(req.tenantName, style: const TextStyle(color: coffeeBrown, fontWeight: FontWeight.bold)),
                    subtitle: Text('Room: ${req.room}\nStatus: ${req.status}', style: const TextStyle(color: coffeeBrown)),
                    isThreeLine: true,
                    trailing: req.status == 'Pending'
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.check, color: Colors.green),
                                tooltip: 'Approve',
                                onPressed: () => _updateStatus(index, 'Approved'),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close, color: Colors.red),
                                tooltip: 'Reject',
                                onPressed: () => _updateStatus(index, 'Rejected'),
                              ),
                            ],
                          )
                        : Icon(
                            req.status == 'Approved' ? Icons.check_circle : Icons.cancel,
                            color: req.status == 'Approved' ? Colors.green : Colors.red,
                          ),
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFD7CCC8),
        selectedItemColor: Color(0xFF4B2E19),
        unselectedItemColor: Color(0xFF8D6E63),
        currentIndex: _selectedIndex,
        onTap: (index) {
          // Navigation stubs: implement navigation as needed
          // 0: Dashboard, 1: Booking Requests, 2: Notifications, 3: Settings
          if (index == _selectedIndex) return;
          // Example navigation logic (replace with your own routes/screens)
          // if (index == 0) Navigator.pushReplacementNamed(context, '/dashboard');
          // if (index == 2) Navigator.pushReplacementNamed(context, '/notifications');
          // if (index == 3) Navigator.pushReplacementNamed(context, '/settings');
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'Booking Requests',
          ),
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
