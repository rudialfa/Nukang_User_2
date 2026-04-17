import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// MODEL
// ─────────────────────────────────────────────────────────────
class ProgresItem {
  final int percent;
  final String label;
  final String deskripsi;
  final DateTime? waktu;
  final List<String> imageUrls;

  const ProgresItem({
    required this.percent,
    required this.label,
    required this.deskripsi,
    this.waktu,
    this.imageUrls = const [],
  });
}

// ─────────────────────────────────────────────────────────────
// HALAMAN UTAMA DENGAN 2 TAB
// ─────────────────────────────────────────────────────────────
class ProgresPage extends StatefulWidget {
  const ProgresPage({super.key});

  @override
  State<ProgresPage> createState() => _ProgresPageState();
}

class _ProgresPageState extends State<ProgresPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Progres',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          tabs: const [
            Tab(
              icon: Icon(Icons.search_outlined),
              text: 'Survei',
            ),
            Tab(
              icon: Icon(Icons.construction_outlined),
              text: 'Pekerjaan',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _ProgresTabContent(type: ProgresType.survei),
          _ProgresTabContent(type: ProgresType.pekerjaan),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// ENUM TIPE
// ─────────────────────────────────────────────────────────────
enum ProgresType { survei, pekerjaan }

// ─────────────────────────────────────────────────────────────
// KONTEN TAB (dipakai oleh Survei & Pekerjaan)
// ─────────────────────────────────────────────────────────────
class _ProgresTabContent extends StatelessWidget {
  final ProgresType type;

  const _ProgresTabContent({required this.type});

  String get workerName => 'Budi Santoso';
  String get projectTitle => type == ProgresType.survei
      ? 'Survei Instalasi Listrik'
      : 'Perbaikan Instalasi Listrik';

  int get currentStep => type == ProgresType.survei ? 2 : 1;

  List<ProgresItem> get progressList => type == ProgresType.survei
      ? _surveiItems()
      : _pekerjaanItems();

  List<ProgresItem> _surveiItems() => [
        ProgresItem(
          percent: 0,
          label: 'Mulai Survei',
          deskripsi: 'Pekerja tiba di lokasi dan memulai survei.',
          waktu: DateTime(2025, 4, 1, 9, 0),
          imageUrls: [
            'https://images.unsplash.com/photo-1504307651254-35680f356dfd?w=400',
          ],
        ),
        ProgresItem(
          percent: 25,
          label: 'Pemeriksaan Awal',
          deskripsi: 'Pemeriksaan kondisi awal lokasi selesai.',
          waktu: DateTime(2025, 4, 1, 10, 30),
          imageUrls: [
            'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=400',
            'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400',
          ],
        ),
        ProgresItem(
          percent: 50,
          label: 'Survei Setengah Jalan',
          deskripsi: 'Setengah area sudah disurvei dan dicatat.',
          waktu: DateTime(2025, 4, 1, 12, 0),
          imageUrls: [
            'https://images.unsplash.com/photo-1590736704728-f4730bb30770?w=400',
            'https://images.unsplash.com/photo-1504307651254-35680f356dfd?w=400',
          ],
        ),
        const ProgresItem(
          percent: 75,
          label: 'Hampir Selesai',
          deskripsi: 'Sebagian besar area telah disurvei.',
        ),
        const ProgresItem(
          percent: 100,
          label: 'Selesai',
          deskripsi: 'Survei selesai! Laporan sedang disiapkan.',
        ),
      ];

  List<ProgresItem> _pekerjaanItems() => [
        ProgresItem(
          percent: 0,
          label: 'Mulai Pekerjaan',
          deskripsi: 'Pekerja tiba dan menyiapkan alat.',
          waktu: DateTime(2025, 4, 5, 8, 0),
          imageUrls: [
            'https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?w=400',
          ],
        ),
        ProgresItem(
          percent: 25,
          label: 'Tahap Awal',
          deskripsi: 'Pembongkaran dan persiapan area kerja.',
          waktu: DateTime(2025, 4, 5, 10, 0),
          imageUrls: [
            'https://images.unsplash.com/photo-1504307651254-35680f356dfd?w=400',
          ],
        ),
        const ProgresItem(
          percent: 50,
          label: 'Setengah Jalan',
          deskripsi: 'Pemasangan komponen utama sedang berjalan.',
        ),
        const ProgresItem(
          percent: 75,
          label: 'Finalisasi',
          deskripsi: 'Penyelesaian dan pengecekan hasil kerja.',
        ),
        const ProgresItem(
          percent: 100,
          label: 'Selesai',
          deskripsi: 'Pekerjaan selesai dan siap diserahkan.',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final totalPercent = progressList[currentStep].percent;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header Info ──
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white24,
                      radius: 24,
                      child: Icon(Icons.engineering,
                          color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            workerName,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            projectTitle,
                            style: const TextStyle(
                                fontSize: 13, color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      type == ProgresType.survei
                          ? 'Progres Survei'
                          : 'Progres Pekerjaan',
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 13),
                    ),
                    Text(
                      '$totalPercent%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: totalPercent / 100,
                    minHeight: 10,
                    backgroundColor: Colors.white30,
                    valueColor:
                        const AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          Text(
            type == ProgresType.survei ? 'Tahapan Survei' : 'Tahapan Pekerjaan',
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          const SizedBox(height: 16),

          // ── Stepper ──
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: progressList.length,
            itemBuilder: (context, index) {
              final step = progressList[index];
              final bool isActive = index == currentStep;
              final bool isDone = index < currentStep;
              final bool isLast = index == progressList.length - 1;

              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Lingkaran + garis
                    SizedBox(
                      width: 48,
                      child: Column(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: (isDone || isActive)
                                  ? const Color(0xFF1976D2)
                                  : Colors.grey[300],
                              shape: BoxShape.circle,
                              boxShadow: isActive
                                  ? [
                                      BoxShadow(
                                        color: const Color(0xFF1976D2)
                                            .withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      )
                                    ]
                                  : null,
                            ),
                            child: Center(
                              child: isDone
                                  ? const Icon(Icons.check,
                                      color: Colors.white, size: 20)
                                  : Text(
                                      step.percent == 100
                                          ? '✓'
                                          : '${step.percent}%',
                                      style: TextStyle(
                                        color: isActive
                                            ? Colors.white
                                            : Colors.grey[500],
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                          if (!isLast)
                            Expanded(
                              child: Container(
                                width: 2,
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                color: isDone
                                    ? const Color(0xFF1976D2)
                                    : Colors.grey[300],
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Konten kanan
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 12,
                          bottom: isLast ? 0 : 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    step.label,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: isActive
                                          ? FontWeight.bold
                                          : FontWeight.w600,
                                      color: isActive
                                          ? const Color(0xFF1976D2)
                                          : isDone
                                              ? Colors.black87
                                              : Colors.grey[500],
                                    ),
                                  ),
                                ),
                                if (isActive)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1976D2)
                                          .withOpacity(0.1),
                                      borderRadius:
                                          BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      'Sekarang',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFF1976D2),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            if (isDone || isActive) ...[
                              const SizedBox(height: 4),
                              Text(
                                step.deskripsi,
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[600]),
                              ),
                            ],
                            if (step.waktu != null) ...[
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.access_time,
                                      size: 13, color: Colors.grey[400]),
                                  const SizedBox(width: 4),
                                  Text(
                                    _formatWaktu(step.waktu!),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[400]),
                                  ),
                                ],
                              ),
                            ],
                            if (step.imageUrls.isNotEmpty) ...[
                              const SizedBox(height: 12),
                              _buildFotoGrid(context, step.imageUrls),
                            ],
                            const SizedBox(height: 4),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFotoGrid(BuildContext context, List<String> urls) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(urls.length, (i) {
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => _GaleriFotoPage(
                imageUrls: urls,
                initialIndex: i,
              ),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  urls[i],
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 90,
                    height: 90,
                    color: Colors.grey[200],
                    child: const Icon(Icons.broken_image,
                        color: Colors.grey, size: 32),
                  ),
                  loadingBuilder: (_, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      width: 90,
                      height: 90,
                      color: Colors.grey[100],
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFF1976D2),
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.zoom_in,
                        color: Colors.white, size: 13),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  String _formatWaktu(DateTime dt) {
    final jam = dt.hour.toString().padLeft(2, '0');
    final menit = dt.minute.toString().padLeft(2, '0');
    return '${dt.day}/${dt.month}/${dt.year} $jam:$menit';
  }
}

// ─────────────────────────────────────────────────────────────
// HALAMAN GALERI FOTO (fullscreen)
// ─────────────────────────────────────────────────────────────
class _GaleriFotoPage extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const _GaleriFotoPage({
    required this.imageUrls,
    required this.initialIndex,
  });

  @override
  State<_GaleriFotoPage> createState() => _GaleriFotoPageState();
}

class _GaleriFotoPageState extends State<_GaleriFotoPage> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('Foto ${_currentIndex + 1} / ${widget.imageUrls.length}'),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.imageUrls.length,
        onPageChanged: (i) => setState(() => _currentIndex = i),
        itemBuilder: (context, index) => InteractiveViewer(
          child: Center(
            child: Image.network(
              widget.imageUrls[index],
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.broken_image,
                color: Colors.white54,
                size: 64,
              ),
              loadingBuilder: (_, child, progress) {
                if (progress == null) return child;
                return const Center(
                    child: CircularProgressIndicator(color: Colors.white));
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: widget.imageUrls.length > 1
          ? Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.imageUrls.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: i == _currentIndex ? 20 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: i == _currentIndex
                          ? Colors.white
                          : Colors.white30,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}