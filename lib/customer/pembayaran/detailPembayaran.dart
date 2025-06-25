import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'dart:async';

class InvoicingScreen extends StatefulWidget {
  const InvoicingScreen({super.key});

  @override
  State<InvoicingScreen> createState() => _InvoicingScreenState();
}

class _InvoicingScreenState extends State<InvoicingScreen> {
  int _currentStatus = 0;

  final List<Map<String, dynamic>> products = [
    {
      "image": "assets/images/product/genshin.jpg",
      "title": "Genshin Impact - Primogem 160™",
      "price": 649000.0,
    },
    {
      "image": "assets/images/product/1735814979-icon-Image_20250102184102_ML.jpg",
      "title": "Mobile Legend - Diamond 1000",
      "price": 505000.0,
    },
  ];

  final Map<String, List<Map<String, String>>> _channelOptions = {
    "E-Wallet": [
      {"label": "OVO", "icon": "assets/icons/ovo.png"},
      {"label": "GoPay", "icon": "assets/icons/gopay.png"},
      {"label": "DANA", "icon": "assets/icons/dana.png"},
    ],
    "Transfer Bank": [
      {"label": "BCA", "icon": "assets/icons/bca.png"},
      {"label": "BNI", "icon": "assets/icons/bni.png"},
      {"label": "BRI", "icon": "assets/icons/bri.png"},
      {"label": "Mandiri", "icon": "assets/icons/mandiri.png"},
    ],
  };

  void _showPaymentOptions(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Pilih Metode Pembayaran",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              _paymentOption("E-Wallet", Icons.account_balance_wallet),
              _paymentOption("Transfer Bank", Icons.account_balance),
              _paymentOption("PayPal", Icons.paypal),
            ],
          ),
        );
      },
    );
  }

  Widget _paymentOption(String title, IconData icon) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: kPrimaryColor),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        if (title == "PayPal") {
          _showVirtualAccount(context, title, "PayPal");
        } else {
          _showChannelOptions(context, title);
        }
      },
    );
  }

  void _showChannelOptions(BuildContext context, String method) {
    final channels = _channelOptions[method] ?? [];

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Pilih Channel $method",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              ...channels.map((channel) => ListTile(
                leading: _buildChannelIcon(channel["icon"]),
                title: Text(channel["label"] ?? ''),
                onTap: () {
                  Navigator.pop(context);
                  _showVirtualAccount(context, method, channel["label"] ?? '');
                },
              )),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChannelIcon(String? assetPath) {
    if (assetPath != null) {
      return Image.asset(assetPath, width: 28, height: 28, errorBuilder: (_, __, ___) {
        return const Icon(Icons.account_balance_wallet, color: kPrimaryColor);
      });
    }
    return const Icon(Icons.account_balance_wallet, color: kPrimaryColor);
  }

  void _showVirtualAccount(BuildContext context, String method, String channel) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets.add(const EdgeInsets.all(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.credit_card, color: kPrimaryColor, size: 48),
              const SizedBox(height: 12),
              Text(
                "Virtual Account untuk $channel",
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 8),
              const Text(
                "Silakan salin nomor di bawah dan lakukan pembayaran sesuai metode yang dipilih.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("8881 2345 6789", style: TextStyle(fontWeight: FontWeight.bold)),
                    Icon(Icons.copy, color: kPrimaryColor),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showLoadingStatus();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "Konfirmasi Pembayaran",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLoadingStatus() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator(color: kPrimaryColor)),
    );

    Future.forEach([1, 2, 3], (int index) async {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _currentStatus = index;
      });
    }).then((_) {
      Navigator.of(context).pop(); // close loading
      _showSuccessDialog(context);
    });
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: kPrimaryColor, size: 64),
                const SizedBox(height: 16),
                const Text("Pembayaran Berhasil",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text(
                  "Terima kasih! Pembayaran kamu telah dikonfirmasi.",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      "Selesai",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductItem(String imageUrl, String title, double price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6F9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(imageUrl, fit: BoxFit.contain),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(
                  "Rp ${price.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusJourney() {
    const statusList = [
      {"label": "Menunggu", "icon": Icons.access_time},
      {"label": "Dibayar", "icon": Icons.payment},
      {"label": "Diproses", "icon": Icons.autorenew},
      {"label": "Berhasil", "icon": Icons.check_circle},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(statusList.length, (index) {
        final isActive = index <= _currentStatus;
        return Expanded(
          child: Column(
            children: [
              Icon(
                statusList[index]["icon"] as IconData,
                color: isActive ? kPrimaryColor : Colors.grey.shade400,
                size: 28,
              ),
              const SizedBox(height: 6),
              Text(
                statusList[index]["label"] as String,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive ? Colors.black : Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalAmount = products.fold(0.0, (sum, p) => sum + (p["price"] as double));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Invoice",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: _buildStatusJourney(),
            ),
            const SizedBox(height: 20),
            const Text("Produk yang Dipesan",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (ctx, i) {
                  final p = products[i];
                  return _buildProductItem(
                      p["image"] as String, p["title"] as String, p["price"] as double);
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Bayar:",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                Text(
                  "Rp ${totalAmount.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showPaymentOptions(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Bayar Sekarang",
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
