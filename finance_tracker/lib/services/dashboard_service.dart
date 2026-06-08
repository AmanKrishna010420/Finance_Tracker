import 'package:dio/dio.dart';
import 'package:finance_tracker/services/token_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardService {
  late final Dio dio;

  DashboardService() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://fin-app-kmfr.onrender.com",
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {"Content-Type": "application/json"},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await TokenService().getToken();

          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          handler.next(options);
        },

        onError: (error, handler) {
          if (error.response?.statusCode == 401) {
            // Future logout handling
          }

          handler.next(error);
        },
      ),
    );
  }

  Future<Response> fetchLoginUser() async {
    return await dio.get("/user/me");
  }

  Future<Response> fetchTransactions() async {
    return await dio.get("/transaction/all");
  }

  Future<Response> fetchIncome() async {
    return await dio.get("/transaction/monthlyIncome");
  }

  Future<Response> fetchExpense() async {
    return await dio.get("/transaction/monthlyExpense");
  }

  Future<Response> fetchCategoryAnalytics() async {
    return await dio.get("/transaction/categoryAnalytics");
  }

  Future<Response> createTransaction({
    required int amount,
    required int transactionType,
    required int transactionCategory,
  }) async {
    final now = DateTime.now();
    debugPrint(
      "API Called with amount: $amount, type: $transactionType, category: $transactionCategory",
    );
    final response = await dio.post(
      "/transaction/computeResponse",
      data: {
        "amount": amount,
        "transactionDate": DateFormat('yyyy-MM-dd').format(now),
        "transactionTime": DateFormat('HH:mm:ss').format(now),
        "transactionType": transactionType,
        "transactionCategory": transactionCategory,
      },
    );
    debugPrint("Status Code ${response.statusCode}");
    debugPrint("Data : ${response.data}");
    return response;
  }
}
