import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardService {
  late final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://finance-tracker-app-latest-ccim.onrender.com",
      connectTimeout: const Duration(seconds: 80),
      receiveTimeout: const Duration(seconds: 80),
    ),
  );

  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("email");
  }

  Future<Response> fetchLoginUser() async {
    final email = await getEmail();
    return await dio.get("/user/fetchByEmail?email=$email");
  }

  Future<Response> fetchTransactions() async {
    final email = await getEmail();
    return await dio.get("/transaction/all?email=$email");
  }

  Future<Response> fetchIncome() async {
    final email = await getEmail();
    return await dio.get("/transaction/monthlyIncome?email=$email");
  }

  Future<Response> fetchExpense() async {
    final email = await getEmail();
    return await dio.get("/transaction/monthlyExpense?email=$email");
  }

  Future<Response> fetchCategoryAnalytics() async {
    final email = await getEmail();
    return await dio.get("/transaction/categoryAnalytics?email=$email");
  }

  Future<Response> createTransaction({
    required int amount,

    required int transactionType,

    required int transactionCategory,
  }) async {
    final email = await getEmail();

    final now = DateTime.now();

    final formattedDate = DateFormat('yyyy-MM-dd').format(now);

    final formattedTime = DateFormat('HH:mm:ss').format(now);

    return await dio.post(
      "/transaction/computeResponse?email=$email",

      data: {
        "amount": amount,

        "transactionDate": formattedDate,

        "transactionTime": formattedTime,

        "transactionType": transactionType,

        "transactionCategory": transactionCategory,
      },
    );
  }
}
