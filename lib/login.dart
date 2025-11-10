import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;

  // Controller input
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Dummy user
  final String validUsername = "admin";
  final String validPassword = "12345";

  // Fungsi login
  Future<void> _login() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showMessage("Username dan password tidak boleh kosong");
      return;
    }

    if (username == validUsername && password == validPassword) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isLoggedIn", true);
      await prefs.setString("username", username);

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      _showMessage("Username atau password salah");
    }
  }

  // Pesan error/sukses
  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Bagian Atas (Logo + background kuning emas)
          Container(
            height: 250,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFF9CB43),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: const Center(
              child: Text(
                "Aplikasi Perkuliahan Mahasiswa",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Tulisan Login
          const Text(
            "Login",
            style: TextStyle(
              color: Color(0xFFF9CB43),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 30),

          // Form Username
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Username",
                  style: TextStyle(
                    color: Color(0xFFF9CB43),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: "Masukkan username Kamu",
                    hintStyle: const TextStyle(color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF9CB43)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xFFF9CB43), width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Form Password
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Password",
                  style: TextStyle(
                    color: Color(0xFFF9CB43),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: "Masukkan password Kamu",
                    hintStyle: const TextStyle(color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFF9CB43)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xFFF9CB43), width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: const Color(0xFFF9CB43),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Lupa Password
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Lupa Password ?",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Tombol Login
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF9CB43),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: _login,
                child: const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
