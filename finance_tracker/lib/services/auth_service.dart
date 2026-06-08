import 'package:dio/dio.dart';
import 'package:finance_tracker/models/login_response.dart';
import 'package:finance_tracker/models/user.dart';
import 'package:finance_tracker/services/token_service.dart';
import 'package:flutter/material.dart';

class AuthService {
  late final Dio dio;

  AuthService() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://fin-app-kmfr.onrender.com",
        connectTimeout: const Duration(seconds: 80),
        receiveTimeout: const Duration(seconds: 80),
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
      ),
    );
  }
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        "/user/login",
        data: {"email": email, "password": password},
      );

      debugPrint("STATUS CODE: ${response.statusCode}");
      debugPrint("RESPONSE DATA: ${response.data}");

      final loginResponse = LoginResponse.fromJson(response.data);

      await TokenService().saveToken(loginResponse.token);

      return loginResponse;
    } on DioException catch (e) {
      debugPrint("DIO ERROR TYPE: ${e.type}");
      debugPrint("DIO ERROR MESSAGE: ${e.message}");
      debugPrint("STATUS CODE: ${e.response?.statusCode}");
      debugPrint("RESPONSE BODY: ${e.response?.data}");

      rethrow;
    }
  }
  // Future<LoginResponse> login({
  //   required String email,
  //   required String password,
  // }) async {
  //   final response = await dio.post(
  //     "/user/login",
  //     data: {"email": email, "password": password},
  //   );

  //   debugPrint("Status Code: ${response.statusCode}");
  //   debugPrint("Response Data: ${response.data}");
  //   final loginResponse = LoginResponse.fromJson(response.data);

  //   debugPrint("Token: ${loginResponse.token}");
  //   await TokenService().saveToken(loginResponse.token);

  //   return loginResponse;
  // } on DioException catch (e) {
  //   print("DIO ERROR TYPE: ${e.type}");
  //   print("DIO ERROR MESSAGE: ${e.message}");
  //   print("STATUS CODE: ${e.response?.statusCode}");
  //   print("RESPONSE BODY: ${e.response?.data}");

  //   rethrow;
  // }  }

  Future<User> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String username,
    required String banks,
    required int balance,
  }) async {
    try {
      List<String> bankList = banks
          .split(",")
          .map((bank) => bank.trim())
          .toList();

      final response = await dio.post(
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
      debugPrint("STATUS CODE $response.statusCode");
      debugPrint("RESPONSE DATA: ${response.data}");

      return User.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint("DIO ERROR TYPE: ${e.type}");
      debugPrint("DIO ERROR MESSAGE: ${e.message}");
      debugPrint("STATUS CODE: ${e.response?.statusCode}");
      debugPrint("RESPONSE BODY: ${e.response?.data}");
      rethrow;
    }
  }

  Future<User> fetchProfile() async {
    final response = await dio.get("/user/profile");

    return User.fromJson(response.data);
  }

  Future<void> logout() async {
    await TokenService().deleteToken();
  }
}
