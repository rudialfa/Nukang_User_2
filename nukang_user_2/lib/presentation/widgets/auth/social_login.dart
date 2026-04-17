import 'package:flutter/material.dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/auth/auth_textfield.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  void _showComingSoonDialog(BuildContext context, String platform) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(
              platform == 'Facebook' ? Icons.facebook : Icons.phone,
              color: platform == 'Facebook' 
                  ? const Color(0xFF1976D2) 
                  : Colors.green,
            ),
            const SizedBox(width: 12),
            Text('${platform} Login'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.construction,
              size: 64,
              color: Colors.orange[300],
            ),
            const SizedBox(height: 16),
            const Text(
              'Fitur ini sedang dalam tahap pengembangan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Kami akan segera meluncurkannya!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Facebook Button
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 12),
          child: ElevatedButton.icon(
            onPressed: () => _showComingSoonDialog(context, 'Facebook'),
            icon: const Icon(Icons.facebook, size: 24, color: Colors.white),
            label: const Text(
              'Masuk dengan Facebook',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1976D2),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
          ),
        ),
        
        // Telepon Button
        Container(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => _showComingSoonDialog(context, 'Telepon'),
            icon: const Icon(Icons.phone, size: 24, color: Colors.green),
            label: const Text(
              'Masuk dengan Telepon',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Colors.green),
              ),
              elevation: 2,
            ),
          ),
        ),
      ],
    );
  }
}