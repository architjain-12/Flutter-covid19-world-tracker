import 'package:flutter/material.dart';

class StatsGrid extends StatelessWidget {
  final int totalCases;
  final int totalDeaths;
  final int totalRecovered;
  final int totalInfected;
  StatsGrid({this.totalCases , this.totalDeaths , this.totalInfected , this.totalRecovered});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard('Total Cases', '${totalCases.toString()}', Colors.orange),
                _buildStatCard('Deaths', '${totalDeaths.toString()}', Colors.red),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard('Recovered', '${totalRecovered.toString()}', Colors.green),
                _buildStatCard('Active', '${totalInfected.toString()}', Colors.lightBlue),
                // _buildStatCard('Critical', 'N/A', Colors.purple),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildStatCard(String title, String count, MaterialColor color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}