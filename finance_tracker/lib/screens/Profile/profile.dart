import 'package:dio/dio.dart';
import 'package:finance_tracker/core/theme/theme.dart';
import 'package:finance_tracker/models/user.dart';
import 'package:finance_tracker/screens/Analytics/analytics.dart';
import 'package:finance_tracker/screens/Dashboard/dashboard.dart';
import 'package:finance_tracker/screens/Transactions/transactions.dart';
import 'package:finance_tracker/services/dashboard_service.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int currentIndex = 3;

  late Future<Response> userFuture;

  @override
  void initState() {
    super.initState();

    userFuture = DashboardService().fetchLoginUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,

      appBar: AppBar(title: const Text('Profile')),

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

      body: FutureBuilder(
        future: userFuture,

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final user = User.fromJson(snapshot.data!.data);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              children: [
                /// PROFILE CARD
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(24),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(24),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),

                        blurRadius: 14,

                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),

                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 52,

                        backgroundColor: AppTheme.primaryColor,

                        child: Text(
                          "${user.firstName?[0] ?? ""}${user.lastName?[0] ?? ""}",

                          style: const TextStyle(
                            color: Colors.white,

                            fontSize: 28,

                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      Text(
                        "${user.firstName ?? ""} ${user.lastName ?? ""}",

                        style: Theme.of(context).textTheme.headlineSmall,
                      ),

                      const SizedBox(height: 6),

                      Text(
                        user.email ?? "",

                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// BALANCE CARD
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.primaryColor,

                        AppTheme.primaryColor.withOpacity(0.8),
                      ],
                    ),

                    borderRadius: BorderRadius.circular(22),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Text(
                        "Current Balance",

                        style: TextStyle(color: Colors.white70, fontSize: 15),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "₹ ${user.balance ?? 0}",

                        style: const TextStyle(
                          color: Colors.white,

                          fontSize: 32,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// ACCOUNT DETAILS
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(22),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        "Account Details",

                        style: Theme.of(context).textTheme.titleLarge,
                      ),

                      const SizedBox(height: 18),

                      _buildDetailTile(
                        icon: Icons.person,

                        title: "First Name",

                        value: user.firstName ?? "",
                      ),

                      _buildDetailTile(
                        icon: Icons.person_outline,

                        title: "Last Name",

                        value: user.lastName ?? "",
                      ),

                      _buildDetailTile(
                        icon: Icons.email_outlined,

                        title: "Email",

                        value: user.email ?? "",
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// BANKS
                Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(22),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        "Linked Banks",

                        style: Theme.of(context).textTheme.titleLarge,
                      ),

                      const SizedBox(height: 18),

                      Wrap(
                        spacing: 12,

                        runSpacing: 12,

                        children: user.banks!.map((bank) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,

                              vertical: 12,
                            ),

                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor.withOpacity(0.08),

                              borderRadius: BorderRadius.circular(30),

                              border: Border.all(
                                color: AppTheme.primaryColor.withOpacity(0.2),
                              ),
                            ),

                            child: Row(
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                Icon(
                                  Icons.account_balance,

                                  size: 18,

                                  color: AppTheme.primaryColor,
                                ),

                                const SizedBox(width: 8),

                                Text(
                                  bank,

                                  style: TextStyle(
                                    color: AppTheme.primaryColor,

                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailTile({
    required IconData icon,

    required String title,

    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),

      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.08),

              borderRadius: BorderRadius.circular(12),
            ),

            child: Icon(icon, color: AppTheme.primaryColor),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),

                const SizedBox(height: 4),

                Text(
                  value,

                  style: const TextStyle(
                    fontSize: 16,

                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
