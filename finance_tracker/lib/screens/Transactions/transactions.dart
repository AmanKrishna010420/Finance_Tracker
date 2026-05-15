import 'package:finance_tracker/models/transaction.dart';
import 'package:finance_tracker/screens/Analytics/analytics.dart';
import 'package:finance_tracker/screens/Dashboard/dashboard.dart';
import 'package:finance_tracker/screens/profile/profile.dart';
import 'package:finance_tracker/core/theme/theme.dart';
import 'package:finance_tracker/services/dashboard_service.dart';
import 'package:flutter/material.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  late Future<List<Transaction>> transactions;
  int currentIndex = 2;
  @override
  @override
  void initState() {
    super.initState();

    transactions = DashboardService().fetchTransactions().then((response) {
      final List<dynamic> data = response.data;

      return data.map((txn) => Transaction.fromJson(txn)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: FutureBuilder<List<Transaction>>(
            future: transactions,

            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Text("Error loading transactions");
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text("No transactions found");
              }

              final txnList = snapshot.data!;

              txnList.sort(
                (a, b) => b.transactionDate!.compareTo(a.transactionDate!),
              );

              final recentTransactions = txnList.toList();

              return Column(
                children: recentTransactions.map((txn) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),

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
              );
            },
          ),
        ),
      ),
    );
  }

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

  Widget _buildTransactionTile(
    BuildContext context,

    IconData icon,

    String title,

    String subtitle,

    String amount,

    Color amountColor,
  ) {
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: amountColor.withOpacity(0.12),

              borderRadius: BorderRadius.circular(14),
            ),

            child: Icon(icon, color: amountColor),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),

                const SizedBox(height: 4),

                Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              amount,

              style: TextStyle(
                color: amountColor,

                fontWeight: FontWeight.w700,

                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
