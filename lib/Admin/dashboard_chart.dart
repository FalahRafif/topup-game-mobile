import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// Inside your widget class...
Widget _buildGraphCard() {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 4,
    child: Container(
      height: 180,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Revenue", style: TextStyle(color: Colors.grey[600])),
              Text("Last 7 days", style: TextStyle(color: Colors.blue)),
            ],
          ),
          SizedBox(height: 8),
          Text("\$16K", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    color: Colors.green,
                    barWidth: 3,
                    belowBarData: BarAreaData(show: false),
                    dotData: FlDotData(show: false),
                    spots: [
                      FlSpot(0, 2),
                      FlSpot(1, 3),
                      FlSpot(2, 2.5),
                      FlSpot(3, 4),
                      FlSpot(4, 3.5),
                      FlSpot(5, 5),
                      FlSpot(6, 4.5),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
