import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zoom_clone/screens/home.dart';
import 'package:zoom_clone/screens/join_metting_screen.dart';
import 'package:zoom_clone/screens/login_screen.dart';
import 'package:zoom_clone/services/auth.dart';
import 'package:zoom_clone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zoom Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: StreamBuilder(
        stream: AuthMethods().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return const Home();
          }
          return const LoginScreen();
        },
      ),
      routes: {
        Home.id: (context) => const Home(),
        JoinMeetingScreen.id: (context) => const JoinMeetingScreen(),
      },
    );
  }
}
