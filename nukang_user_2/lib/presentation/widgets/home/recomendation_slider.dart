import 'package:flutter/material.dart';
import 'package:nukang_user_2/presentation/pages/kategori_worker_pages.dart';
import '../../pages/kategori_worker_pages.dart';

class RecommendationSlider extends StatelessWidget {
  RecommendationSlider({super.key});

  // Data terkoneksi dengan 36 kategori
  final List<Map<String, dynamic>> services = [
    {
      'image': 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=300',
      'title': 'Listrik',
      'rating': 4.9,
      'price': 'Rp 50rb - 300rb',
      'categoryId': 1,
    },
    {
      'image': 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=300',
      'title': 'Perbaikan rumah',
      'rating': 4.8,
      'price': 'Rp 75rb - 500rb',
      'categoryId': 10,
    },
    {
      'image': 'https://images.unsplash.com/photo-1558618047-3c8c76fdd9e4?w=300',
      'title': 'Saluran Air',
      'rating': 5.0,
      'price': 'Rp 100rb - 400rb',
      'categoryId': 19,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoryWorkersPage(
                    categoryId: service['categoryId'],
                    categoryName: service['title'],
                  ),
                ),
              );
            },
            child: Container(
              width: 280,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(25),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image dengan gradient overlay
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                          child: Image.network(
                            service['image'] as String,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 120,
                                color: Colors.grey[300],
                                child: const Icon(Icons.construction, size: 50, color: Colors.grey),
                              );
                            },
                          ),
                        ),
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withAlpha(80),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            service['title'] as String,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                          const SizedBox(height: 12),
                          
                          // Rating & Price Row
                          Row(
  children: [
    Expanded( // INI KUNCINYA
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 20),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              '${service['rating']} (${15 + index * 10} ulasan)',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    ),
    const SizedBox(width: 6),
    Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF1976D2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          service['price'] as String,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ],
),
                          
                          const SizedBox(height: 12),
                          
                          // Call to Action Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CategoryWorkersPage(
                                      categoryId: service['categoryId'],
                                      categoryName: service['title'],
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.arrow_forward_ios, size: 14),
                              label: const Text('Lihat Tukang'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1976D2),
                                foregroundColor: Colors.white,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}