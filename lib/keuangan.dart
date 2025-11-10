import 'package:flutter/material.dart';

class Keuangan extends StatelessWidget {
  const Keuangan({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFFF9CB43),
          title: const Text(
            "Keuangan",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
        ),
        body: Column(
          children: [
            const SizedBox(height: 16),

            // Custom TabBar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: const Color(0xFFF9CB43),
                  borderRadius: BorderRadius.circular(10),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black54,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Tab(text: "Semester Ini"),
                  Tab(text: "Semua"),
                  Tab(text: "Riwayat"),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Tab Content
            const Expanded(
              child: TabBarView(
                children: [
                  SemesterIniTab(),
                  SemuaTab(),
                  RiwayatTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SemesterIniTab extends StatelessWidget {
  const SemesterIniTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        cardItem("Her Registrasi", "Rp. 300.000", "Rp. 300.000", "Lunas"),
        cardItem("SPP Semester 7", "Rp. 300.000", "Rp. 0", "Belum Lunas"),
        cardItem("SPP Semester 7 UTS", "Rp. 300.000", "Rp. 0", "Dispensasi"),
        cardItem("SPP Semester 7 UTS", "Rp. 300.000", "Rp. 0", "Cek Biro Keuangan"),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF9CB43),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {},
            child: const Text(
              "Bayar Tagihan",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}

class SemuaTab extends StatelessWidget {
  const SemuaTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ExpansionTile(
          title: const Text("Semester 1"),
          children: [
            cardItem("Her Registrasi", "Rp. 300.000", "Rp. 300.000", "Lunas"),
            cardItem("Internet", "Rp. 300.000", "Rp. 300.000", "Lunas"),
            cardItem("Kemahasiswaan", "Rp. 300.000", "Rp. 300.000", "Lunas"),
            cardItem("Registrasi Semester 1", "Rp. 300.000", "Rp. 300.000", "Lunas"),
            cardItem("Kepanitiaan Semester 1", "Rp. 300.000", "Rp. 300.000", "Lunas"),
            cardItem("DPP UAS Semester 1", "Rp. 1.500.000", "Rp. 0", "Belum Lunas"),
          ],
        ),
        ExpansionTile(
          title: const Text("DPP"),
          children: [cardItem("DPP", "Rp. 1.500.000", "Rp. 0", "Belum Lunas")],
        ),
        ExpansionTile(
          title: const Text("Biaya Pokok"),
          children: [cardItem("SPP", "Rp. 300.000", "Rp. 300.000", "Lunas")],
        ),
      ],
    );
  }
}

class RiwayatTab extends StatelessWidget {
  const RiwayatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            title: const Text("Kode Pembayaran: 1291732"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Tanggal: 27 September 2025 - 19:00:45"),
                Text("Bank: BCA"),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Rp. 300.000",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "Lunas",
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Widget reusable
Widget cardItem(String title, String totalTagihan, String totalDibayarkan, String status) {
  Color statusColor;
  if (status == "Lunas") {
    statusColor = Colors.green;
  } else if (status == "Belum Lunas") {
    statusColor = Colors.red;
  } else if (status == "Dispensasi") {
    statusColor = Colors.orange;
  } else {
    statusColor = Colors.blueGrey;
  }

  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 6),
          Text("Total Tagihan: $totalTagihan"),
          Text("Total Dibayarkan: $totalDibayarkan"),
        ],
      ),
    ),
  );
}
