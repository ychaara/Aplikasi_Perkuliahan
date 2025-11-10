import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routeName = "/home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _onNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // contoh navigasi
    if (index == 1) {
      // Pengumuman
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Pengumuman dibuka")));
    } else if (index == 2) {
      // QR Code
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("QR dibuka")));
    } else if (index == 3) {
      // Info
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Info dibuka")));
    } else if (index == 4) {
      // Akun Saya
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Akun Saya dibuka")));
    }
  }

  int _currentIndex = 0;

  Widget buildMenuItem(String title, IconData icon, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Icon(icon, color: const Color(0xFFF9CB43), size: 28),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDC8C2F),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFF9CB43), Color(0xFFDC8C2F)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(
                        "https://i.pravatar.cc/150?img=3",
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Carisa Rahmanda",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "1234567892025",
                          style: TextStyle(fontSize: 13, color: Colors.white70),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Notifikasi diklik")),
                        );
                      },
                    ),
                    // Logout
                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.white),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Konfirmasi Logout"),
                            content: const Text(
                              "Apakah kamu yakin ingin logout?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text("Batal"),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFF9CB43),
                                ),
                                onPressed: () async {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.remove("isLoggedIn");
                                  if (!mounted) return;
                                  Navigator.pushReplacementNamed(
                                    context,
                                    "/login",
                                  );
                                },

                                child: const Text("Logout"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Text(
                      "Informasi Pribadi",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Aktif",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    buildMenuItem("Keuangan", Icons.account_balance_wallet, () {
                      Navigator.pushNamed(context, '/keuangan');
                    }),
                    buildMenuItem("Jadwal Kuliah", Icons.schedule, () {
                      print("Jadwal Kuliah tapped");
                    }),
                    buildMenuItem("KHS", Icons.school, () {
                      print("KHS tapped");
                    }),
                    buildMenuItem("Transkrip", Icons.assignment, () {
                      print("Transkrip tapped");
                    }),
                    buildMenuItem("Dosen Wali", Icons.person, () {
                      print("Dosen Wali tapped");
                    }),
                    buildMenuItem("Layanan IT", Icons.computer, () {
                      print("Layanan IT tapped");
                    }),
                    buildMenuItem("Keagamaan", Icons.menu_book, () {
                      print("Keagamaan tapped");
                    }),
                    buildMenuItem("Training Maba", Icons.group, () {
                      print("Training Maba tapped");
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // JADWAL KULIAH TERDEKAT dengan background transparan
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9), // transparan
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => print("Lihat semua jadwal diklik"),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Jadwal Kuliah Terdekat",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Icon(Icons.chevron_right, color: Colors.grey),
                        ],
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9CB43),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Jaringan Komputer",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "14 September - 09:00 | R.617 - GKB 5",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // JADWAL KULIAH TERDEKAT
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => print("Lihat semua jadwal diklik"),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Jadwal Kuliah Terdekat",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Icon(Icons.chevron_right, color: Colors.grey),
                        ],
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9CB43),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Jaringan Komputer",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "14 September - 09:00 | R.617 - GKB 5",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // INDEKS PRESTASI
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => print("Lihat semua IP diklik"),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Indeks Prestasi (IP)",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Icon(Icons.chevron_right, color: Colors.grey),
                        ],
                      ),
                    ),
                    const Divider(),
                    Column(
                      children: List.generate(6, (index) {
                        double nilai = (index == 2 || index == 4) ? 3.97 : 4.0;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 80,
                                child: Text(
                                  "Semester ${index + 1}",
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: nilai / 4.0,
                                  color: const Color(0xFFF9CB43),
                                  backgroundColor: Colors.grey[200],
                                  minHeight: 10,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                nilai.toStringAsFixed(2),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),

      // Ganti bagian bottomNavigationBar lama dengan ini
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 6, spreadRadius: 2),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            _onNavTapped(index); // panggil fungsi yang sudah kamu buat
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.amber[700],
          unselectedItemColor: Colors.black54,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Beranda",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.business_center),
              label: "Pengumuman",
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber[700],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.qr_code, color: Colors.white),
              ),
              label: "",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.info_outline),
              label: "Info",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Akun Saya",
            ),
          ],
        ),
      ),
    );
  }
}
