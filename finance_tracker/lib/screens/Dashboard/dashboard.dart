import 'package:finance_tracker/core/theme/theme.dart';
import 'package:finance_tracker/providers/auth_provider.dart';
import 'package:finance_tracker/providers/transaction_provider.dart';
import 'package:finance_tracker/screens/Analytics/analytics.dart';
import 'package:finance_tracker/screens/Transactions/transactions.dart';
import 'package:finance_tracker/screens/auth/login_screen.dart';
import 'package:finance_tracker/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    debugPrint("Dashboard init");

    Future.microtask(() async {
      final transactionProvider = Provider.of<TransactionProvider>(
        context,
        listen: false,
      );

      await transactionProvider.fetchTransactions();

      await transactionProvider.fetchIncome();

      await transactionProvider.fetchExpense();

      await transactionProvider.fetchCategoryAnalytics();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    final transactionProvider = Provider.of<TransactionProvider>(context);

    final userData = authProvider.currentUser;

    final txnList = transactionProvider.transactions;

    if (transactionProvider.isLoading && txnList.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,

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

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),

            child: Column(
              children: [
                /// PROFILE STACK
                Stack(
                  clipBehavior: Clip.none,

                  children: [
                    /// PROFILE CARD
                    Card(
                      margin: const EdgeInsets.only(top: 20),

                      child: Padding(
                        padding: const EdgeInsets.all(24),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            const SizedBox(height: 12),

                            /// TOP SECTION
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 38,

                                  backgroundColor: AppTheme.primaryColor,

                                  child: const Icon(
                                    Icons.person,

                                    color: Colors.white,

                                    size: 36,
                                  ),
                                ),

                                const SizedBox(width: 18),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    children: [
                                      Text(
                                        "Hello, ${userData?.firstName ?? ''} 👋",

                                        style: Theme.of(
                                          context,
                                        ).textTheme.headlineMedium,
                                      ),

                                      const SizedBox(height: 6),

                                      Text(
                                        userData?.email ?? "",

                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 30),

                            const Divider(),

                            const SizedBox(height: 24),

                            /// BALANCE
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      "Total Income",

                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),

                                    const SizedBox(height: 8),

                                    Text(
                                      "₹ ${transactionProvider.income}",

                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineMedium,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      "Total Expense",

                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),

                                    const SizedBox(height: 8),

                                    Text(
                                      "₹ ${transactionProvider.expense}",

                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineMedium,
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),

                            /// ACTION BUTTONS
                            Row(
                              children: [
                                /// ADD INCOME
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      debugPrint("Add Income Button Pressed");
                                      showAddIncomeSheet();
                                    },

                                    icon: const Icon(Icons.add_circle_outline),

                                    label: const Text("Add Income"),

                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppTheme.incomeColor,

                                      foregroundColor: Colors.white,

                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 12),

                                /// ADD EXPENSE
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      debugPrint("Add Expense Button Pressed");
                                      showAddExpenseSheet();
                                    },

                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                    ),

                                    label: const Text("Add Expense"),

                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppTheme.expenseColor,

                                      foregroundColor: Colors.white,

                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// LOGOUT BUTTON
                    Positioned(
                      top: 0,

                      right: 12,

                      child: IconButton(
                        onPressed: () async {
                          await authProvider.logout();
                          context.read<TransactionProvider>().clearData();

                          if (!mounted) return;

                          Navigator.pushReplacement(
                            context,

                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },

                        icon: const Icon(Icons.logout),

                        style: IconButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,

                          foregroundColor: Colors.white,

                          padding: const EdgeInsets.all(14),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                /// TRANSACTION CARD
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        /// HEADER
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Text(
                              "Recent Transactions",

                              style: Theme.of(context).textTheme.titleLarge,
                            ),

                            TextButton(
                              onPressed: () {},

                              child: const Text("View All"),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        if (txnList.isEmpty)
                          const Text("No transactions found")
                        else
                          Column(
                            children: txnList.take(5).map((txn) {
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
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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

  /// ADD INCOME SHEET
  void showAddIncomeSheet() {
    final amountController = TextEditingController();

    showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              TextField(
                controller: amountController,

                keyboardType: TextInputType.number,

                decoration: const InputDecoration(labelText: "Amount"),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () async {
                    final amount = int.tryParse(amountController.text);

                    if (amount == null || amount <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Enter valid amount")),
                      );
                      return;
                    }
                    final transactionProvider =
                        Provider.of<TransactionProvider>(
                          context,
                          listen: false,
                        );

                    debugPrint("Calling income provider with amount: $amount");
                    await transactionProvider.createTransaction(
                      amount: amount,

                      transactionType: 1,

                      transactionCategory: 6,
                    );
                    debugPrint("Income added with amount: $amount");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Income Added")),
                    );

                    if (!mounted) return;

                    Navigator.pop(context);
                  },

                  child: const Text("Add Income"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// ADD EXPENSE SHEET
  void showAddExpenseSheet() {
    final amountController = TextEditingController();

    int selectedCategory = 1;

    showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  TextField(
                    controller: amountController,

                    keyboardType: TextInputType.number,

                    decoration: const InputDecoration(labelText: "Amount"),
                  ),

                  const SizedBox(height: 20),

                  DropdownButtonFormField<int>(
                    initialValue: selectedCategory,

                    items: const [
                      DropdownMenuItem(value: 1, child: Text("Food")),

                      DropdownMenuItem(value: 2, child: Text("Fuel")),

                      DropdownMenuItem(value: 3, child: Text("Medical")),

                      DropdownMenuItem(value: 4, child: Text("Travel")),

                      DropdownMenuItem(value: 5, child: Text("Entertainment")),

                      DropdownMenuItem(value: 6, child: Text("Miscellaneous")),
                    ],

                    onChanged: (value) {
                      setModalState(() {
                        selectedCategory = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton(
                      onPressed: () async {
                        final amount = int.tryParse(amountController.text);

                        if (amount == null || amount <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Enter valid amount")),
                          );
                          return;
                        }

                        final transactionProvider =
                            Provider.of<TransactionProvider>(
                              context,
                              listen: false,
                            );
                        debugPrint(
                          "Calling expense provider with amount: $amount, category: $selectedCategory",
                        );
                        await transactionProvider.createTransaction(
                          amount: amount,

                          transactionType: 0,

                          transactionCategory: selectedCategory,
                        );
                        debugPrint(
                          "Expense added with amount: $amount, category: $selectedCategory",
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Expense Added")),
                        );

                        if (!mounted) return;

                        Navigator.pop(context);
                      },

                      child: const Text("Add Expense"),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTransactionTile(
    BuildContext context,

    IconData icon,

    String title,

    String subtitle,

    String amount,

    Color amountColor,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),

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

        Text(
          amount,

          style: TextStyle(
            color: amountColor,

            fontWeight: FontWeight.w700,

            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
