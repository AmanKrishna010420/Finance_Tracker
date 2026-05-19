import 'package:flutter/material.dart';
import 'package:finance_tracker/models/transaction.dart';
import 'package:finance_tracker/services/dashboard_service.dart';

class TransactionProvider extends ChangeNotifier {
  Transaction? transaction;
  final DashboardService _dashboardService = DashboardService();
  int income = 0;
  int expense = 0;
  List<Transaction> transactions = [];
  Map<String, dynamic> categoryAnalytics = {};
  bool isLoading = false;

  String? errorMessage;

  Future<void> fetchTransactions() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      final response = await _dashboardService.fetchTransactions();
      transactions = (response.data)
          .map((transaction) => Transaction.fromJson(transaction))
          .toList();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> fetchIncome() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      final response = await _dashboardService.fetchIncome();
      income = response.data;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> fetchExpense() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      final response = await _dashboardService.fetchExpense();
      expense = response.data;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> fetchCategoryAnalytics() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      final response = await _dashboardService.fetchCategoryAnalytics();
      categoryAnalytics = response.data;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<bool> createTransaction({
    required int amount,
    required int transactionType,
    required int transactionCategory,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      await _dashboardService.createTransaction(
        amount: amount,
        transactionType: transactionType,
        transactionCategory: transactionCategory,
      );
      await fetchIncome();
      await fetchExpense();
      await fetchTransactions();
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
