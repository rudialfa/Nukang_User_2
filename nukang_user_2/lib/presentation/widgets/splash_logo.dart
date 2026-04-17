import 'package:flutter/material.dart';

class SplashLogo extends StatelessWidget {
  final double size;
  const SplashLogo({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.construction, size: size * 0.6, color: const Color(0xFF1976D2)),
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(color: Color(0xFF42A5F5), shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }
}