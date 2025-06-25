import 'package:flutter/material.dart';
import 'screens/welcome_page.dart';
import 'screens/register_page.dart';

void main() {
  runApp(const MaterialApp(
    home: HostelHunt(),
  ));
}

class HostelHunt extends StatelessWidget {
  const HostelHunt({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HostelHunt',
      debugShowCheckedModeBanner: false,
      routes:{
        '/': (context) => const WelcomePage(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}


