import 'package:flutter/material.dart';
import 'package:nukang_user_2/presentation/pages/home_paages.dart';

class PromotionPage extends StatefulWidget {
  const PromotionPage({super.key});

  @override
  State<PromotionPage> createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool isLoading = false;

  // ✅ Data Promo
  final List<PromoItem> promos = [
    PromoItem(
      title: 'Diskon 50% Tukang Las',
      subtitle: 'Untuk project pertama',
      discount: '50%',
      image: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=400',
      bgColor: const Color(0xFFFF6B6B),
      validUntil: '30 Des 2024',
    ),
    PromoItem(
      title: 'Gratis Ongkir Tukang Cat',
      subtitle: 'Minimal order Rp 500rb',
      discount: 'GRATIS',
      image: 'https://images.unsplash.com/photo-1600210492493-0946911123ea?w=400',
      bgColor: const Color(0xFF4ECDC4),
      validUntil: '25 Des 2024',
    ),
    PromoItem(
      title: 'Cashback 20%',
      subtitle: 'Tukang Listrik & Plumbing',
      discount: '20%',
      image: 'https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?w=400',
      bgColor: const Color(0xFF45B7D1),
      validUntil: '31 Des 2024',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _claimPromo(int index) {
    setState(() => isLoading = true);
    
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => isLoading = false);
        _showClaimSuccess(index);
      }
    });
  }

  void _showClaimSuccess(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: promos[index].bgColor.withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.card_giftcard, size: 64, color: promos[index].bgColor),
            ),
            const SizedBox(height: 20),
            const Text(
              'Klaim Berhasil!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Kode promo ${promos[index].title} sudah tersimpan di dompet Anda',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: promos[index].bgColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Lihat Dompet', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Promo Spesial'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1976D2),
        elevation: 1,
        actions: [
          TextButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            ),
            child: const Text('Lewati', style: TextStyle(color: Color(0xFF1976D2))),
          ),
        ],
      ),
      body: Column(
        children: [
          // ✅ Promo Slider
          SizedBox(
            height: 280,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemCount: promos.length,
              itemBuilder: (context, index) => _buildPromoCard(index),
            ),
          ),
          
          // ✅ Indicator Dots
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                promos.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentPage == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index 
                        ? promos[index].bgColor 
                        : promos[index].bgColor.withAlpha(100),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),

          // ✅ Tombol Klaim
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: isLoading ? null : () => _claimPromo(_currentPage),
                style: ElevatedButton.styleFrom(
                  backgroundColor: promos[_currentPage].bgColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : Text(
                        'KLAIM ${promos[_currentPage].discount}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
              ),
            ),
          ),

          // ✅ List Promo Lainnya
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Promo Lainnya',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: promos.length,
              itemBuilder: (context, index) => _buildPromoListItem(index),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Promo Card Utama (PageView)
  Widget _buildPromoCard(int index) {
  final promo = promos[index];

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: promo.bgColor.withAlpha(50),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 300, // ⬅️ gedein dikit
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              promo.bgColor,
              promo.bgColor.withAlpha(200),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            // TEXT
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(200),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      promo.discount,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    promo.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    promo.subtitle,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Sampai ${promo.validUntil}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // IMAGE
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  promo.image,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

  // ✅ Promo List Item
  Widget _buildPromoListItem(int index) {
    final promo = promos[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: promo.bgColor.withAlpha(50),
          child: Text(
            promo.discount,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: promo.bgColor,
            ),
          ),
        ),
        title: Text(
          promo.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(promo.subtitle),
            const SizedBox(height: 4),
            Text(
              'Berlaku hingga ${promo.validUntil}',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () => _claimPromo(index),
          style: ElevatedButton.styleFrom(
            backgroundColor: promo.bgColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          child: const Text('Klaim', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

// ✅ Promo Data Model
class PromoItem {
  final String title;
  final String subtitle;
  final String discount;
  final String image;
  final Color bgColor;
  final String validUntil;

  const PromoItem({
    required this.title,
    required this.subtitle,
    required this.discount,
    required this.image,
    required this.bgColor,
    required this.validUntil,
  });
}