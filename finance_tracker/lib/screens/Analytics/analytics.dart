import 'package:finance_tracker/core/theme/theme.dart';
import 'package:finance_tracker/providers/transaction_provider.dart';
import 'package:finance_tracker/screens/Dashboard/dashboard.dart';
import 'package:finance_tracker/screens/Transactions/transactions.dart';
import 'package:finance_tracker/screens/profile/profile.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  int currentIndex = 1;

  final List<Color> pieChartColors = [
    Colors.orange,
    Colors.blue,
    Colors.red,
    Colors.purple,
    Colors.green,
    Colors.teal,
  ];

  final Map<String, String> monthNames = {
    "1": "Jan",
    "2": "Feb",
    "3": "Mar",
    "4": "Apr",
    "5": "May",
    "6": "Jun",
    "7": "Jul",
    "8": "Aug",
    "9": "Sep",
    "10": "Oct",
    "11": "Nov",
    "12": "Dec",
  };

  final Map<String, String> categoryNames = {
    "1": "Food",
    "2": "Fuel",
    "3": "Medical",
    "4": "Travel",
    "5": "Entertainment",
    "6": "Misc",
  };

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final transactionProvider = Provider.of<TransactionProvider>(
        context,
        listen: false,
      );

      transactionProvider.fetchIncome();

      transactionProvider.fetchExpense();

      transactionProvider.fetchCategoryAnalytics();
    });
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);

    final income = transactionProvider.income;

    final expense = transactionProvider.expense;

    final categoryAnalytics = transactionProvider.categoryAnalytics;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,

      appBar: AppBar(title: const Text("Analytics")),

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
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    "Financial Insights 📊",

                    style: Theme.of(context).textTheme.headlineMedium,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Track your income and expenses",

                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  const SizedBox(height: 20),

                  /// MONTHLY OVERVIEW CARD
                  Card(
                    elevation: 2,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(14),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            "Monthly Overview",

                            style: Theme.of(context).textTheme.titleLarge,
                          ),

                          const SizedBox(height: 6),

                          Text(
                            "Income vs Expense",

                            style: Theme.of(context).textTheme.bodyMedium,
                          ),

                          const SizedBox(height: 20),

                          SizedBox(
                            height: 260,

                            child: BarChart(
                              BarChartData(
                                alignment: BarChartAlignment.spaceAround,

                                maxY:
                                    (income > expense ? income : expense)
                                        .toDouble() +
                                    5000,

                                gridData: FlGridData(
                                  show: true,

                                  drawVerticalLine: false,
                                ),

                                borderData: FlBorderData(show: false),

                                titlesData: FlTitlesData(
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),

                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),

                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,

                                      getTitlesWidget: (value, meta) {
                                        if (value == 0) {
                                          return const Text("Income");
                                        }

                                        return const Text("Expense");
                                      },
                                    ),
                                  ),
                                ),

                                barGroups: [
                                  BarChartGroupData(
                                    x: 0,

                                    barRods: [
                                      BarChartRodData(
                                        toY: income.toDouble(),

                                        width: 36,

                                        color: AppTheme.incomeColor,

                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ],
                                  ),

                                  BarChartGroupData(
                                    x: 1,

                                    barRods: [
                                      BarChartRodData(
                                        toY: expense.toDouble(),

                                        width: 36,

                                        color: AppTheme.expenseColor,

                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// PIE CHART CARD
                  Card(
                    elevation: 2,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(14),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            "Expense Categories",

                            style: Theme.of(context).textTheme.titleLarge,
                          ),

                          const SizedBox(height: 6),

                          Text(
                            "Category wise expense distribution",

                            style: Theme.of(context).textTheme.bodyMedium,
                          ),

                          const SizedBox(height: 18),

                          if (categoryAnalytics.isEmpty)
                            const SizedBox(
                              height: 240,

                              child: Center(
                                child: Text("No analytics available"),
                              ),
                            )
                          else
                            Column(
                              children: [
                                SizedBox(
                                  height: 220,

                                  child: PieChart(
                                    PieChartData(
                                      sectionsSpace: 3,

                                      centerSpaceRadius: 34,

                                      sections: List.generate(
                                        categoryAnalytics.keys.length,

                                        (index) {
                                          final key = categoryAnalytics.keys
                                              .elementAt(index);

                                          return PieChartSectionData(
                                            value: categoryAnalytics[key]
                                                .toDouble(),

                                            color:
                                                pieChartColors[index %
                                                    pieChartColors.length],

                                            radius: 62,

                                            title: "${categoryAnalytics[key]}",

                                            titleStyle: const TextStyle(
                                              color: Colors.white,

                                              fontWeight: FontWeight.bold,

                                              fontSize: 11,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 16),

                                Wrap(
                                  spacing: 14,

                                  runSpacing: 10,

                                  children: List.generate(
                                    categoryAnalytics.keys.length,

                                    (index) {
                                      final key = categoryAnalytics.keys
                                          .elementAt(index);

                                      return Row(
                                        mainAxisSize: MainAxisSize.min,

                                        children: [
                                          Container(
                                            width: 14,

                                            height: 14,

                                            decoration: BoxDecoration(
                                              color:
                                                  pieChartColors[index %
                                                      pieChartColors.length],

                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),

                                          const SizedBox(width: 6),

                                          Text(
                                            categoryNames[key] ?? "",

                                            style: const TextStyle(
                                              fontSize: 12,

                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
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
}
