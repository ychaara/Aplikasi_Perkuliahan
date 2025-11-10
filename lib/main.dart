import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'home.dart';
import 'keuangan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLoggedIn") ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi UKT',
      theme: ThemeData(
        primaryColor: const Color(0xFFF9CB43),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: checkLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.data == true) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        },
      ),
      routes: {
        "/login": (context) => const LoginPage(),
        "/home": (context) => const HomePage(),
        "/keuangan": (context) => const Keuangan(),
      },
    );
  }
}
