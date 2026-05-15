import 'package:dio/dio.dart';
import 'package:finance_tracker/core/theme/theme.dart';
import 'package:finance_tracker/screens/Dashboard/dashboard.dart';
import 'package:finance_tracker/screens/Transactions/transactions.dart';
import 'package:finance_tracker/screens/profile/profile.dart';
import 'package:finance_tracker/services/dashboard_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Analytics extends StatefulWidget {
  const Analytics({super.key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  int currentIndex = 1;

  late Future<Response> monthlyIncomeFuture;

  late Future<Response> monthlyExpenseFuture;

  late Future<Response> categoryAnalyticsFuture;

  @override
  void initState() {
    super.initState();

    final service = DashboardService();

    monthlyIncomeFuture = service.fetchIncome();

    monthlyExpenseFuture = service.fetchExpense();

    categoryAnalyticsFuture = service.fetchCategoryAnalytics();
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,

      appBar: AppBar(title: const Text('Analytics')),

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

      body: SingleChildScrollView(
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

            /// ======================
            /// MONTHLY BAR CHART
            /// ======================
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

                    FutureBuilder(
                      future: Future.wait([
                        monthlyIncomeFuture,

                        monthlyExpenseFuture,
                      ]),

                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox(
                            height: 260,

                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        if (snapshot.hasError) {
                          return SizedBox(
                            height: 260,

                            child: Center(
                              child: Text(snapshot.error.toString()),
                            ),
                          );
                        }

                        final incomeData =
                            snapshot.data![0].data as Map<String, dynamic>;

                        final expenseData =
                            snapshot.data![1].data as Map<String, dynamic>;

                        final months = incomeData.keys.toList();

                        return SizedBox(
                          height: 260,

                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,

                            child: SizedBox(
                              width: months.length * 120,

                              child: BarChart(
                                BarChartData(
                                  alignment: BarChartAlignment.spaceAround,

                                  maxY: 60000,

                                  /// TOOLTIP
                                  barTouchData: BarTouchData(
                                    touchTooltipData: BarTouchTooltipData(
                                      tooltipBorderRadius:
                                          BorderRadius.circular(6),

                                      tooltipPadding: const EdgeInsets.all(10),

                                      getTooltipItem:
                                          (group, groupIndex, rod, rodIndex) {
                                            return BarTooltipItem(
                                              "₹ ${rod.toY.toStringAsFixed(0)}",

                                              const TextStyle(
                                                color: Colors.white,

                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          },
                                    ),
                                  ),

                                  gridData: FlGridData(
                                    show: true,

                                    drawVerticalLine: false,

                                    horizontalInterval: 10000,
                                  ),

                                  borderData: FlBorderData(show: false),

                                  titlesData: FlTitlesData(
                                    topTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),

                                    rightTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),

                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        reservedSize: 42,

                                        showTitles: true,
                                      ),
                                    ),

                                    /// MONTHS
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,

                                        reservedSize: 34,

                                        getTitlesWidget: (value, meta) {
                                          final index = value.toInt();

                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              top: 12,
                                            ),

                                            child: Text(
                                              monthNames[months[index]] ?? "",

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

                                  /// BARS
                                  barGroups: List.generate(months.length, (
                                    index,
                                  ) {
                                    final month = months[index];

                                    final income = incomeData[month].toDouble();

                                    final expense = expenseData[month]
                                        .toDouble();

                                    return BarChartGroupData(
                                      x: index,

                                      barsSpace: 8,

                                      barRods: [
                                        /// INCOME
                                        BarChartRodData(
                                          toY: income,

                                          width: 18,

                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),

                                          color: AppTheme.incomeColor,
                                        ),

                                        /// EXPENSE
                                        BarChartRodData(
                                          toY: expense,

                                          width: 18,

                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),

                                          color: AppTheme.expenseColor,
                                        ),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// ======================
            /// PIE CHART
            /// ======================
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

                    FutureBuilder(
                      future: categoryAnalyticsFuture,

                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox(
                            height: 240,

                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        if (snapshot.hasError) {
                          return SizedBox(
                            height: 240,

                            child: Center(
                              child: Text(snapshot.error.toString()),
                            ),
                          );
                        }

                        final data =
                            snapshot.data!.data as Map<String, dynamic>;

                        final keys = data.keys.toList();

                        return Column(
                          children: [
                            SizedBox(
                              height: 220,

                              child: PieChart(
                                PieChartData(
                                  sectionsSpace: 3,

                                  centerSpaceRadius: 34,

                                  sections: List.generate(keys.length, (index) {
                                    final key = keys[index];

                                    return PieChartSectionData(
                                      value: data[key].toDouble(),

                                      color: pieChartColors[index],

                                      radius: 62,

                                      title: "${data[key]}",

                                      titleStyle: const TextStyle(
                                        color: Colors.white,

                                        fontWeight: FontWeight.bold,

                                        fontSize: 11,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            Wrap(
                              spacing: 14,

                              runSpacing: 10,

                              children: List.generate(keys.length, (index) {
                                final key = keys[index];

                                return Row(
                                  mainAxisSize: MainAxisSize.min,

                                  children: [
                                    Container(
                                      width: 14,

                                      height: 14,

                                      decoration: BoxDecoration(
                                        color: pieChartColors[index],

                                        borderRadius: BorderRadius.circular(4),
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
                              }),
                            ),
                          ],
                        );
                      },
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
