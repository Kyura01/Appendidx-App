import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

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
      home: const SplashScreen(),
    );
  }
}

// ==========================================
// 1. SPLASH SCREEN (Animated)
// ==========================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;
  late Animation<double> _slideAnim;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.easeOut),
    );

    _scaleAnim = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.elasticOut),
    );

    _slideAnim = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.easeOutCubic),
    );

    _pulseAnim = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _mainController.forward();

    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const MainNavigator(),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (context, anim, secondaryAnimation, child) {
              return FadeTransition(opacity: anim, child: child);
            },
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF81C784), Color(0xFF66BB6A), Color(0xFF4CAF50)],
          ),
        ),
        child: AnimatedBuilder(
          animation: _mainController,
          builder: (context, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo with double ring
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: ScaleTransition(
                      scale: _scaleAnim,
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.15),
                        ),
                        child: Center(
                          child: Container(
                            width: 105,
                            height: 105,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.25),
                            ),
                            child: Center(
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x30000000),
                                      blurRadius: 20,
                                      offset: Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.local_hospital_rounded,
                                    size: 40,
                                    color: Color(0xFF81C784),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // App name
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: Transform.translate(
                      offset: Offset(0, _slideAnim.value),
                      child: Text(
                        'AppendiDx',
                        style: GoogleFonts.poppins(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Tagline
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: Transform.translate(
                      offset: Offset(0, _slideAnim.value),
                      child: Text(
                        'Think Clinically, Diagnose Precisely',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.white.withValues(alpha: 0.85),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Pulsing loading dots
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: AnimatedBuilder(
                      animation: _pulseAnim,
                      builder: (context, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(3, (i) {
                            final delay = i * 0.2;
                            final val = ((_pulseAnim.value + delay) % 1.0);
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.4 + val * 0.6),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// ==========================================
// 2. MAIN NAVIGATOR (3 Tabs + Center FAB)
// ==========================================
class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HalamanEdukasi(),
    const HalamanKalkulator(),
    const HalamanTentang(),
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
      floatingActionButton: _selectedIndex != 1
          ? FloatingActionButton(
              onPressed: () => _onItemTapped(1),
              backgroundColor: const Color(0xFF81C784),
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.calculate_rounded, color: Colors.white, size: 28),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: const Color(0xFF81C784),
            unselectedItemColor: Colors.grey.shade400,
            selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 11),
            unselectedLabelStyle: GoogleFonts.poppins(fontSize: 11),
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
              BottomNavigationBarItem(
                icon: Icon(Icons.info_outline_rounded),
                activeIcon: Icon(Icons.info_rounded, size: 28),
                label: 'Tentang',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 3. HALAMAN EDUKASI (with Doctor Illustration)
// ==========================================
class HalamanEdukasi extends StatelessWidget {
  const HalamanEdukasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Belajar Apendisitis 📚',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
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
            // Banner with doctor illustration
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF81C784), Color(0xFF66BB6A)],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF81C784).withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo, Nakes! 👋',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Mari segarkan kembali ingatan kita tentang Apendisitis sebelum melakukan diagnosa.',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.white.withValues(alpha: 0.9),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Doctor illustration
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person_rounded, size: 28, color: Color(0xFF81C784)),
                            Icon(Icons.local_hospital_rounded, size: 16, color: Color(0xFFFFB7B2)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            Text(
              'Materi Ringkas',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2D3A35),
              ),
            ),
            const SizedBox(height: 15),

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
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          leading: Text(icon, style: const TextStyle(fontSize: 28)),
          title: Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: const Color(0xFF2D3A35),
            ),
          ),
          iconColor: const Color(0xFF81C784),
          collapsedIconColor: Colors.grey.shade400,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Text(
                content,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  height: 1.5,
                  color: const Color(0xFF55605C),
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
// 4. HALAMAN KALKULATOR (Alvarado Score)
// ==========================================
class HalamanKalkulator extends StatefulWidget {
  const HalamanKalkulator({super.key});

  @override
  State<HalamanKalkulator> createState() => _HalamanKalkulatorState();
}

class _HalamanKalkulatorState extends State<HalamanKalkulator> {
  bool _migrasiNyeri = false;
  bool _anoreksia = false;
  bool _mualMuntah = false;
  bool _nyeriKananBawah = false;
  bool _nyeriLepas = false;
  bool _demam = false;
  bool _leukositosis = false;
  bool _shiftToLeft = false;

  int get _currentScore {
    int skor = 0;
    if (_migrasiNyeri) skor += 1;
    if (_anoreksia) skor += 1;
    if (_mualMuntah) skor += 1;
    if (_nyeriKananBawah) skor += 2;
    if (_nyeriLepas) skor += 1;
    if (_demam) skor += 1;
    if (_leukositosis) skor += 2;
    if (_shiftToLeft) skor += 1;
    return skor;
  }

  int get _activeCount {
    int count = 0;
    if (_migrasiNyeri) count++;
    if (_anoreksia) count++;
    if (_mualMuntah) count++;
    if (_nyeriKananBawah) count++;
    if (_nyeriLepas) count++;
    if (_demam) count++;
    if (_leukositosis) count++;
    if (_shiftToLeft) count++;
    return count;
  }

  Color _getScoreColor(int skor) {
    if (skor <= 4) return const Color(0xFF81C784);
    if (skor <= 6) return const Color(0xFFFFB74D);
    if (skor <= 8) return const Color(0xFFFF8A65);
    return const Color(0xFFE57373);
  }

  void _resetAll() {
    setState(() {
      _migrasiNyeri = false;
      _anoreksia = false;
      _mualMuntah = false;
      _nyeriKananBawah = false;
      _nyeriLepas = false;
      _demam = false;
      _leukositosis = false;
      _shiftToLeft = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.refresh_rounded, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text('Semua kriteria telah direset ✨', style: GoogleFonts.poppins()),
          ],
        ),
        backgroundColor: const Color(0xFF81C784),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _hitungSkor() {
    HapticFeedback.mediumImpact();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.checklist_rounded, color: Color(0xFF81C784), size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Konfirmasi Perhitungan',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: const Color(0xFF2D3A35),
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Pastikan semua data klinis sudah terisi dengan benar sebelum menghitung skor Alvarado.',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF55605C),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FCFB),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$_activeCount',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF81C784),
                    ),
                  ),
                  Text(
                    ' / 8 kriteria aktif',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color(0xFF55605C),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: Text(
              'Periksa Lagi',
              style: GoogleFonts.poppins(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _showHasilBottomSheet(_currentScore);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF81C784),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: Text(
              'Hitung Sekarang',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  void _showHasilBottomSheet(int skor) {
    String riskLabel;
    String emoji;
    String recommendation;
    Color riskColor;

    if (skor <= 4) {
      riskLabel = 'Risiko Rendah';
      emoji = '✅';
      riskColor = const Color(0xFF81C784);
      recommendation =
          'Skor menunjukkan kemungkinan bukan apendisitis. Disarankan untuk tetap melakukan observasi dan evaluasi ulang jika gejala menetap atau memberat.';
    } else if (skor <= 6) {
      riskLabel = 'Risiko Sedang';
      emoji = '⚠️';
      riskColor = const Color(0xFFFFB74D);
      recommendation =
          'Kemungkinan apendisitis tidak dapat disingkirkan. Diperlukan investigasi lanjutan seperti USG abdomen atau CT-Scan untuk konfirmasi diagnosis.';
    } else if (skor <= 8) {
      riskLabel = 'Risiko Tinggi';
      emoji = '🚨';
      riskColor = const Color(0xFFFF8A65);
      recommendation =
          'Kemungkinan besar apendisitis. Segera konsultasikan ke dokter bedah untuk evaluasi lebih lanjut dan persiapan kemungkinan tindakan operasi.';
    } else {
      riskLabel = 'Hampir Pasti Apendisitis';
      emoji = '🏥';
      riskColor = const Color(0xFFE57373);
      recommendation =
          'Skor menunjukkan diagnosis apendisitis yang sangat kuat. Segera siapkan pasien untuk tindakan apendiktomi (operasi pengangkatan usus buntu).';
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 24),

            // Emoji
            Text(emoji, style: const TextStyle(fontSize: 48)),
            const SizedBox(height: 16),

            // Title
            Text(
              'Hasil Skor Alvarado',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2D3A35),
              ),
            ),
            const SizedBox(height: 20),

            // Gauge meter
            SizedBox(
              width: 200,
              height: 120,
              child: CustomPaint(
                painter: GaugePainter(score: skor, color: riskColor),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$skor',
                          style: GoogleFonts.poppins(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: riskColor,
                          ),
                        ),
                        Text(
                          'dari 10',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: const Color(0xFF55605C),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Risk badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              decoration: BoxDecoration(
                color: riskColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: riskColor.withValues(alpha: 0.3), width: 1.5),
              ),
              child: Text(
                riskLabel,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: riskColor,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Recommendation card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FCFB),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.medical_information_rounded, size: 20, color: riskColor),
                      const SizedBox(width: 8),
                      Text(
                        'Rekomendasi Klinis',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: const Color(0xFF2D3A35),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    recommendation,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      height: 1.6,
                      color: const Color(0xFF55605C),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Hitung Ulang button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(ctx),
                icon: const Icon(Icons.refresh_rounded, size: 20),
                label: Text(
                  'Hitung Ulang',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF81C784),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(ctx).padding.bottom + 8),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scoreColor = _getScoreColor(_currentScore);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kalkulator Alvarado 🩺',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _resetAll,
            icon: const Icon(Icons.refresh_rounded, color: Color(0xFF81C784)),
            tooltip: 'Reset Semua',
          ),
        ],
      ),
      body: Column(
        children: [
          // Live score indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: scoreColor.withValues(alpha: 0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: scoreColor.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Skor Saat Ini',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF55605C),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: scoreColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          '$_currentScore / 10',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: scoreColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: _currentScore / 10),
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      builder: (context, value, _) {
                        return LinearProgressIndicator(
                          value: value,
                          minHeight: 10,
                          backgroundColor: const Color(0xFFF0F4F2),
                          valueColor: AlwaysStoppedAnimation<Color>(scoreColor),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$_activeCount / 8 kriteria aktif',
                        style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey),
                      ),
                      Text(
                        _currentScore <= 4
                            ? 'Rendah'
                            : _currentScore <= 6
                                ? 'Sedang'
                                : _currentScore <= 8
                                    ? 'Tinggi'
                                    : 'Definitif',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: scoreColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Isi form MANTRELS di bawah ini sesuai dengan gejala klinis pasien:',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: const Color(0xFF55605C),
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildSectionTitle('Gejala (Symptoms)'),
                  _buildToggleCard(
                    title: 'Migrasi Nyeri (Migration)',
                    subtitle: 'Nyeri berpindah ke perut kanan bawah',
                    scoreValue: 1,
                    value: _migrasiNyeri,
                    onChanged: (val) => setState(() => _migrasiNyeri = val),
                  ),
                  _buildToggleCard(
                    title: 'Anoreksia (Anorexia)',
                    subtitle: 'Kehilangan nafsu makan',
                    scoreValue: 1,
                    value: _anoreksia,
                    onChanged: (val) => setState(() => _anoreksia = val),
                  ),
                  _buildToggleCard(
                    title: 'Mual / Muntah (Nausea)',
                    subtitle: 'Pasien merasa mual atau muntah',
                    scoreValue: 1,
                    value: _mualMuntah,
                    onChanged: (val) => setState(() => _mualMuntah = val),
                  ),

                  const SizedBox(height: 10),
                  _buildSectionTitle('Tanda Klinis (Signs)'),
                  _buildToggleCard(
                    title: 'Nyeri Kuadran Kanan Bawah',
                    subtitle: 'Tenderness di area Iliaka Dekstra',
                    scoreValue: 2,
                    value: _nyeriKananBawah,
                    onChanged: (val) => setState(() => _nyeriKananBawah = val),
                  ),
                  _buildToggleCard(
                    title: 'Nyeri Tekan Lepas (Rebound)',
                    subtitle: 'Nyeri saat tekanan di perut dilepaskan',
                    scoreValue: 1,
                    value: _nyeriLepas,
                    onChanged: (val) => setState(() => _nyeriLepas = val),
                  ),
                  _buildToggleCard(
                    title: 'Demam (Elevated Temp)',
                    subtitle: 'Suhu tubuh > 37.3°C',
                    scoreValue: 1,
                    value: _demam,
                    onChanged: (val) => setState(() => _demam = val),
                  ),

                  const SizedBox(height: 10),
                  _buildSectionTitle('Laboratorium (Lab)'),
                  _buildToggleCard(
                    title: 'Leukositosis',
                    subtitle: 'Leukosit > 10.000 sel/mm³',
                    scoreValue: 2,
                    value: _leukositosis,
                    onChanged: (val) => setState(() => _leukositosis = val),
                  ),
                  _buildToggleCard(
                    title: 'Shift to the Left',
                    subtitle: 'Neutrofil segmen > 75%',
                    scoreValue: 1,
                    value: _shiftToLeft,
                    onChanged: (val) => setState(() => _shiftToLeft = val),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Bottom button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: _hitungSkor,
                icon: const Icon(Icons.calculate_rounded, size: 22),
                label: Text(
                  'Hitung Skor Sekarang',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF81C784),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 5),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 18,
            decoration: BoxDecoration(
              color: const Color(0xFF81C784),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF81C784),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleCard({
    required String title,
    required String subtitle,
    required int scoreValue,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: const Color(0xFF2D3A35),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: value
                      ? const Color(0xFF81C784).withValues(alpha: 0.15)
                      : const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '+$scoreValue Poin',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF81C784),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 15),

          // Animated Toggle
          Container(
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F4F2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      onChanged(false);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: !value ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: !value
                            ? [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.06),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                )
                              ]
                            : [],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Tidak',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: !value ? const Color(0xFF2D3A35) : Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      onChanged(true);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: value ? const Color(0xFF81C784) : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: value
                            ? [
                                BoxShadow(
                                  color: const Color(0xFF81C784).withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                )
                              ]
                            : [],
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (value)
                            const Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Icon(Icons.check_rounded, color: Colors.white, size: 16),
                            ),
                          Text(
                            'Ya',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: value ? Colors.white : Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 5. GAUGE PAINTER (Custom Arc Meter)
// ==========================================
class GaugePainter extends CustomPainter {
  final int score;
  final Color color;

  GaugePainter({required this.score, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height - 10);
    final radius = size.width / 2 - 15;

    // Background arc
    final bgPaint = Paint()
      ..color = const Color(0xFFF0F4F2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      pi,
      false,
      bgPaint,
    );

    // Score arc
    final scorePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    final sweepAngle = (score / 10) * pi;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      sweepAngle,
      false,
      scorePaint,
    );

    // Tick marks
    for (int i = 0; i <= 10; i++) {
      final angle = pi + (i / 10) * pi;
      final outerPoint = Offset(
        center.dx + (radius + 10) * cos(angle),
        center.dy + (radius + 10) * sin(angle),
      );
      final innerPoint = Offset(
        center.dx + (radius + 4) * cos(angle),
        center.dy + (radius + 4) * sin(angle),
      );

      final tickPaint = Paint()
        ..color = i <= score ? color.withValues(alpha: 0.6) : Colors.grey.shade300
        ..strokeWidth = i % 5 == 0 ? 2.5 : 1.5
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(innerPoint, outerPoint, tickPaint);
    }

    // Dot indicator at score position
    final dotAngle = pi + (score / 10) * pi;
    final dotPos = Offset(
      center.dx + radius * cos(dotAngle),
      center.dy + radius * sin(dotAngle),
    );

    canvas.drawCircle(
      dotPos,
      10,
      Paint()..color = color.withValues(alpha: 0.2),
    );
    canvas.drawCircle(
      dotPos,
      6,
      Paint()..color = Colors.white,
    );
    canvas.drawCircle(
      dotPos,
      4,
      Paint()..color = color,
    );
  }

  @override
  bool shouldRepaint(covariant GaugePainter oldDelegate) {
    return oldDelegate.score != score || oldDelegate.color != color;
  }
}

// ==========================================
// 6. HALAMAN TENTANG (About Page)
// ==========================================
class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tentang Aplikasi 💡',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // App logo and name
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF81C784), Color(0xFF66BB6A)],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF81C784).withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.local_hospital_rounded,
                        size: 40,
                        color: Color(0xFF81C784),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'AppendiDx',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Versi 1.0.0',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            _buildInfoCard(
              icon: Icons.apps_rounded,
              iconColor: const Color(0xFF81C784),
              title: 'Tentang AppendiDx',
              content:
                  'AppendiDx (Apendisitis Diagnostics & Education) adalah aplikasi edukasi klinis yang dirancang untuk membantu mahasiswa kedokteran, perawat, bidan, dan tenaga kesehatan muda dalam mempelajari apendisitis serta menghitung Skor Alvarado (MANTRELS) secara cepat dan akurat.',
            ),

            _buildInfoCard(
              icon: Icons.analytics_rounded,
              iconColor: const Color(0xFFFFB74D),
              title: 'Apa itu Skor Alvarado?',
              content:
                  'Skor Alvarado (MANTRELS) adalah sistem penilaian klinis yang dikembangkan oleh Dr. Alfredo Alvarado pada tahun 1986. Sistem ini menggunakan 8 kriteria klinis dan laboratorium untuk membantu mendiagnosis apendisitis akut.\n\n'
                  'MANTRELS merupakan singkatan dari:\n'
                  'M - Migration of pain (1)\n'
                  'A - Anorexia (1)\n'
                  'N - Nausea/Vomiting (1)\n'
                  'T - Tenderness in RLQ (2)\n'
                  'R - Rebound pain (1)\n'
                  'E - Elevated temperature (1)\n'
                  'L - Leukocytosis (2)\n'
                  'S - Shift to the left (1)\n\n'
                  'Total skor maksimal: 10',
            ),

            _buildInfoCard(
              icon: Icons.warning_amber_rounded,
              iconColor: const Color(0xFFFFB7B2),
              title: 'Disclaimer Medis ⚕️',
              content:
                  'Aplikasi ini dibuat untuk tujuan EDUKASI dan SKRINING AWAL saja. AppendiDx bukan pengganti penilaian klinis profesional oleh dokter. Keputusan diagnosis dan tatalaksana akhir harus selalu dilakukan oleh tenaga medis yang berwenang berdasarkan pemeriksaan klinis menyeluruh.',
            ),

            _buildInfoCard(
              icon: Icons.code_rounded,
              iconColor: const Color(0xFF64B5F6),
              title: 'Pengembang',
              content:
                  'Dikembangkan sebagai proyek edukasi kesehatan menggunakan Flutter Framework.\n\n'
                  '© 2026 AppendiDx. Dibuat dengan ❤️ untuk tenaga kesehatan Indonesia.',
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: const Color(0xFF2D3A35),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            content,
            style: GoogleFonts.poppins(
              fontSize: 13,
              height: 1.6,
              color: const Color(0xFF55605C),
            ),
          ),
        ],
      ),
    );
  }
}
