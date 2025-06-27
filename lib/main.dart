import 'package:flutter/material.dart';
import 'screens/welcome_page.dart';
import 'screens/register_page.dart';
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
        storageBucket: "hostel-hunt-d3f9d.firebasestorage.app",
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
        '/': (context) => const WelcomePage(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}
