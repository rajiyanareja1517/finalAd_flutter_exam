import 'package:final_exam/views/screens/home_screen.dart';
import 'package:final_exam/views/screens/liked_notes_page.dart';
import 'package:final_exam/views/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false, getPages: [
      GetPage(
        name: "/home",
        page: () => HomeScreen(),
      ),
      GetPage(
        name: "/",
        page: () => SplashScreen(),
      ),
      GetPage(
        name: "/like",
        page: () => LikedNotesPage(),
      ),

    ]);

  }
}
