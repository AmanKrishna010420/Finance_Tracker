import 'package:finance_tracker/core/theme/theme.dart';
import 'package:finance_tracker/providers/transaction_provider.dart';
import 'package:finance_tracker/screens/Dashboard/dashboard.dart';
import 'package:finance_tracker/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:finance_tracker/providers/auth_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authProvider = AuthProvider();
  final transactionProvider = TransactionProvider();
  await authProvider.loadUserSession();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authProvider),
        ChangeNotifierProvider(create: (_) => transactionProvider),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: authProvider.isLoggedIn ? Dashboard() : LoginScreen(),
    );
  }
}
