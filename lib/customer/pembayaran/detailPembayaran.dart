import 'package:flutter/material.dart';
import '../../../constants.dart';

class InvoicingScreen extends StatelessWidget {
  const InvoicingScreen({super.key});

  void _showPaymentOptions(BuildContext context) {
    showModalBottomSheet(
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
              const Text(
                "Pilih Metode Pembayaran",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
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
      onTap: () {},
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
            child: Image.asset(imageUrl),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  maxLines: 2,
                ),
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

    const currentStatus = 0; // Ubah ke status aktif terakhir: 0, 1, 2, atau 3

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(statusList.length, (index) {
        final isActive = index <= currentStatus;
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
    final List<Map<String, dynamic>> products = [
      {
        "image": "assets/images/product/genshin.jpg",
        "title": "Genshin Impact - Primogem 160™",
        "price": 649000,
      },
      {
        "image": "assets/images/product/1735814979-icon-Image_20250102184102_ML.jpg",
        "title": "Mobile Legend - Diamond 1000",
        "price": 505000,
      },
    ];

    final double totalAmount = products.fold(0, (sum, item) => sum + item['price'] as double);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "Invoice",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Journey status
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: _buildStatusJourney(),
            ),
            const SizedBox(height: 20),
            const Text(
              "Produk yang Dipesan",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            /// Expanded untuk konten yang bisa scroll
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return _buildProductItem(
                    product["image"],
                    product["title"],
                    product["price"],
                  );
                },
              ),
            ),

            /// Tidak pakai Expanded di sini agar tidak konflik
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Bayar:",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
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
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
