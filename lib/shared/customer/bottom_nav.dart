import 'package:flutter/material.dart';
import '../../customer/home/home.dart';
import '../../customer/product/listProduct.dart';
import '../../customer/pembayaran/historyPembayaran.dart';

class CustomerNavbar extends StatelessWidget {
  final int selectedIndex;

  const CustomerNavbar({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  void _onItemTapped(BuildContext context, int index) {
    if (index == selectedIndex) return; // Hindari reload halaman yang sama

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ListProductScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TransactionListScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) => _onItemTapped(context, index),
      selectedItemColor: const Color(0xFFFF7643),
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Pencarian',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long),
          label: 'Transaksi',
        ),
      ],
    );
  }
}
