import 'package:flutter/material.dart';
import 'dart:io';

class RegistrationProvider with ChangeNotifier {
  int _currentStep = 0;
  
  // Step 1 data
  String _fullName = '';
  DateTime? _dateOfBirth;
  String _gender = '';
  String _contactNumber = '';
  
  // Step 2 data
  String _pwdIdNumber = '';
  String _disabilityType = '';
  File? _supportingDocument;
  
  // Step 3 data
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  // Getters
  int get currentStep => _currentStep;
  String get fullName => _fullName;
  DateTime? get dateOfBirth => _dateOfBirth;
  String get gender => _gender;
  String get contactNumber => _contactNumber;
  String get pwdIdNumber => _pwdIdNumber;
  String get disabilityType => _disabilityType;
  File? get supportingDocument => _supportingDocument;
  String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;

  void nextStep() {
    if (_currentStep < 2) {
      _currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  void updatePersonalInfo({
    required String fullName,
    DateTime? dateOfBirth,
    required String gender,
    required String contactNumber,
  }) {
    _fullName = fullName;
    _dateOfBirth = dateOfBirth;
    _gender = gender;
    _contactNumber = contactNumber;
    notifyListeners();
  }

  void updatePwdDetails({
    required String pwdIdNumber,
    required String disabilityType,
    File? supportingDocument,
  }) {
    _pwdIdNumber = pwdIdNumber;
    _disabilityType = disabilityType;
    _supportingDocument = supportingDocument;
    notifyListeners();
  }

  void updateAccountSetup({
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    _email = email;
    _password = password;
    _confirmPassword = confirmPassword;
    notifyListeners();
  }

  Map<String, dynamic> getAllData() {
    return {
      'fullName': _fullName,
      'dateOfBirth': _dateOfBirth,
      'gender': _gender,
      'contactNumber': _contactNumber,
      'pwdIdNumber': _pwdIdNumber,
      'disabilityType': _disabilityType,
      'supportingDocument': _supportingDocument,
      'email': _email,
      'password': _password,
    };
  }

  void reset() {
    _currentStep = 0;
    _fullName = '';
    _dateOfBirth = null;
    _gender = '';
    _contactNumber = '';
    _pwdIdNumber = '';
    _disabilityType = '';
    _supportingDocument = null;
    _email = '';
    _password = '';
    _confirmPassword = '';
    notifyListeners();
  }
}