import 'package:flutter/material.dart';
import 'home_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/hostel2.jpg',
              height: 300,
            ),
            const SizedBox(height: 30),
            const Text(
              'WELCOME',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Find your next space, feel at home\nWhere comfort meets convenience',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()));
              },
              child: const Text('Get Start'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            // const SizedBox(height: 15),
            // OutlinedButton(
            //   onPressed: () {},
            //   child: const Text('Sign Up'),
            //   style: OutlinedButton.styleFrom(
            //     minimumSize: const Size(double.infinity, 50),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
