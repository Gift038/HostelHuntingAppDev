import 'package:flutter/material.dart';
import 'screens/home/welcome_screen.dart';
import 'screens/home/home_page.dart';
import 'screens/tenant_dashboard/search_filter_screen.dart';
import 'screens/tenant_dashboard/hostel_list_screen.dart';
import 'screens/tenant_dashboard/hostel_detail_screen.dart';
import 'screens/tenant_dashboard/booking_screen.dart';
import 'screens/tenant_dashboard/payment_screen.dart';
import 'screens/tenant_dashboard/notification_screen.dart';
import 'screens/tenant_dashboard/profile_screen.dart';
import 'screens/home/virtual_tours.dart';
import 'screens/tenant_dashboard/tenant_document_screen.dart';
import 'screens/maps.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  String name = '';
  String contact = '';
  String gender = '';
  String email = '';

  void setUser({required String name, required String contact, required String gender, required String email}) {
    this.name = name;
    this.contact = contact;
    this.gender = gender;
    this.email = email;
    notifyListeners();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //authDomain: "hostel-hunt-d3f9d.firebaseapp.com",
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey:"AIzaSyDRS_vEqMw3HnJ9wu7BF5J_SEPowfXImWA",
        appId: "1:358026434934:web:cd8fd7be2fdc629af14257",
        messagingSenderId:"358026434934" ,
        projectId: "hostel-hunt-d3f9d",
        storageBucket: "hostel-hunt-d3f9d.firebasestorage.app",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: const HostelHuntApp(),
    ),
  );
} 

class HostelHuntApp extends StatelessWidget {
  const HostelHuntApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HostelHunt',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/dashboard': (context) => const HomeScreen(),
        '/search_filter': (context) => const SearchFilterScreen(),
        '/results': (context) => HostelListScreen(),
        '/hostel_detail': (context) => HostelDetailScreen(),
        '/booking': (context) => BookingScreen(),
        '/payment': (context) => PaymentScreen(),
        '/notifications': (context) => NotificationScreen(),
        '/virtual-tours': (context) => const VirtualToursScreen(),
        '/documents': (context) => const TenantDocumentScreen(),
        '/maps': (context) => const MapsScreen(),
      },
    );
  }
}
