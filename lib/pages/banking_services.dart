import 'package:flutter/material.dart';

class BankingServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Banking Services'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: <Widget>[
          _buildTile(context, Icons.account_balance_wallet, 'Deposit'),
          _buildTile(context, Icons.money_off, 'Withdraw'),
          _buildTile(context, Icons.account_balance, 'Check Balance'),
          _buildTile(context, Icons.attach_money, 'Loans'),
          _buildTile(context, Icons.trending_up, 'Investment'),
        ],
      ),
    );
  }

  Widget _buildTile(BuildContext context, IconData icon, String title) {
    return GestureDetector(
      onTap: () {
        // Handle tile tap
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 50.0, color: Colors.white),
            SizedBox(height: 10.0),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}