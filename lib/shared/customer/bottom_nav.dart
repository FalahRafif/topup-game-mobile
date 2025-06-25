import 'package:flutter/material.dart';
import '../../customer/home/home.dart';
import '../../customer/product/listProduct.dart';
import '../../customer/pembayaran/historyPembayaran.dart';
import '../../../constants.dart';

class CustomerNavbar extends StatelessWidget {
  final int selectedIndex;

  const CustomerNavbar({Key? key, required this.selectedIndex}) : super(key: key);

  void _onItemTapped(BuildContext context, int index) {
    if (index == selectedIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ListProductScreen()));
        break;
      case 2:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => TransactionListScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: NavbarClipper(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -1),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(context, Icons.home_rounded, "Home", 0),
            _buildNavItem(context, Icons.shopping_bag_rounded, "Produk", 1),
            _buildNavItem(context, Icons.receipt_long_rounded, "Transaksi", 2),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, int index) {
    final isActive = index == selectedIndex;

    return GestureDetector(
      onTap: () => _onItemTapped(context, index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isActive ? kPrimaryColor.withOpacity(0.1) : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive ? kPrimaryColor : Colors.grey,
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? kPrimaryColor : Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class NavbarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double curveHeight = 16;

    Path path = Path()
      ..lineTo(0, 0)
      ..lineTo(0, size.height - curveHeight)
      ..quadraticBezierTo(
        size.width / 2, size.height + curveHeight,
        size.width, size.height - curveHeight,
      )
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(NavbarClipper oldClipper) => false;
}
