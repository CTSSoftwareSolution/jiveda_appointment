import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api_service.dart';
import '../../models.dart';


class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _error;
  UserProfile? _currentUser;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get error => _error;
  UserProfile? get currentUser => _currentUser;

  Future<void> checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token != null) {
      ApiService.setToken(token);
      _isAuthenticated = true;
      _currentUser = UserProfile.mock();
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await ApiService.login(email, password);

    if (result['success'] == true) {
      final token = result['token'];
      ApiService.setToken(token);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
      _isAuthenticated = true;
      _currentUser = UserProfile.mock();
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _error = result['message'] ?? 'Login failed';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    _isAuthenticated = false;
    _currentUser = null;
    notifyListeners();
  }
}


