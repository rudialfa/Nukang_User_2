import 'package:flutter/material.dart';
import 'package:nukang_user_2/presentation/pages/home_paages.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:typed_data';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentPage extends StatefulWidget {
  final String amount;
  final String workerName;

  const PaymentPage({super.key, required this.amount, required this.workerName});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedMethod;
  bool isProcessing = false;

  // Data VA berdasarkan bank - ✅ SAFE DATA
  final Map<String, Map<String, String>> bankData = {
    'bca': {'name': 'BCA', 'va': '9881234567890'},
    'mandiri': {'name': 'Mandiri', 'va': '8881234567890'},
    'bni': {'name': 'BNI', 'va': '7771234567890'},
  };

  // ✅ SAFE: Navigate ke Virtual Account Page
  void _navigateToVirtualAccount(String bankCode) {
    final bankInfo = bankData[bankCode];
    if (bankInfo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data bank tidak ditemukan')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VirtualAccountPage(
          amount: widget.amount,
          workerName: widget.workerName,
          bankName: bankInfo['name']!,
          vaNumber: bankInfo['va']!,
        ),
      ),
    );
  }

  Future<void> _downloadQR() async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Downloading QR Code...')),
      );
      await Future.delayed(const Duration(seconds: 1));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('QR Code berhasil diunduh ke galeri!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal download: $e')),
      );
    }
  }

  Future<void> _shareQR() async {
    await Share.share(
      'Bayar project ${widget.workerName} Rp ${widget.amount}\n\nScan QR Code di atas via e-wallet',
      subject: 'Pembayaran Nukang - ${widget.workerName}',
    );
  }

  // ✅ SAFE: Process Payment dengan null check
  void _processPayment() {
    if (selectedMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih metode pembayaran terlebih dahulu')),
      );
      return;
    }

    setState(() => isProcessing = true);
    
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => isProcessing = false);
        
        if (selectedMethod!.startsWith('va_')) {
          final bankCode = selectedMethod!.split('_')[1];
          _navigateToVirtualAccount(bankCode);
        } else {
          _showPaymentSuccess();
        }
      }
    });
  }

  void _showPaymentSuccess() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50).withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle, size: 64, color: Color(0xFF4CAF50)),
            ),
            const SizedBox(height: 20),
            const Text(
              'Pembayaran Berhasil!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Pembayaran Rp ${widget.amount} untuk ${widget.workerName} berhasil diproses',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    ).then((_) {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false,
        );
      }
    });
  }

@override
Widget build(BuildContext context) {
  final int amountInt = int.parse(widget.amount);
  final String formattedAmount = amountInt.toString().replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (Match m) => '${m[1]},',
  );

  return Scaffold(
    backgroundColor: const Color(0xFFF8FAFC),
    appBar: AppBar(
      title: const Text('Pembayaran Project'),
      backgroundColor: const Color(0xFF1976D2),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF1976D2), Color(0xFF42A5F5)]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Icon(Icons.payment, size: 48, color: Colors.white),
                const SizedBox(height: 16),
                Text(
                  'Rp $formattedAmount',
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  'Project ${widget.workerName}',
                  style: const TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Metode Pembayaran
          Text('Pilih Metode Pembayaran', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          // ✅ QRIS - DIPINDAH KE ATAS
          _buildPaymentMethod('QRIS', Icons.qr_code_2, 'Scan QR Code via e-wallet', 'qris'),
          
          // ✅ QR CODE - HANYA TAMPIL SAAT QRIS DIPILIH
          if (selectedMethod == 'qris') ...[
            const SizedBox(height: 20),
            _buildQRCode(formattedAmount),
            const SizedBox(height: 24),
          ],

          // Virtual Account - 3 Pilihan Bank
          Text('Virtual Account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildPaymentMethod('BCA', Icons.account_balance, 'Virtual Account BCA', 'va_bca'),
          const SizedBox(height: 12),
          _buildPaymentMethod('Mandiri', Icons.account_balance, 'Virtual Account Mandiri', 'va_mandiri'),
          const SizedBox(height: 12),
          _buildPaymentMethod('BNI', Icons.account_balance, 'Virtual Account BNI', 'va_bni'),

          const SizedBox(height: 32),

          // Tombol Bayar
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: (!isProcessing && selectedMethod != null) ? _processPayment : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 2,
              ),
              child: isProcessing
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : Text(
                      selectedMethod?.startsWith('va_') == true 
                          ? 'Bayar via ${selectedMethod!.split('_')[1].toUpperCase()}' 
                          : 'Bayar via QRIS',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildPaymentMethod(String title, IconData icon, String subtitle, String value) {
    final bool isSelected = selectedMethod == value;
    return GestureDetector(
      onTap: () => setState(() => selectedMethod = value),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF1976D2) : Colors.grey[200]!,
            width: 2,
          ),
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(5), blurRadius: 10)],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1976D2).withAlpha(25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFF1976D2), size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                ],
              ),
            ),
            if (isSelected) const Icon(Icons.check_circle, color: Color(0xFF1976D2)),
          ],
        ),
      ),
    );
  }

  Widget _buildQRCode(String formattedAmount) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 10)],
      ),
      child: Column(
        children: [
          QrImageView(
            data: 'PAYMENT|${widget.amount}|${widget.workerName}|${DateTime.now().millisecondsSinceEpoch}',
            version: QrVersions.auto,
            size: 200.0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          const SizedBox(height: 20),
          Text('Rp $formattedAmount', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Scan via e-wallet', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _downloadQR,
                icon: const Icon(Icons.download, size: 18),
                label: const Text('Download'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _shareQR,
                icon: const Icon(Icons.share, size: 18),
                label: const Text('Share'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1976D2),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ✅ VirtualAccountPage - TIDAK BERUBAH
class VirtualAccountPage extends StatelessWidget {
  final String amount;
  final String workerName;
  final String vaNumber;
  final String bankName;

  const VirtualAccountPage({
    super.key,
    required this.amount,
    required this.workerName,
    required this.vaNumber,
    required this.bankName,
  });

  void _copyToClipboard(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('No. VA $bankName $vaNumber berhasil disalin!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showPaymentConfirmation(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) => GestureDetector(
        onTap: () {
          Navigator.of(dialogContext).pop();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false,
          );
        },
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle, size: 64, color: Color(0xFF4CAF50)),
              ),
              const SizedBox(height: 20),
              const Text(
                'Pembayaran Berhasil!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                'Pembayaran Rp $amount untuk $workerName berhasil diproses',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 20),
              Text(
                'Klik di mana saja untuk kembali ke beranda',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int amountInt = int.parse(amount);
    final String formattedAmount = amountInt.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text('Bayar via $bankName'),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF1976D2), Color(0xFF42A5F5)]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Icon(Icons.account_balance, size: 48, color: Colors.white),
                  const SizedBox(height: 16),
                  Text(
                    'Rp $formattedAmount',
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    'Project $workerName',
                    style: const TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 10)],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_balance, color: const Color(0xFF1976D2)),
                      const SizedBox(width: 12),
                      Text(
                        '$bankName Virtual Account',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: SelectableText(
                            vaNumber,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () => _copyToClipboard(context),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1976D2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.copy, color: Colors.white, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Transfer persis ke nomor Virtual Account di atas',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => _showPaymentConfirmation(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                ),
                child: const Text(
                  'Saya Telah Melakukan Pembayaran',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
