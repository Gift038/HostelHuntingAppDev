import 'package:flutter/material.dart';

class VirtualToursScreen extends StatelessWidget {
  const VirtualToursScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final String hostelName = args != null && args['hostelName'] != null ? args['hostelName'] : 'Virtual Tours';
    final List rooms = args != null && args['rooms'] != null ? args['rooms'] : [];

    return Scaffold(
      appBar: AppBar(
        title: Text(hostelName),
      ),
      body: rooms.isEmpty
          ? const Center(child: Text('No virtual tour data available.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                final room = rooms[index];
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            room['type'] ?? '',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text('Price: UGX ${room['price']}'),
                          const SizedBox(height: 8),
                          if (room['image'] != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                room['image'],
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          const SizedBox(height: 8),
                          if (room['video'] != null)
                            Container(
                              height: 180,
                              width: double.infinity,
                              color: Colors.black12,
                              child: Center(
                                child: Text(
                                  'Video: ${room['video']}',
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
} 