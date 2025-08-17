import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _userName = 'John Doe';
  String _pwdId = 'PWD-2024-001234';
  String _disabilityType = 'Visual Impairment';
  List<Map<String, dynamic>> _discountHistory = [
    {
      'establishment': 'ABC Restaurant',
      'discount': '20%',
      'amount': '₱150.00',
      'date': DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      'establishment': 'XYZ Pharmacy',
      'discount': '15%',
      'amount': '₱75.00',
      'date': DateTime.now().subtract(const Duration(days: 5)),
    },
  ];

  List<Map<String, dynamic>> _announcements = [
    {
      'title': 'New PWD Benefits Available',
      'content': 'Additional healthcare benefits now available for all registered PWDs.',
      'date': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'title': 'Annual PWD Conference 2024',
      'content': 'Join us for the annual conference on disability rights and advocacy.',
      'date': DateTime.now().subtract(const Duration(days: 3)),
    },
  ];

  String get userName => _userName;
  String get pwdId => _pwdId;
  String get disabilityType => _disabilityType;
  List<Map<String, dynamic>> get discountHistory => _discountHistory;
  List<Map<String, dynamic>> get announcements => _announcements;

  void updateProfile(String name, String pwdId, String disabilityType) {
    _userName = name;
    _pwdId = pwdId;
    _disabilityType = disabilityType;
    notifyListeners();
  }
}