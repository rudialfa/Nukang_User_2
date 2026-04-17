import 'package:flutter/material.dart';
import 'package:nukang_user_2/presentation/pages/kategori_worker_pages.dart';
// import '../../pages/kategori_worker_pages.dart';

class ServiceCategories extends StatelessWidget {
  const ServiceCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Kategori Layanan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Di lib/presentation/widgets/home/service_categories.dart
// Ganti bagian "Lihat Semua" button:
TextButton(
  onPressed: () {
    // ⭐ GUNAKAN NAMED ROUTE
    Navigator.pushNamed(context, '/categories');
  },
  child: const Text('Lihat Semua'),
),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildCategoryItem(
                context,
                icon: Icons.bolt,
                title: 'Listrik',
                color: Colors.amber,
                categoryId: 1,
              ),
              _buildCategoryItem(
                context,
                icon: Icons.home,
                title: 'Perbaikan',
                color: Colors.red,
                categoryId: 10,
              ),
              _buildCategoryItem(
                context,
                icon: Icons.water_drop,
                title: 'Saluran Air',
                color: Colors.teal,
                categoryId: 19,
              ),
              _buildCategoryItem(
                context,
                icon: Icons.ac_unit,
                title: 'AC & Kulkas',
                color: Colors.lightBlue,
                categoryId: 25,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required int categoryId,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryWorkersPage(
              categoryId: categoryId,
              categoryName: title,
            ),
          ),
        );
      },
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withOpacity(0.8), color.withOpacity(0.3)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 28, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}