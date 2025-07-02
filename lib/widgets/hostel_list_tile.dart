import 'package:flutter/material.dart';

class HostelListTile extends StatefulWidget {
  final String imagePath;
  final String name;
  final double rating;
  final int reviews;
  final int price;
  final String details;
  final String type;

  const HostelListTile({
    super.key,
    required this.imagePath,
    required this.name,
    required this.rating,
    required this.reviews,
    required this.price,
    required this.details,
    required this.type,
  });

  @override
  State<HostelListTile> createState() => _HostelListTileState();
}

class _HostelListTileState extends State<HostelListTile> {
  bool _isHovered = false;
  final Color coffeeBrown = const Color(0xFF4B2E05);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: _isHovered ? coffeeBrown : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left: Details
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.rating.toStringAsFixed(1),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: _isHovered ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            '\u2022 ${widget.reviews} reviews',
                            style: TextStyle(
                              color: _isHovered ? Colors.white70 : Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: _isHovered ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.type,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/maps',
                            arguments: {
                              'university': widget.details,
                              'hostels': [
                                {
                                  'name': widget.name,
                                  'imagePath': widget.imagePath,
                                }
                              ],
                            },
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.location_on, color: const Color(0xFF9C7A5F), size: 18),
                            const SizedBox(width: 4),
                            Text(
                              widget.details,
                              style: TextStyle(
                                color: const Color(0xFF9C7A5F),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Starting at Ugx ${widget.price}',
                        style: TextStyle(
                          color: _isHovered ? Colors.white70 : Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/virtual-tours',
                            arguments: {
                              'hostelName': widget.name,
                              'rooms': [
                                {
                                  'type': 'Single Room',
                                  'price': 250000,
                                  'desc': 'Ideal for individual students',
                                  'images': [
                                    'assets/hostel1.jpg',
                                    'assets/hostel2.jpg',
                                    'assets/hostel3.jpg',
                                    'assets/hostel4.jpeg',
                                    'assets/hostel5.jpg',
                                    'assets/hostel1.jpg',
                                  ],
                                  'available': 3,
                                  'total': 5,
                                },
                                {
                                  'type': 'Double Room',
                                  'price': 400000,
                                  'desc': 'Suitable for sharing with a roommate',
                                  'images': [
                                    'assets/hostel2.jpg',
                                    'assets/hostel3.jpg',
                                    'assets/hostel4.jpeg',
                                    'assets/hostel5.jpg',
                                    'assets/hostel1.jpg',
                                    'assets/hostel2.jpg',
                                  ],
                                  'available': 0,
                                  'total': 4,
                                },
                                {
                                  'type': 'Triple Room',
                                  'price': 550000,
                                  'desc': 'Spacious for three students',
                                  'images': [
                                    'assets/hostel3.jpg',
                                    'assets/hostel4.jpeg',
                                    'assets/hostel5.jpg',
                                    'assets/hostel1.jpg',
                                    'assets/hostel2.jpg',
                                    'assets/hostel3.jpg',
                                  ],
                                  'available': 2,
                                  'total': 3,
                                },
                              ],
                            },
                          );
                        },
                        child: Text(
                          'Virtual Tour',
                          style: TextStyle(
                            color: const Color(0xFF9C7A5F),
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Right: Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    widget.imagePath,
                    width: 80,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
