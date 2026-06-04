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
// 3. HALAMAN EDUKASI (Beranda) - Placeholder
// ==========================================
class HalamanEdukasi extends StatelessWidget {
  const HalamanEdukasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Materi Apendisitis'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Halaman Edukasi akan dibuat di sini'),
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