import 'package:flutter/material.dart';

class SearchFilterScreen extends StatefulWidget {
  const SearchFilterScreen({super.key});

  @override
  State<SearchFilterScreen> createState() => _SearchFilterScreenState();
}

class _SearchFilterScreenState extends State<SearchFilterScreen> {
  double _distance = 5;
  double _price = 500000;
  bool wheelchair = false;
  bool noDisability = false;
  bool shuttle = false;
  bool noShuttle = false;
  bool studyRoom = false;
  bool gym = false;
  bool pool = false;
  bool ac = false;
  bool wifi = false;
  bool electrical = false;
  bool guestPolicy = false;
  bool petFriendly = false;
  final Color coffeeBrown = const Color(0xFF4B2E05);
  final Color lightCoffeeBrown = const Color(0xFF9C7A5F);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final String university = args != null && args['university'] != null ? args['university'] : '';
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F5F2),
        foregroundColor: Colors.brown,
        elevation: 0,
        title: const Text('Search & Filter'),
        leading: BackButton(color: coffeeBrown),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          if (university.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                'Distance from $university',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Distance'),
              Text('${_distance.toStringAsFixed(0)} km'),
            ],
          ),
          Slider(
            value: _distance,
            min: 1,
            max: 20,
            divisions: 19,
            label: '${_distance.toStringAsFixed(0)} km',
            onChanged: (v) => setState(() => _distance = v),
            activeColor: coffeeBrown,
            inactiveColor: lightCoffeeBrown,
          ),
          const SizedBox(height: 16),
          const Text('Price Range', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Price'),
              Text(_price.toStringAsFixed(0)),
            ],
          ),
          Slider(
            value: _price,
            min: 100000,
            max: 2000000,
            divisions: 19,
            label: _price.toStringAsFixed(0),
            onChanged: (v) => setState(() => _price = v),
            activeColor: coffeeBrown,
            inactiveColor: lightCoffeeBrown,
          ),
          const SizedBox(height: 16),
          const Text('Academic Program', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter program',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Disability Accommodations', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          CheckboxListTile(
            value: wheelchair,
            onChanged: (v) => setState(() => wheelchair = v ?? false),
            title: const Text('Wheelchair Accessible'),
            activeColor: coffeeBrown,
          ),
          CheckboxListTile(
            value: noDisability,
            onChanged: (v) => setState(() => noDisability = v ?? false),
            title: const Text('No Disability Accommodations'),
            activeColor: coffeeBrown,
          ),
          const SizedBox(height: 8),
          const Text('Transportation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          CheckboxListTile(
            value: shuttle,
            onChanged: (v) => setState(() => shuttle = v ?? false),
            title: const Text('Shuttle Service'),
            activeColor: coffeeBrown,
          ),
          CheckboxListTile(
            value: noShuttle,
            onChanged: (v) => setState(() => noShuttle = v ?? false),
            title: const Text('No Shuttle Service'),
            activeColor: coffeeBrown,
          ),
          const SizedBox(height: 8),
          const Text('Facilities', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          CheckboxListTile(
            value: studyRoom,
            onChanged: (v) => setState(() => studyRoom = v ?? false),
            title: const Text('Study Room'),
            activeColor: coffeeBrown,
          ),
          CheckboxListTile(
            value: gym,
            onChanged: (v) => setState(() => gym = v ?? false),
            title: const Text('Gym'),
            activeColor: coffeeBrown,
          ),
          CheckboxListTile(
            value: pool,
            onChanged: (v) => setState(() => pool = v ?? false),
            title: const Text('Pool'),
            activeColor: coffeeBrown,
          ),
          CheckboxListTile(
            value: ac,
            onChanged: (v) => setState(() => ac = v ?? false),
            title: const Text('A/C'),
            activeColor: coffeeBrown,
          ),
          CheckboxListTile(
            value: wifi,
            onChanged: (v) => setState(() => wifi = v ?? false),
            title: const Text('Wi-Fi'),
            activeColor: coffeeBrown,
          ),
          const SizedBox(height: 8),
          const Text('Rules & Policies', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          CheckboxListTile(
            value: electrical,
            onChanged: (v) => setState(() => electrical = v ?? false),
            title: const Text('Electrical Appliances allowed'),
            activeColor: coffeeBrown,
          ),
          CheckboxListTile(
            value: guestPolicy,
            onChanged: (v) => setState(() => guestPolicy = v ?? false),
            title: const Text('Guest Policy'),
            activeColor: coffeeBrown,
          ),
          CheckboxListTile(
            value: petFriendly,
            onChanged: (v) => setState(() => petFriendly = v ?? false),
            title: const Text('Pet-Friendly'),
            activeColor: coffeeBrown,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: coffeeBrown,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/matching_hostels');
              },
              child: const Text('Search', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.brown[100],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: coffeeBrown,
        unselectedItemColor: lightCoffeeBrown,
        currentIndex: 0,
        onTap: (index) {},
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
