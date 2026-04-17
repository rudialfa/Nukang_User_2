import 'package:flutter/material.dart';
import 'package:nukang_user_2/presentation/pages/worker_detail_pages.dart';
import 'worker_detail_pages.dart'; // Import file detail page
import 'survey_pages.dart';        // Import file survey page

class CategoryWorkersPage extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const CategoryWorkersPage({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<CategoryWorkersPage> createState() => _CategoryWorkersPageState();
}

class _CategoryWorkersPageState extends State<CategoryWorkersPage> {
  List<Worker> workers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWorkers();
  }

  void _loadWorkers() {
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        workers = _getWorkersByCategory(widget.categoryId);
        isLoading = false;
      });
    });
  }

  List<Worker> _getWorkersByCategory(int categoryId) {
    final Map<int, List<Worker>> workersData = {
      1: _listrikWorkers(),
      2: _listrikWorkers(),
      3: _listrikWorkers(),
      4: _listrikWorkers(),
      5: _generatorWorkers(),
      6: _lampuWorkers(),
      7: _upsWorkers(),
      8: _cctvWorkers(),
      9: _solarWorkers(),
      10: _renovasiWorkers(),
      11: _catWorkers(),
      12: _plesterWorkers(),
      13: _keramikWorkers(),
      14: _atapWorkers(),
      15: _pintuWorkers(),
      16: _bataWorkers(),
      17: _besiWorkers(),
      18: _rangkaWorkers(),
      19: _saluranWorkers(),
      20: _pompaWorkers(),
      21: _toiletWorkers(),
      22: _showerWorkers(),
      23: _bocorWorkers(),
      24: _septicWorkers(),
      25: _acWorkers(),
      26: _mesincuciWorkers(),
      27: _tvWorkers(),
      28: _komputerWorkers(),
      29: _printerWorkers(),
      30: _audioWorkers(),
      31: _mobilWorkers(),
      32: _motorWorkers(),
      33: _catmobilWorkers(),
      34: _banWorkers(),
      35: _kunciWorkers(),
      36: _lasWorkers(),
    };
    return workersData[categoryId] ?? [];
  }

  List<Worker> _listrikWorkers() => [
    Worker(id: '1', name: 'Budi Listrik Expert', rating: 4.9, reviews: 245, distance: '1.2 km', priceRange: 'Rp50rb - Rp300rb', specialty: 'Instalasi & Perbaikan', image: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150'),
    Worker(id: '2', name: 'Slamet Tukang Solder', rating: 4.8, reviews: 189, distance: '0.8 km', priceRange: 'Rp40rb - Rp250rb', specialty: 'Kabel & Rangkaian', image: 'https://images.unsplash.com/photo-1594736797933-d0d1232c3f1d?w=150'),
    Worker(id: '3', name: 'Joko Panel Listrik', rating: 4.7, reviews: 156, distance: '2.1 km', priceRange: 'Rp80rb - Rp500rb', specialty: 'Panel & MCB', image: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=150'),
  ];

  List<Worker> _generatorWorkers() => [
    Worker(id: '51', name: 'Agus Genset Pro', rating: 4.9, reviews: 89, distance: '3.5 km', priceRange: 'Rp200rb - Rp1jt', specialty: 'Generator Diesel', image: 'https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?w=150'),
    Worker(id: '52', name: 'Dedi Genset Service', rating: 4.6, reviews: 67, distance: '4.2 km', priceRange: 'Rp150rb - Rp800rb', specialty: 'Perawatan Genset', image: 'https://images.unsplash.com/photo-1601784551446-20c9e07cdbdb?w=150'),
  ];

  List<Worker> _renovasiWorkers() => [
    Worker(id: '101', name: 'Joko Renovasi Pro', rating: 4.9, reviews: 201, distance: '2.1 km', priceRange: 'Rp75rb - Rp500rb', specialty: 'Renovasi Total', image: 'https://images.unsplash.com/photo-1552053831-71594a27632d?w=150'),
    Worker(id: '102', name: 'Ahmad Tukang Batu', rating: 4.7, reviews: 167, distance: '1.5 km', priceRange: 'Rp60rb - Rp400rb', specialty: 'Dinding & Plester', image: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=150'),
  ];

  List<Worker> _catWorkers() => [
    Worker(id: '111', name: 'Sari Pen Painter', rating: 4.9, reviews: 234, distance: '0.9 km', priceRange: 'Rp40rb - Rp200rb', specialty: 'Cat Interior', image: 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=150'),
    Worker(id: '112', name: 'Rudi Air Brush', rating: 4.8, reviews: 198, distance: '1.8 km', priceRange: 'Rp50rb - Rp250rb', specialty: 'Cat Eksterior', image: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=150'),
  ];

  List<Worker> _saluranWorkers() => [
    Worker(id: '191', name: 'Udin Tukang Ledeng', rating: 4.9, reviews: 156, distance: '1.4 km', priceRange: 'Rp70rb - Rp350rb', specialty: 'Pipa & Saluran', image: 'https://images.unsplash.com/photo-1541643601528-2b278ef798a2?w=150'),
    Worker(id: '192', name: 'Eko Plumbing Pro', rating: 4.8, reviews: 123, distance: '2.3 km', priceRange: 'Rp60rb - Rp300rb', specialty: 'Unclog & Perbaikan', image: 'https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?w=150'),
  ];

  List<Worker> _acWorkers() => [
    Worker(id: '251', name: 'Bambang AC Service', rating: 4.9, reviews: 134, distance: '1.1 km', priceRange: 'Rp100rb - Rp400rb', specialty: 'AC Split & Window', image: 'https://images.unsplash.com/photo-1592621917627-68e8dd7069e8?w=150'),
    Worker(id: '252', name: 'Yanto Kulkas Dingin', rating: 4.7, reviews: 98, distance: '2.8 km', priceRange: 'Rp80rb - Rp350rb', specialty: 'Kulkas & Freezer', image: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=150'),
  ];

  List<Worker> _placeholderWorkers() => [
    Worker(id: '999', name: 'Tukang Profesional', rating: 4.8, reviews: 50, distance: '1.5 km', priceRange: 'Rp50rb - Rp300rb', specialty: 'Spesialis', image: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150'),
  ];

  // Placeholder untuk kategori lainnya
  List<Worker> _lampuWorkers() => _placeholderWorkers();
  List<Worker> _upsWorkers() => _placeholderWorkers();
  List<Worker> _cctvWorkers() => _placeholderWorkers();
  List<Worker> _solarWorkers() => _placeholderWorkers();
  List<Worker> _plesterWorkers() => _placeholderWorkers();
  List<Worker> _keramikWorkers() => _placeholderWorkers();
  List<Worker> _atapWorkers() => _placeholderWorkers();
  List<Worker> _pintuWorkers() => _placeholderWorkers();
  List<Worker> _bataWorkers() => _placeholderWorkers();
  List<Worker> _besiWorkers() => _placeholderWorkers();
  List<Worker> _rangkaWorkers() => _placeholderWorkers();
  List<Worker> _pompaWorkers() => _placeholderWorkers();
  List<Worker> _toiletWorkers() => _placeholderWorkers();
  List<Worker> _showerWorkers() => _placeholderWorkers();
  List<Worker> _bocorWorkers() => _placeholderWorkers();
  List<Worker> _septicWorkers() => _placeholderWorkers();
  List<Worker> _mesincuciWorkers() => _placeholderWorkers();
  List<Worker> _tvWorkers() => _placeholderWorkers();
  List<Worker> _komputerWorkers() => _placeholderWorkers();
  List<Worker> _printerWorkers() => _placeholderWorkers();
  List<Worker> _audioWorkers() => _placeholderWorkers();
  List<Worker> _mobilWorkers() => _placeholderWorkers();
  List<Worker> _motorWorkers() => _placeholderWorkers();
  List<Worker> _catmobilWorkers() => _placeholderWorkers();
  List<Worker> _banWorkers() => _placeholderWorkers();
  List<Worker> _kunciWorkers() => _placeholderWorkers();
  List<Worker> _lasWorkers() => _placeholderWorkers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          if (isLoading)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator(color: Color(0xFF1976D2))),
            )
          else if (workers.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.work_off, size: 80, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'Belum ada pekerja\nuntuk kategori ini',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildWorkerCard(workers[index]),
                  childCount: workers.length,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      expandedHeight: 140,
      floating: false,
      pinned: true,
      backgroundColor: const Color(0xFF1976D2),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
        title: Text(
          widget.categoryName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        background: Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${workers.length} Tukang Tersedia',
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ METHOD INI YANG SUDAH DIPERBAIKI - SESUAI PERMINTAAN ANDA
  Widget _buildWorkerCard(Worker worker) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WorkerDetailPage(worker: worker),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Foto Profile
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(worker.image),
                  backgroundColor: Colors.grey[200],
                ),
                const SizedBox(width: 16),
                
                // Info Worker
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        worker.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      
                      // Rating & Distance
                      Row(
                        children: [
                          Row(
                            children: List.generate(
                              5,
                              (i) => Icon(
                                i < worker.rating.floor() ? Icons.star : Icons.star_border,
                                color: Colors.amber,
                                size: 14,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '(${worker.reviews} ulasan)',
                            style: const TextStyle(fontSize: 12),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.green.withAlpha(30),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              worker.distance,
                              style: TextStyle(
                                color: Colors.green[700],
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      
                      // Specialty
                      Text(
                        worker.specialty,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 6),
                      
                      // Price Range
                      Text(
                        worker.priceRange,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xFF1976D2),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Arrow Icon
                Icon(Icons.arrow_forward_ios, 
                     size: 16, 
                     color: const Color(0xFF1976D2)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Worker {
  final String id;
  final String name;
  final double rating;
  final int reviews;
  final String distance;
  final String priceRange;
  final String specialty;
  final String image;
  final String address;       // ← TAMBAH
  final int completedJobs;    // ← TAMBAH

  Worker({
    required this.id,
    required this.name,
    required this.rating,
    required this.reviews,
    required this.distance,
    required this.priceRange,
    required this.specialty,
    required this.image,
    this.address = 'Jl. Contoh No. 1, Jakarta', // ← TAMBAH (default)
    this.completedJobs = 0,                       // ← TAMBAH (default)
  });
}

// ─── MODEL REVIEW ────────────────────────────────────────────
class Review {
  final String name;
  final double rating;
  final String comment;
  final String date;

  Review({
    required this.name,
    required this.rating,
    required this.comment,
    required this.date,
  });
}

// ─── MODEL COMPLETED JOB ─────────────────────────────────────
class CompletedJob {
  final String title;
  final String date;
  final String location;
  final double rating;

  CompletedJob({
    required this.title,
    required this.date,
    required this.location,
    required this.rating,
  });
}