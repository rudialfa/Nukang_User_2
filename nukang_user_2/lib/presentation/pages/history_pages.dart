import 'package:flutter/material.dart';

enum JobStatus { selesai, proses, dibatalkan }

class JobHistory {
  final String id;
  final String title;
  final String tukangName;
  final String date;
  final JobStatus status;
  final int price;
  final String imageUrl;
  final double? rating;

  JobHistory({
    required this.id,
    required this.title,
    required this.tukangName,
    required this.date,
    required this.status,
    required this.price,
    required this.imageUrl,
    this.rating,
  });
}

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _selectedFilter = 0; // 0: Semua, 1: Selesai, 2: Proses, 3: Dibatalkan

  final List<JobHistory> _jobHistories = [
    JobHistory(
      id: '001',
      title: 'Renovasi Rumah 2 Lantai',
      tukangName: 'Pak Budi - Tukang Tembok',
      date: '12 Jan 2024',
      status: JobStatus.selesai,
      price: 2500000,
      imageUrl: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=400',
      rating: 4.9,
    ),
    JobHistory(
      id: '002',
      title: 'Pengecatan Ruang Tamu',
      tukangName: 'Bu Sari - Penyakit',
      date: '10 Jan 2024',
      status: JobStatus.selesai,
      price: 800000,
      imageUrl: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400',
      rating: 5.0,
    ),
    JobHistory(
      id: '003',
      title: 'Pasang Keramik Kamar Mandi',
      tukangName: 'Mas Joko - Tukang Keramik',
      date: '08 Jan 2024',
      status: JobStatus.proses,
      price: 1500000,
      imageUrl: 'https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?w=400',
    ),
    JobHistory(
      id: '004',
      title: 'Bongkar Dinding Plaster',
      tukangName: 'Pak Slamet - Tukang Bongkar',
      date: '05 Jan 2024',
      status: JobStatus.dibatalkan,
      price: 500000,
      imageUrl: 'https://images.unsplash.com/photo-1600210492493-0946911123ea?w=400',
    ),
    JobHistory(
      id: '005',
      title: 'Instalasi Listrik Rumah',
      tukangName: 'Kang Udin - Tukang Listrik',
      date: '02 Jan 2024',
      status: JobStatus.selesai,
      price: 1200000,
      imageUrl: 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=400',
      rating: 4.7,
    ),
  ];

  List<JobHistory> get _filteredHistories {
    switch (_selectedFilter) {
      case 1:
        return _jobHistories.where((job) => job.status == JobStatus.selesai).toList();
      case 2:
        return _jobHistories.where((job) => job.status == JobStatus.proses).toList();
      case 3:
        return _jobHistories.where((job) => job.status == JobStatus.dibatalkan).toList();
      default:
        return _jobHistories;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          // Simulate refresh
          await Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                const Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Riwayat Pekerjaan',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Lihat semua pekerjaan kamu',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Filter Tabs
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildFilterTab('Semua', 0),
                      _buildFilterTab('Selesai', 1),
                      _buildFilterTab('Proses', 2),
                      _buildFilterTab('Dibatalkan', 3),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Total Jobs
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue[100]!),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.history, color: Color(0xFF1976D2)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Pekerjaan',
                              style: TextStyle(color: Colors.grey[600], fontSize: 14),
                            ),
                            Text(
                              '${_jobHistories.length} pekerjaan',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Job History List
                if (_filteredHistories.isEmpty)
                  Center(
                    child: Column(
                      children: [
                        Icon(Icons.history, size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'Belum ada riwayat pekerjaan',
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Pekerjaan pertama kamu akan muncul di sini',
                          style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filteredHistories.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) => _buildJobCard(_filteredHistories[index]),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterTab(String label, int index) {
    final isSelected = _selectedFilter == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = index),
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1976D2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF1976D2) : Colors.grey[300]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(JobStatus status) {
    Color color;
    String label;
    IconData icon;

    switch (status) {
      case JobStatus.selesai:
        color = Colors.green;
        label = 'Selesai';
        icon = Icons.check_circle;
        break;
      case JobStatus.proses:
        color = Colors.orange;
        label = 'Diproses';
        icon = Icons.schedule;
        break;
      case JobStatus.dibatalkan:
        color = Colors.red;
        label = 'Dibatalkan';
        icon = Icons.cancel;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard(JobHistory job) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Image + Status
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  job.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[200],
                    child: const Icon(Icons.construction, size: 40, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      job.tukangName,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      job.date,
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(job.status),
            ],
          ),
          const SizedBox(height: 12),
          // Price & Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatCurrency(job.price),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1976D2),
                ),
              ),
              if (job.rating != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...List.generate(5, (index) => Icon(
                      index < job.rating!.round() ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 16,
                    )),
                    const SizedBox(width: 4),
                    Text(
                      '${job.rating}',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 12),
          // Action Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                _showJobDetail(job);
              },
              icon: const Icon(Icons.visibility, size: 18),
              label: const Text('Lihat Detail'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(int price) {
    return 'Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  void _showJobDetail(JobHistory job) {
    showDialog(
      context: context,
      builder: (context) {
        if (job.status == JobStatus.proses) {
          return _buildProsesJobDialog(job);
        } else if (job.status == JobStatus.selesai) {
          return _buildSelesaiJobDialog(job);
        } else {
          return _buildDefaultJobDialog(job);
        }
      },
    );
  }

  Widget _buildProsesJobDialog(JobHistory job) {
    return AlertDialog(
      title: Text(job.title),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Tukang: ${job.tukangName}'),
            Text('Tanggal: ${job.date}'),
            Text('Status: ${_getStatusText(job.status)}'),
            Text('Harga: ${_formatCurrency(job.price)}'),
            const SizedBox(height: 20),
            const Text(
              'Pilih aksi untuk pekerjaan ini:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      actions: [
  Column(
    children: [
      SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(context);
            _changeJobStatus(
              job,
              JobStatus.selesai,
              'Pekerjaan selesai',
            );
          },
          icon: const Icon(Icons.check_circle),
          label: const Text('Selesai'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white
          ),
        ),
      ),
      const SizedBox(height: 10),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(context);
            _changeJobStatus(
              job,
              JobStatus.dibatalkan,
              'Pekerjaan dibatalkan',
            );
          },
          icon: const Icon(Icons.cancel),
          label: const Text('Batalkan'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white
          ),
        ),
      ),
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Tutup'),
      ),
    ],
  )
],
    );
  }

  Widget _buildSelesaiJobDialog(JobHistory job) {
  final reviewController = TextEditingController();
  double rating = 0;

  return StatefulBuilder(
    builder: (context, setDialogState) {
      return AlertDialog(
        title: Text(job.title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tukang: ${job.tukangName}'),
              Text('Tanggal: ${job.date}'),
              Text('Status: ${_getStatusText(job.status)}'),
              Text('Harga: ${_formatCurrency(job.price)}'),
              if (job.rating != null)
                Text('Rating sebelumnya: ${job.rating}'),
              const SizedBox(height: 20),

              const Text(
                'Beri ulasan:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              Row(
                children: List.generate(5, (index) {
                  return IconButton(
                    onPressed: () {
                      setDialogState(() {
                        rating = index + 1.0;
                      });
                    },
                    icon: Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 30,
                    ),
                  );
                }),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: reviewController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Tulis ulasan...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: rating == 0
                  ? null
                  : () {
                      Navigator.pop(context);
                      _showThankYouDialog();
                    },
              child: const Text('Kirim'),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      );
    },
  );
}

  Widget _buildDefaultJobDialog(JobHistory job) {
    return AlertDialog(
      title: Text(job.title),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Tukang: ${job.tukangName}'),
            Text('Tanggal: ${job.date}'),
            Text('Status: ${_getStatusText(job.status)}'),
Text('Harga: ${_formatCurrency(job.price)}'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Tutup'),
        ),
      ],
    );
  }

  String _getStatusText(JobStatus status) {
    switch (status) {
      case JobStatus.selesai:
        return 'Selesai';
      case JobStatus.proses:
        return 'Diproses';
      case JobStatus.dibatalkan:
        return 'Dibatalkan';
    }
  }

  void _changeJobStatus(JobHistory job, JobStatus newStatus, String message) {
    setState(() {
      final index = _jobHistories.indexWhere((j) => j.id == job.id);
      if (index != -1) {
        _jobHistories[index] = JobHistory(
          id: job.id,
          title: job.title,
          tukangName: job.tukangName,
          date: job.date,
          status: newStatus,
          price: job.price,
          imageUrl: job.imageUrl,
          rating: job.rating,
        );
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showThankYouDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terima kasih 🙌'),
        content: const Text('Ulasan kamu berhasil dikirim'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}