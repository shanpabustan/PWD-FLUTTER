import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userEmail;

  bool get isLoggedIn => _isLoggedIn;
  String? get userEmail => _userEmail;

  Future<bool> login(String email, String password) async {
    // Simulate login logic
    await Future.delayed(const Duration(seconds: 2));
    
    if (email.isNotEmpty && password.isNotEmpty) {
      _isLoggedIn = true;
      _userEmail = email;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _isLoggedIn = false;
    _userEmail = null;
    notifyListeners();
  }

  Future<bool> register(Map<String, dynamic> userData) async {
    // Simulate registration logic
    await Future.delayed(const Duration(seconds: 3));
    _isLoggedIn = true;
    _userEmail = userData['email'];
    notifyListeners();
    return true;
  }
}