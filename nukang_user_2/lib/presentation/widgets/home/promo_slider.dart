import 'package:flutter/material.dart';
import 'package:nukang_user_2/presentation/pages/promotion_pages.dart';

class PromoSlider extends StatefulWidget {
  const PromoSlider({super.key});

  @override
  State<PromoSlider> createState() => _PromoSliderState();
}

class _PromoSliderState extends State<PromoSlider> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;

  final List<PromoItem> promos = [
    PromoItem(
      title: 'Diskon 50% Tukang Las',
      subtitle: 'Untuk project pertama',
      discount: '50%',
      image: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=300',
      bgColor: const Color(0xFFFF6B6B),
      validUntil: '30 Sep 2025',
    ),
    PromoItem(
      title: 'Gratis Ongkir Tukang Cat',
      subtitle: 'Minimal order Rp 500rb',
      discount: 'GRATIS',
      image: 'https://images.unsplash.com/photo-1600210492493-0946911123ea?w=300',
      bgColor: const Color(0xFF4ECDC4),
      validUntil: '10 Okt 2025',
    ),
    PromoItem(
      title: 'Cashback 20%',
      subtitle: 'Tukang Listrik & Plumbing',
      discount: '20%',
      image: 'https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?w=300',
      bgColor: const Color(0xFF45B7D1),
      validUntil: '5 Nov 2025',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 120,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: promos.length,
            itemBuilder: (context, index) => _buildPromoCard(index),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            promos.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 6,
              width: _currentPage == index ? 20 : 6,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? promos[index].bgColor
                    : promos[index].bgColor.withAlpha(100),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPromoCard(int index) {
    final promo = promos[index];

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PromotionPage()),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [promo.bgColor, promo.bgColor.withAlpha(200)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: promo.bgColor.withAlpha(50),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(200),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  promo.discount,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      promo.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      promo.subtitle,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Berlaku sampai ${promo.validUntil}',
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// taro di luar, jangan bego masukin ke dalem class 😹
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