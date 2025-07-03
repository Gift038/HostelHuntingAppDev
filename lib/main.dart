import 'package:flutter/material.dart';
import 'screens/home/welcome_screen.dart';
import 'screens/home/home_page.dart';
import 'screens/tenant_dashboard/search_filter_screen.dart';
import 'screens/tenant_dashboard/hostel_list_screen.dart';
import 'screens/tenant_dashboard/hostel_detail_screen.dart';
import 'screens/tenant_dashboard/booking_screen.dart';
import 'screens/tenant_dashboard/payment_screen.dart';
import 'screens/tenant_dashboard/notification_screen.dart' as tenant;
import 'screens/manager_dashboard/notification_screen.dart' as manager;
import 'screens/manager_dashboard/payments_screen.dart';
import 'screens/tenant_dashboard/profile_screen.dart';
import 'screens/home/virtual_tours.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

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
        storageBucket: "hostel-hunt-d3f9d.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  
  runApp(const HostelHuntApp());

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
        '/profile': (context) => ProfileScreen(),
        '/virtual-tours': (context) => const VirtualToursScreen(),
      },
    );
  }
}
