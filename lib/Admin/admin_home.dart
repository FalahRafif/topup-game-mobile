import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:topup_mobile/Auth/Login/login_screen.dart';
import 'package:topup_mobile/Auth/Welcome/welcome_screen.dart';
import '../../main.dart';
import '../Auth/components/modal_validation.dart';

void main() => runApp(AdminHome());

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard UI',
      home: DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Positioned(
          left: 0,
          child: Image.asset("assets/images/kliktopup-logo.png", width: 150),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert), // the 3 dots
            offset: Offset(0, 50), // ⬅️ controls the Y position (move downward)
            constraints: BoxConstraints(minWidth: 150), // set custom width
            onSelected: (value) {
              if (value == 'logout') {
                // Do logout logic here
                print('User logged out');
                // Example: Navigate to login screen
                showLoading(
                  context,
                  "Keluar aplikasi?",
                  "Anda akan keluar dari aplikasi KlikTopup",
                  "assets/images/question-mark.png",
                  "300",
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 18),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildCard(
                "Selamat Datang, Admin!",
                "Periksa data penjualan di sini",
                Icons.waving_hand,
                Colors.blue,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildCard(
                      "Order Diproses",
                      "190",
                      Icons.shopping_cart,
                      Colors.amber,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildCard(
                      "Order Selesai",
                      "237",
                      Icons.fact_check,
                      Colors.lightGreen,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildCard(
                      "Customer",
                      "1975",
                      Icons.person,
                      Colors.lightBlue,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildCard(
                      "Jumlah Game",
                      "107",
                      Icons.inventory,
                      Colors.purple,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              _buildPieChartCard(),
              SizedBox(height: 16),
              _buildGraphCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(
    String title,
    String value,
    IconData icon,
    Color iconColor,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: iconColor.withOpacity(0.1),
              child: Icon(icon, color: iconColor),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildGraphCard() {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 4,
    child: Container(
      height: 240,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Penjualan",
                style: TextStyle(color: Colors.grey[600]),
              ),
              Text("2025", style: TextStyle(color: Colors.blue)),
            ],
          ),
          SizedBox(height: 8),
          Container(
            child: Text(
              "",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            margin: const EdgeInsets.only(bottom: 15.0),
          ),

          SizedBox(height: 8),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true, drawVerticalLine: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final months = [
                          "Jan",
                          "Feb",
                          "Mar",
                          "Apr",
                          "Mei",
                          "Jun",
                          "Jul",
                          "Agu",
                          "Sep",
                          "Okt",
                          "Nov",
                          "Des",
                        ];
                        return Text(
                          months[value.toInt()],
                          style: TextStyle(fontSize: 9),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 5,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()}',
                          style: TextStyle(fontSize: 8),
                        );
                      },
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 11,
                minY: 0,
                maxY: 35,
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    color: Colors.lightBlue,
                    barWidth: 3,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.lightBlue.withOpacity(0.1),
                    ),
                    spots: [
                      FlSpot(0, 12),
                      FlSpot(1, 14),
                      FlSpot(2, 10),
                      FlSpot(3, 16),
                      FlSpot(4, 18),
                      FlSpot(5, 20),
                      FlSpot(6, 22),
                      FlSpot(7, 19),
                      FlSpot(8, 23),
                      FlSpot(9, 25),
                      FlSpot(10, 28),
                      FlSpot(11, 30),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildPieChartCard() {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 4,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            "Penjualan Game Populer",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: PieChart(
              PieChartData(
                sectionsSpace: 1,
                centerSpaceRadius: 40,
                sections: _getSections(),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

List<PieChartSectionData> _getSections() {
  return [
    PieChartSectionData(
      value: 35,
      title: 'Mobile Legends\n35%',
      color: Colors.blue,
      radius: 60,
      titleStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    PieChartSectionData(
      value: 25,
      title: 'Free Fire\n25%',
      color: Colors.pink,
      radius: 55,
      titleStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    PieChartSectionData(
      value: 15,
      title: 'Valorant\n15%',
      color: Colors.orange,
      radius: 50,
      titleStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    PieChartSectionData(
      value: 10,
      title: 'Roblox\n10%',
      color: Colors.purple,
      radius: 45,
      titleStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    PieChartSectionData(
      value: 15,
      title: 'PUBG\n15%',
      color: Colors.green,
      radius: 50,
      titleStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  ];
}
