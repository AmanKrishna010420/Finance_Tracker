import 'package:flutter/material.dart';
import 'package:finance_tracker/models/transaction.dart';
import 'package:finance_tracker/services/dashboard_service.dart';

class TransactionProvider extends ChangeNotifier {
  final DashboardService _dashboardService = DashboardService();

  int income = 0;
  int expense = 0;

  List<Transaction> transactions = [];

  Map<String, dynamic> categoryAnalytics = {};
  Map<int, dynamic> monthlyIncome = {};
  Map<int, dynamic> monthlyExpense = {};

  bool isLoading = false;
  String? errorMessage;

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    errorMessage = message;
    notifyListeners();
  }

  Future<void> fetchTransactions() async {
    try {
      _setLoading(true);
      errorMessage = null;

      final response = await _dashboardService.fetchTransactions();

      transactions = (response.data as List)
          .map((e) => Transaction.fromJson(e))
          .toList();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchIncome() async {
    try {
      _setLoading(true);
      errorMessage = null;

      final response = await _dashboardService.fetchIncome();

      final data = Map<String, dynamic>.from(response.data);

      income = data.values.fold(
        0,
        (sum, value) => sum + (value as num).toInt(),
      );
      debugPrint("Fetched Income: $income");
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchExpense() async {
    try {
      _setLoading(true);
      errorMessage = null;

      final response = await _dashboardService.fetchExpense();

      final data = Map<String, dynamic>.from(response.data);

      expense = data.values.fold(
        0,
        (sum, value) => sum + (value as num).toInt(),
      );
      debugPrint("Fetched Expense: $expense");
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchMonthlyIncome() async {
    try {
      final response = await _dashboardService.fetchIncome();

      monthlyIncome = (response.data as Map<String, dynamic>).map(
        (key, value) => MapEntry(int.parse(key), value),
      );

      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    }
  }

  Future<void> fetchMonthlyExpense() async {
    try {
      final response = await _dashboardService.fetchExpense();

      monthlyExpense = (response.data as Map<String, dynamic>).map(
        (key, value) => MapEntry(int.parse(key), value),
      );

      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    }
  }

  Future<void> fetchCategoryAnalytics() async {
    try {
      final response = await _dashboardService.fetchCategoryAnalytics();

      categoryAnalytics = Map<String, dynamic>.from(response.data);

      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    }
  }

  Future<void> refreshDashboardData() async {
    await Future.wait([fetchIncome(), fetchExpense(), fetchTransactions()]);
  }

  Future<void> refreshAnalyticsData() async {
    await Future.wait([
      fetchMonthlyIncome(),
      fetchMonthlyExpense(),
      fetchCategoryAnalytics(),
    ]);
  }

  void clearData() {
    income = 0;
    expense = 0;

    transactions.clear();

    categoryAnalytics.clear();
    monthlyIncome.clear();
    monthlyExpense.clear();

    errorMessage = null;
    isLoading = false;

    notifyListeners();
  }

  Future<bool> createTransaction({
    required int amount,
    required int transactionType,
    required int transactionCategory,
  }) async {
    try {
      _setLoading(true);
      errorMessage = null;
      debugPrint(
        "Calling transaction service with amount: $amount, type: $transactionType, category: $transactionCategory",
      );
      await _dashboardService.createTransaction(
        amount: amount,
        transactionType: transactionType,
        transactionCategory: transactionCategory,
      );
      debugPrint("Transaction created successfully");
      await refreshDashboardData();
      debugPrint("Dashboard data refreshed after transaction creation");
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }
}
