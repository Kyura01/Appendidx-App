import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const AppendiDxApp());
}

class AppendiDxApp extends StatelessWidget {
  const AppendiDxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppendiDx',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9FCFB),
        primaryColor: const Color(0xFF81C784),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF81C784),
          primary: const Color(0xFF81C784),
          secondary: const Color(0xFFFFB7B2),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ).apply(
          bodyColor: const Color(0xFF2D3A35),
          displayColor: const Color(0xFF2D3A35),
        ),
      ),
      // Aplikasi dimulai dari Splash Screen
      home: const SplashScreen(),
    );
  }
}

// ==========================================
// 1. SPLASH SCREEN (Layar Loading 2 Detik)
// ==========================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Berpindah ke MainNavigator setelah 2.5 detik
    Future.delayed(const Duration(milliseconds: 2500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainNavigator()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF81C784), // Latar belakang hijau mint
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo sementara menggunakan Icon (Bisa diganti gambar nanti)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Text(
                '🩺',
                style: TextStyle(fontSize: 60),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'AppendiDx',
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Think Clinically, Diagnose Precisely',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 2. BOTTOM NAVIGATION BAR (Navigasi Bawah)
// ==========================================
class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 0;

  // Daftar halaman yang akan ditampilkan
  final List<Widget> _pages = [
    const HalamanEdukasi(), // Index 0
    const HalamanKalkulator(), // Index 1
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: const Color(0xFF81C784),
            unselectedItemColor: Colors.grey.shade400,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            showUnselectedLabels: true,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_rounded),
                activeIcon: Icon(Icons.menu_book_rounded, size: 28),
                label: 'Edukasi',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calculate_outlined),
                activeIcon: Icon(Icons.calculate_rounded, size: 28),
                label: 'Kalkulator',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 3. HALAMAN EDUKASI (Beranda)
// ==========================================
class HalamanEdukasi extends StatelessWidget {
  const HalamanEdukasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Belajar Apendisitis 📚'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Selamat Datang
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF81C784), // Hijau Utama
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF81C784).withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Halo, Nakes! 👋',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Mari segarkan kembali ingatan kita tentang Apendisitis sebelum melakukan diagnosa.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Judul Bagian Materi
            const Text(
              'Materi Ringkas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3A35),
              ),
            ),
            const SizedBox(height: 15),

            // Kumpulan Kartu Materi (ExpansionTile)
            _buildMateriCard(
              icon: '🦠',
              title: 'Apa itu Apendisitis?',
              content:
                  'Apendisitis adalah peradangan pada apendiks vermiformis (usus buntu). Kondisi ini merupakan salah satu kasus kegawatdaruratan bedah abdomen yang paling sering terjadi dan memerlukan tindakan segera untuk mencegah komplikasi seperti perforasi (kebocoran).',
            ),
            _buildMateriCard(
              icon: '🤒',
              title: 'Tanda & Gejala Khas',
              content:
                  '• Nyeri awal di sekitar pusar (periumbilikal) yang kemudian berpindah ke perut kanan bawah.\n'
                  '• Anoreksia (hilang nafsu makan).\n'
                  '• Mual dan muntah.\n'
                  '• Demam ringan (terasa sumeng).\n'
                  '• Nyeri tekan lepas di area perut kanan bawah (Titik McBurney).',
            ),
            _buildMateriCard(
              icon: '📋',
              title: 'Klasifikasi Apendisitis',
              content:
                  '1. Apendisitis Akut: Peradangan mendadak, butuh penanganan segera.\n'
                  '2. Apendisitis Kronis: Nyeri berulang dalam waktu lama (jarang terjadi).\n'
                  '3. Apendisitis Perforasi: Usus buntu telah pecah, menyebabkan infeksi menyebar ke rongga perut (Peritonitis).',
            ),
            _buildMateriCard(
              icon: '💉',
              title: 'Tatalaksana Umum',
              content:
                  '• Puasa (NPO) sebagai persiapan kemungkinan operasi.\n'
                  '• Pemberian cairan IV (infus) untuk rehidrasi.\n'
                  '• Analgesik dan Antibiotik spektrum luas.\n'
                  '• Apendiktomi (operasi pengangkatan usus buntu) adalah pengobatan definitif utama.',
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Fungsi bantuan (Widget) untuk membuat kartu materi yang imut
  Widget _buildMateriCard({
    required String icon,
    required String title,
    required String content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        // Menghilangkan garis pembatas default dari ExpansionTile
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          leading: Text(icon, style: const TextStyle(fontSize: 28)),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xFF2D3A35),
            ),
          ),
          iconColor: const Color(0xFF81C784),
          collapsedIconColor: Colors.grey.shade400,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Text(
                content,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Color(0xFF55605C),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// ==========================================
// 4. HALAMAN KALKULATOR - Placeholder
// ==========================================
class HalamanKalkulator extends StatelessWidget {
  const HalamanKalkulator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alvarado Score'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Form Ya/Tidak akan dibuat di sini'),
      ),
    );
  }
}