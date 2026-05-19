import 'package:finance_tracker/core/theme/theme.dart';
import 'package:finance_tracker/providers/transaction_provider.dart';
import 'package:finance_tracker/screens/Analytics/analytics.dart';
import 'package:finance_tracker/screens/Dashboard/dashboard.dart';
import 'package:finance_tracker/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  int currentIndex = 2;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final transactionProvider = Provider.of<TransactionProvider>(
        context,
        listen: false,
      );

      transactionProvider.fetchTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);

    final txnList = transactionProvider.transactions;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,

      appBar: AppBar(title: const Text('Transactions')),

      /// BOTTOM NAVIGATION BAR
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        type: BottomNavigationBarType.fixed,

        selectedItemColor: AppTheme.primaryColor,

        unselectedItemColor: Colors.grey,

        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,

              MaterialPageRoute(builder: (context) => const Dashboard()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,

              MaterialPageRoute(builder: (context) => const Analytics()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,

              MaterialPageRoute(builder: (context) => const Transactions()),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,

              MaterialPageRoute(builder: (context) => const Profile()),
            );
          }
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),

            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_rounded),

            label: "Analytics",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_rounded),

            label: "Transactions",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),

            label: "Profile",
          ),
        ],
      ),

      body: transactionProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : txnList.isEmpty
          ? const Center(child: Text("No transactions found"))
          : Padding(
              padding: const EdgeInsets.all(16),

              child: SingleChildScrollView(
                child: Column(
                  children: txnList.map((txn) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),

                      child: _buildTransactionTile(
                        context,

                        getCategoryIcon(txn.transactionCategory),

                        txn.categoryText,

                        "${txn.transactionDate} • ${txn.transactionTime}",

                        "₹ ${txn.amount}",

                        txn.transactionType == 1
                            ? AppTheme.incomeColor
                            : AppTheme.expenseColor,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
    );
  }

  /// CATEGORY ICONS
  IconData getCategoryIcon(int? category) {
    switch (category) {
      case 1:
        return Icons.fastfood_rounded;

      case 2:
        return Icons.local_gas_station_rounded;

      case 3:
        return Icons.medical_services_rounded;

      case 4:
        return Icons.flight_takeoff_rounded;

      case 5:
        return Icons.movie_rounded;

      case 6:
        return Icons.category_rounded;

      default:
        return Icons.payments_rounded;
    }
  }

  /// TRANSACTION TILE
  Widget _buildTransactionTile(
    BuildContext context,

    IconData icon,

    String title,

    String subtitle,

    String amount,

    Color amountColor,
  ) {
    return Card(
      elevation: 1.5,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),

        child: Row(
          children: [
            /// ICON
            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: amountColor.withOpacity(0.12),

                borderRadius: BorderRadius.circular(16),
              ),

              child: Icon(icon, color: amountColor, size: 28),
            ),

            const SizedBox(width: 14),

            /// TITLE + SUBTITLE
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),

                  const SizedBox(height: 6),

                  Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),

            /// AMOUNT
            Text(
              amount,

              style: TextStyle(
                color: amountColor,

                fontWeight: FontWeight.bold,

                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
