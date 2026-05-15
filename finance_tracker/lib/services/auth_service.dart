import 'package:dio/dio.dart';

class AuthService {
  late final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://finance-tracker-app-latest-ccim.onrender.com",
      connectTimeout: const Duration(seconds: 80),
      receiveTimeout: const Duration(seconds: 80),
    ),
  );

  Future<Response> login({
    required String email,
    required String password,
  }) async {
    return await dio.post(
      "/user/login",
      data: {"email": email, "password": password},
    );
  }

  Future<Response> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String username,
    required String banks,
    required int balance,
  }) async {
    List<String> bankList = banks
        .split(",")
        .map((bank) => bank.trim())
        .toList();
    return await dio.post(
      "/user/register",
      data: {
        "firstName": firstName,
        "lastName": lastName,
        "userEmail": email,
        "userPassword": password,
        "username": username,
        "banks": bankList,
        "balance": balance,
      },
    );
  }
}
