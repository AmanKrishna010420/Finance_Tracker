import 'package:finance_tracker/models/login_response.dart';
import 'package:finance_tracker/models/user.dart';
import 'package:finance_tracker/services/auth_service.dart';
import 'package:finance_tracker/services/token_service.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  User? currentUser;

  final AuthService _authService = AuthService();

  bool isLoading = false;
  String? errorMessage;

  bool get isLoggedIn => currentUser != null;

  Future<bool> login({required String email, required String password}) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      debugPrint("Attempting login for email: $email");
      debugPrint("STEP 1");
      final LoginResponse loginResponse = await _authService.login(
        email: email,
        password: password,
      );
      debugPrint("STEP2");
      currentUser = loginResponse.user;
      debugPrint("Step 3");
      isLoading = false;
      debugPrint("Step4");
      notifyListeners();
      debugPrint("Step 5");

      return true;
    } catch (e, stackTrace) {
      isLoading = false;
      debugPrint("Login failed: $errorMessage");
      debugPrint("Stack Trace: $stackTrace");
      errorMessage = e.toString();

      notifyListeners();

      return false;
    }
  }

  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String username,
    required String banks,
    required int balance,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;

      notifyListeners();
      debugPrint("Attempting registration for email: $email");
      await _authService.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        username: username,
        banks: banks,
        balance: balance,
      );
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

  Future<void> loadUserSession() async {
    try {
      final hasToken = await TokenService().hasToken();

      if (!hasToken) {
        currentUser = null;
        notifyListeners();
        return;
      }

      currentUser = await _authService.fetchProfile();

      notifyListeners();
    } catch (e) {
      currentUser = null;
      await TokenService().deleteToken();
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authService.logout();

    currentUser = null;

    notifyListeners();
  }
}
