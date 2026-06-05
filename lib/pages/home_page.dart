import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = '';

  @override
  void initState() { // PERBAIKAN: Menambahkan @override dan tipe void untuk best practice
    super.initState();  
    getUsername();
  }

  Future<void> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? '';
    });
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); 
  
    if (!mounted) return; // Mengamankan context async sebelum melakukan navigasi
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            // Nilai height diubah ke 150 (sesuai kode terakhir Anda) agar muat menampung tombol ke bawah
            height: 150,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: const NetworkImage(
                    'https://i.pravatar.cc/150?img=3',
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, // Memastikan Column tidak memakan space berlebih
                    children: [
                      Text(
                        "Hai, Selamat Datang, $username!",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            username,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.verified, 
                            color: Colors.blue, 
                            size: 16,
                          ),
                        ], // PERBAIKAN: Menghapus const SizedBox(height: 15) yang salah posisi di dalam Row
                      ),
                      const SizedBox(height: 10), // Jarak vertikal sebelum tombol logout
                      
                      // 🛠️ PERBAIKAN UTAMA: Memasang InkWell agar Container bisa diklik
                      InkWell(
                        onTap: logout, // Menjalankan fungsi logout saat ditekan
                        borderRadius: BorderRadius.circular(10), // Efek riak air (ripple) mengikuti bentuk tombol
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFB3E5FC).withOpacity(0.5),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.logout,
                            color: Colors.blue,
                            size: 24,
                          ),
                        ),
                      ), 
                    ], // PERBAIKAN: Menyusun ulang penutupan kurung array Column dan Induknya
                  ),
                ),
              ],
            ), 
          ),
        ),
      ),
    );
  }
}