import 'package:flutter/material.dart';
import 'screens/home/welcome_screen.dart';
import 'screens/home/home_page.dart';
import 'screens/tenant_dashboard/search_filter_screen.dart';
import 'screens/tenant_dashboard/hostel_list_screen.dart';
import 'screens/tenant_dashboard/hostel_detail_screen.dart';
import 'screens/tenant_dashboard/booking_screen.dart';
import 'screens/tenant_dashboard/payment_screen.dart';
import 'screens/tenant_dashboard/notification_screen.dart';
import 'screens/manager_dashboard/payments_screen.dart';
import 'screens/tenant_dashboard/profile_screen.dart';
import 'screens/home/virtual_tours.dart';
import 'screens/home/managers_dashboard.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // You can handle background notification logic here, e.g., show a local notification
  // or update Firestore, etc.
  print('Handling a background message: ${message.messageId}');
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
  
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Optionally configure local notifications for foreground display
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const HostelHuntApp());
} 

class HostelHuntApp extends StatelessWidget {
  const HostelHuntApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HostelHunt',
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
=======

>>>>>>> 9bc979c30b8a5fedccad210e58fd64f1bd4d58a5
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/dashboard': (context) => const HomeScreen(),
        '/search_filter': (context) => const SearchFilterScreen(),
        '/results': (context) => HostelListScreen(),
        '/hostel_detail': (context) => HostelDetailScreen(),
        '/booking': (context) => BookingScreen(),
<<<<<<< HEAD
        '/payment': (context) => PaymentScreen(),
        '/notifications': (context) => NotificationsScreen(),
        '/profile': (context) => DemoProfileScreen(),
=======
        '/tenantPayment': (context) => PaymentScreen(),
        '/managerPayment': (context) => PaymentsScreen(),
        '/notifications': (context) => NotificationScreen(),
        '/profile': (context) => ProfileScreen(),
>>>>>>> 9bc979c30b8a5fedccad210e58fd64f1bd4d58a5
        '/virtual-tours': (context) => const VirtualToursScreen(),
        '/manager': (context) => ManagerDashboard(),
      },
    );
  }
}
