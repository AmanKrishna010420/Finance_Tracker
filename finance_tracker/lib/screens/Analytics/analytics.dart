import 'package:finance_tracker/core/theme/theme.dart';
import 'package:finance_tracker/providers/transaction_provider.dart';
// import 'package:finance_tracker/screens/Analytics/analytics.dart';
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

    Future.microtask(() async {
      final transactionProvider = Provider.of<TransactionProvider>(
        context,
        listen: false,
      );

      await transactionProvider.fetchMonthlyIncome();

      await transactionProvider.fetchMonthlyExpense();

      await transactionProvider.fetchCategoryAnalytics();
    });
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);

    final monthlyIncome = transactionProvider.monthlyIncome;

    final monthlyExpense = transactionProvider.monthlyExpense;

    final categoryAnalytics = transactionProvider.categoryAnalytics;

    final List<int> months = monthlyIncome.keys.toList()..sort();

    final maxValue = [...monthlyIncome.values, ...monthlyExpense.values].isEmpty
        ? 1000.0
        : ([...monthlyIncome.values, ...monthlyExpense.values]
                  .map((e) => (e as num).toDouble())
                  .reduce((a, b) => a > b ? a : b)) +
              5000;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,

      appBar: AppBar(title: const Text("Analytics")),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        type: BottomNavigationBarType.fixed,

        selectedItemColor: AppTheme.primaryColor,

        unselectedItemColor: Colors.grey,

        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const Dashboard()),
            );
          }

          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const Analytics()),
            );
          }

          if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const Transactions()),
            );
          }

          if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const Profile()),
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
                    "Track your monthly income and expenses",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  const SizedBox(height: 20),

                  /// BAR CHART CARD
                  Card(
                    elevation: 2,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(16),

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

                          const SizedBox(height: 24),

                          SizedBox(
                            height: 300,

                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,

                              child: SizedBox(
                                width: MediaQuery.of(context).size.width - 70,

                                child: BarChart(
                                  BarChartData(
                                    alignment: BarChartAlignment.spaceAround,

                                    maxY: maxValue,

                                    gridData: FlGridData(
                                      show: true,

                                      drawVerticalLine: false,
                                    ),

                                    borderData: FlBorderData(show: false),

                                    titlesData: FlTitlesData(
                                      topTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: false,
                                        ),
                                      ),

                                      rightTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: false,
                                        ),
                                      ),

                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,

                                          reservedSize: 45,

                                          getTitlesWidget: (value, meta) {
                                            const monthNames = {
                                              1: "Jan",
                                              2: "Feb",
                                              3: "Mar",
                                              4: "Apr",
                                              5: "May",
                                              6: "Jun",
                                              7: "Jul",
                                              8: "Aug",
                                              9: "Sep",
                                              10: "Oct",
                                              11: "Nov",
                                              12: "Dec",
                                            };

                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8,
                                              ),

                                              child: Text(
                                                monthNames[value.toInt()] ?? "",

                                                style: const TextStyle(
                                                  fontSize: 12,

                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),

                                    barGroups: months.map((month) {
                                      final incomeValue =
                                          ((monthlyIncome[month] ?? 0) as num)
                                              .toDouble();

                                      final expenseValue =
                                          ((monthlyExpense[month] ?? 0) as num)
                                              .toDouble();

                                      return BarChartGroupData(
                                        x: month,

                                        barsSpace: 6,

                                        barRods: [
                                          BarChartRodData(
                                            toY: incomeValue,

                                            width: 20,

                                            color: AppTheme.incomeColor,

                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),

                                          BarChartRodData(
                                            toY: expenseValue,

                                            width: 20,

                                            color: AppTheme.expenseColor,

                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ),
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
                      padding: const EdgeInsets.all(16),

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

                          const SizedBox(height: 20),

                          categoryAnalytics.isEmpty
                              ? const SizedBox(
                                  height: 220,

                                  child: Center(
                                    child: Text("No analytics available"),
                                  ),
                                )
                              : Column(
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
                                                value:
                                                    (categoryAnalytics[key]
                                                            as num)
                                                        .toDouble(),

                                                color:
                                                    pieChartColors[index %
                                                        pieChartColors.length],

                                                radius: 62,

                                                title:
                                                    "${categoryAnalytics[key]}",

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

                                    const SizedBox(height: 18),

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
                                                          pieChartColors
                                                              .length],

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
