import 'package:flutter/material.dart';
import 'detailPembayaran.dart';
import '../../shared/customer/bottom_nav.dart';
import '../../shared/customer/apppbar.dart';
import '../../constants.dart';

class Transaction {
  final String id;
  final String date;
  final double total;
  final String status; // 'success', 'pending', 'failed'
  final String productImage;
  final List<String> items; // nama item yang dibeli

  Transaction({
    required this.id,
    required this.date,
    required this.total,
    required this.status,
    required this.productImage,
    required this.items,
  });
}

class TransactionListScreen extends StatelessWidget {
  TransactionListScreen({super.key});

  final List<Transaction> transactions = [
    Transaction(
      id: "INV001",
      date: "2025-06-24",
      total: 1250000,
      status: "success",
      productImage: "assets/images/product/1735814979-icon-Image_20250102184102_ML.jpg",
      items: [
        "Mobile Legends Diamonds",
        "PUBG UC",
        "Valorant Points",
        "Steam Wallet ID"
      ],
    ),
    Transaction(
      id: "INV002",
      date: "2025-06-23",
      total: 505000,
      status: "pending",
      productImage: "assets/images/product/1658817763-icon-200x200_icon ff.jpg",
      items: ["Free Fire Diamond", "Higgs Domino Chip"],
    ),
    Transaction(
      id: "INV003",
      date: "2025-06-20",
      total: 840000,
      status: "failed",
      productImage: "assets/images/product/genshin.jpg",
      items: ["Genshin Primogems"],
    ),
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case 'success':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case 'success':
        return "Berhasil";
      case 'pending':
        return "Menunggu";
      case 'failed':
        return "Gagal";
      default:
        return "Unknown";
    }
  }

  void _goToInvoice(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const InvoicingScreen(),
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context, Transaction tx) {
    final visibleItems = tx.items.take(2).toList();
    final remaining = tx.items.length - visibleItems.length;

    return GestureDetector(
      onTap: () => _goToInvoice(context),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6F9),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                tx.productImage,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        tx.id,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: getStatusColor(tx.status).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          getStatusText(tx.status),
                          style: TextStyle(
                            color: getStatusColor(tx.status),
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tx.date,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  ...visibleItems.map((item) =>
                      Text(
                        "• $item",
                        style: const TextStyle(fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                  if (remaining > 0)
                    Text(
                      "+$remaining item lainnya",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                ],
              ),
            ),
            Text(
              "Rp ${tx.total.toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const HomeHeader(),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Riwayat Transaksi",
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ListView.builder(
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          return _buildTransactionItem(
                              context, transactions[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomerNavbar(selectedIndex: 2),
    );
  }
}