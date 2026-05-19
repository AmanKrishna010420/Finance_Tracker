import 'package:finance_tracker/models/user.dart';
import 'package:finance_tracker/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      final user = await _authService.login(email: email, password: password);
      currentUser = user as User?;
      await savedUserSession();
      isLoading = false;
      return true;
    } catch (e) {
      isLoading = false;
      errorMessage = "Login failed: ${e.toString()}";
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
      final user = await _authService.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        username: username,
        banks: banks,
        balance: balance,
      );
      currentUser = user as User?;
      await savedUserSession();
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

  Future<void> savedUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", currentUser!.email ?? '');
  }

  Future<void> loadUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString("email");

    if (email != null) {
      currentUser = User(email: email);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    currentUser = null;
    notifyListeners();
  }
}
