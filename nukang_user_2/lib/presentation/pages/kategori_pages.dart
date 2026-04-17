import 'package:flutter/material.dart';
import 'kategori_worker_pages.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  // 36 Kategori Lengkap - FIXED COLORS & ICONS
  static final List<CategoryItem> categories = [
    // Listrik & Elektronik (1-9)
    CategoryItem(id: 1, name: 'Listrik', icon: Icons.bolt, color: Colors.amber, workers: 245),
    CategoryItem(id: 2, name: 'Instalasi Listrik', icon: Icons.construction, color: Colors.orange, workers: 156),
    CategoryItem(id: 3, name: 'Perbaikan Kabel', icon: Icons.cable, color: Colors.deepOrange, workers: 89),
    CategoryItem(id: 4, name: 'Panel Listrik', icon: Icons.grid_view, color: Colors.red, workers: 67),
    CategoryItem(id: 5, name: 'Generator', icon: Icons.battery_charging_full, color: const Color(0xFFE91E63), workers: 45),
    CategoryItem(id: 6, name: 'Lampu & Penerangan', icon: Icons.lightbulb, color: Colors.pink, workers: 123),
    CategoryItem(id: 7, name: 'UPS & Stabilizer', icon: Icons.battery_full, color: Colors.purple, workers: 34),
    CategoryItem(id: 8, name: 'CCTV & Security', icon: Icons.videocam, color: Colors.indigo, workers: 78),
    CategoryItem(id: 9, name: 'Solar Panel', icon: Icons.wb_sunny, color: Colors.lime, workers: 56),

    // Rumah & Bangunan (10-18)
    CategoryItem(id: 10, name: 'Perbaikan Rumah', icon: Icons.home_repair_service, color: Colors.red, workers: 189),
    CategoryItem(id: 11, name: 'Tukang Cat', icon: Icons.palette, color: Colors.green, workers: 201),
    CategoryItem(id: 12, name: 'Plester & Aci', icon: Icons.texture, color: Colors.yellow, workers: 167),
    CategoryItem(id: 13, name: 'Keramik & Lantai', icon: Icons.grid_4x4, color: Colors.pink, workers: 134),
    CategoryItem(id: 14, name: 'Atap & Genteng', icon: Icons.layers, color: Colors.brown, workers: 98),
    CategoryItem(id: 15, name: 'Pintu & Jendela', icon: Icons.door_front_door, color: Colors.blueGrey, workers: 76),
    CategoryItem(id: 16, name: 'Batu Bata', icon: Icons.square_foot, color: Colors.red, workers: 89),
    CategoryItem(id: 17, name: 'Besi & Baja Ringan', icon: Icons.iron, color: Colors.grey, workers: 65),
    CategoryItem(id: 18, name: 'Rangka Atap', icon: Icons.trending_up, color: Colors.deepPurple, workers: 54),

    // Plumbing & Sanitasi (19-24)
    CategoryItem(id: 19, name: 'Saluran Air', icon: Icons.water_drop, color: Colors.teal, workers: 156),
    CategoryItem(id: 20, name: 'Pompa Air', icon: Icons.opacity, color: Colors.cyan, workers: 89),
    CategoryItem(id: 21, name: 'Toilet & Kloset', icon: Icons.wc, color: Colors.blueGrey, workers: 123),
    CategoryItem(id: 22, name: 'Shower & Keran', icon: Icons.shower, color: Colors.lightBlue, workers: 98),
    CategoryItem(id: 23, name: 'Bocor & Kebersihan', icon: Icons.water_drop_outlined, color: Colors.indigo, workers: 145),
    CategoryItem(id: 24, name: 'Septic Tank', icon: Icons.delete, color: Colors.purple, workers: 67),

    // Pendingin & Peralatan (25-30)
    CategoryItem(id: 25, name: 'AC & Kulkas', icon: Icons.ac_unit, color: Colors.lightBlue, workers: 134),
    CategoryItem(id: 26, name: 'Mesin Cuci', icon: Icons.local_laundry_service, color: Colors.amber, workers: 89),
    CategoryItem(id: 27, name: 'TV & Elektronik', icon: Icons.tv, color: Colors.orange, workers: 112),
    CategoryItem(id: 28, name: 'Komputer & Laptop', icon: Icons.laptop, color: Colors.blue, workers: 78),
    CategoryItem(id: 29, name: 'Printer & Scanner', icon: Icons.print, color: Colors.green, workers: 45),
    CategoryItem(id: 30, name: 'Audio System', icon: Icons.music_note, color: Colors.purple, workers: 56),

    // Otomotif & Lainnya (31-36)
    CategoryItem(id: 31, name: 'Bengkel Mobil', icon: Icons.directions_car, color: Colors.orange, workers: 178),
    CategoryItem(id: 32, name: 'Bengkel Motor', icon: Icons.two_wheeler, color: Colors.pink, workers: 201),
    CategoryItem(id: 33, name: 'Cat Mobil', icon: Icons.brush, color: Colors.red, workers: 89),
    CategoryItem(id: 34, name: 'Ban & Velg', icon: Icons.perm_data_setting, color: Colors.black87, workers: 123),
    CategoryItem(id: 35, name: 'Tukang Kunci', icon: Icons.vpn_key, color: Colors.yellow, workers: 156),
    CategoryItem(id: 36, name: 'Las & Pengelasan', icon: Icons.local_fire_department, color: Colors.red, workers: 98),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.95,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final category = categories[index];
                  return _buildCategoryCard(context, category);
                },
                childCount: categories.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: const Color(0xFF1976D2),
      flexibleSpace: FlexibleSpaceBar(
        
        background: Container(
          padding: const EdgeInsets.all(20),
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
              const Text(
                '36+ Layanan',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 8),
              const Text(
                'Tukang Profesional',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, CategoryItem category) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryWorkersPage(
              categoryId: category.id,
              categoryName: category.name,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    category.color.withValues(alpha: 0.8),
                    category.color.withValues(alpha: 0.2),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(category.icon, size: 32, color: Colors.white),
            ),
            Text(
              category.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A1A),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              '${category.workers}+ Tukang',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryItem {
  final int id;
  final String name;
  final IconData icon;
  final Color color;
  final int workers;

  const CategoryItem({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.workers,
  });
}