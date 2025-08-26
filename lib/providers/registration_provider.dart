import 'package:flutter/material.dart';
import 'dart:io';

class RegistrationProvider with ChangeNotifier {
  int _currentStep = 0;
  
  // Step 1: Personal Information
  String _applicantType = 'New'; // 'New' or 'Renewal'
  String? _disabilityNumber;
  String _lastName = '';
  String _firstName = '';
  String _middleName = '';
  String? _suffix;
  DateTime? _dateOfBirth;
  String _gender = '';
  String _civilStatus = '';
  
  // Parents Information
  String _fatherLastName = '';
  String _fatherFirstName = '';
  String _fatherMiddleName = '';
  String _motherLastName = '';
  String _motherFirstName = '';
  String _motherMiddleName = '';
  
  // Guardian Information
  String _guardianLastName = '';
  String _guardianFirstName = '';
  String _guardianMiddleName = '';
  
  // Step 2: PWD Details & Address
  String _typeOfDisability = '';
  String _causeOfDisability = '';
  
  // Address Information
  String _houseNoAndStreet = '';
  String _barangay = '';
  String _municipality = '';
  String _province = '';
  String _region = '';
  
  // Contact Information
  String? _landlineNo;
  String _mobileNo = '';
  String _emailAddress = '';
  
  // Educational and Employment Information
  String _educationalAttainment = '';
  String? _statusOfEmployment;
  String? _categoryOfEmployment;
  String? _typeOfEmployment;
  String? _occupation;
  String? _otherOccupation;
  String? _organizationAffiliated;
  String? _contactPerson;
  String? _officeAddress;
  String? _officeTelNo;
  
  // Government IDs
  String? _sssNo;
  String? _gsisNo;
  String? _pagIBIGNo;
  String? _psnNo;
  String? _philHealthNo;
  
  // Step 3: Account Setup & Accomplished By
  String _password = '';
  String _confirmPassword = '';
  
  // Accomplished By Information
  String _accomplishByLastName = '';
  String _accomplishByFirstName = '';
  String _accomplishByMiddleName = '';
  
  // Supporting Documents
  File? _supportingDocument;

  // Getters
  int get currentStep => _currentStep;
  
  // Step 1 Getters
  String get applicantType => _applicantType;
  String? get disabilityNumber => _disabilityNumber;
  String get lastName => _lastName;
  String get firstName => _firstName;
  String get middleName => _middleName;
  String? get suffix => _suffix;
  DateTime? get dateOfBirth => _dateOfBirth;
  String get gender => _gender;
  String get civilStatus => _civilStatus;
  String get fatherLastName => _fatherLastName;
  String get fatherFirstName => _fatherFirstName;
  String get fatherMiddleName => _fatherMiddleName;
  String get motherLastName => _motherLastName;
  String get motherFirstName => _motherFirstName;
  String get motherMiddleName => _motherMiddleName;
  String get guardianLastName => _guardianLastName;
  String get guardianFirstName => _guardianFirstName;
  String get guardianMiddleName => _guardianMiddleName;
  
  // Step 2 Getters
  String get typeOfDisability => _typeOfDisability;
  String get causeOfDisability => _causeOfDisability;
  String get houseNoAndStreet => _houseNoAndStreet;
  String get barangay => _barangay;
  String get municipality => _municipality;
  String get province => _province;
  String get region => _region;
  String? get landlineNo => _landlineNo;
  String get mobileNo => _mobileNo;
  String get emailAddress => _emailAddress;
  String get educationalAttainment => _educationalAttainment;
  String? get statusOfEmployment => _statusOfEmployment;
  String? get categoryOfEmployment => _categoryOfEmployment;
  String? get typeOfEmployment => _typeOfEmployment;
  String? get occupation => _occupation;
  String? get otherOccupation => _otherOccupation;
  String? get organizationAffiliated => _organizationAffiliated;
  String? get contactPerson => _contactPerson;
  String? get officeAddress => _officeAddress;
  String? get officeTelNo => _officeTelNo;
  String? get sssNo => _sssNo;
  String? get gsisNo => _gsisNo;
  String? get pagIBIGNo => _pagIBIGNo;
  String? get psnNo => _psnNo;
  String? get philHealthNo => _philHealthNo;
  
  // Step 3 Getters
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  String get accomplishByLastName => _accomplishByLastName;
  String get accomplishByFirstName => _accomplishByFirstName;
  String get accomplishByMiddleName => _accomplishByMiddleName;
  File? get supportingDocument => _supportingDocument;

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

  // Step 1: Personal Information Update
  void updatePersonalInfo({
    required String applicantType,
    String? disabilityNumber,
    required String lastName,
    required String firstName,
    required String middleName,
    String? suffix,
    DateTime? dateOfBirth,
    required String gender,
    required String civilStatus,
    required String fatherLastName,
    required String fatherFirstName,
    required String fatherMiddleName,
    required String motherLastName,
    required String motherFirstName,
    required String motherMiddleName,
    required String guardianLastName,
    required String guardianFirstName,
    required String guardianMiddleName,
  }) {
    _applicantType = applicantType;
    _disabilityNumber = disabilityNumber;
    _lastName = lastName;
    _firstName = firstName;
    _middleName = middleName;
    _suffix = suffix;
    _dateOfBirth = dateOfBirth;
    _gender = gender;
    _civilStatus = civilStatus;
    _fatherLastName = fatherLastName;
    _fatherFirstName = fatherFirstName;
    _fatherMiddleName = fatherMiddleName;
    _motherLastName = motherLastName;
    _motherFirstName = motherFirstName;
    _motherMiddleName = motherMiddleName;
    _guardianLastName = guardianLastName;
    _guardianFirstName = guardianFirstName;
    _guardianMiddleName = guardianMiddleName;
    notifyListeners();
  }

  // Step 2: PWD Details, Address, and Additional Information
  void updatePwdDetailsAndAddress({
    required String typeOfDisability,
    required String causeOfDisability,
    required String houseNoAndStreet,
    required String barangay,
    required String municipality,
    required String province,
    required String region,
    String? landlineNo,
    required String mobileNo,
    required String emailAddress,
    required String educationalAttainment,
    String? statusOfEmployment,
    String? categoryOfEmployment,
    String? typeOfEmployment,
    String? occupation,
    String? otherOccupation,
    String? organizationAffiliated,
    String? contactPerson,
    String? officeAddress,
    String? officeTelNo,
    String? sssNo,
    String? gsisNo,
    String? pagIBIGNo,
    String? psnNo,
    String? philHealthNo,
    File? supportingDocument,
  }) {
    _typeOfDisability = typeOfDisability;
    _causeOfDisability = causeOfDisability;
    _houseNoAndStreet = houseNoAndStreet;
    _barangay = barangay;
    _municipality = municipality;
    _province = province;
    _region = region;
    _landlineNo = landlineNo;
    _mobileNo = mobileNo;
    _emailAddress = emailAddress;
    _educationalAttainment = educationalAttainment;
    _statusOfEmployment = statusOfEmployment;
    _categoryOfEmployment = categoryOfEmployment;
    _typeOfEmployment = typeOfEmployment;
    _occupation = occupation;
    _otherOccupation = otherOccupation;
    _organizationAffiliated = organizationAffiliated;
    _contactPerson = contactPerson;
    _officeAddress = officeAddress;
    _officeTelNo = officeTelNo;
    _sssNo = sssNo;
    _gsisNo = gsisNo;
    _pagIBIGNo = pagIBIGNo;
    _psnNo = psnNo;
    _philHealthNo = philHealthNo;
    _supportingDocument = supportingDocument;
    notifyListeners();
  }

  // Step 3: Account Setup and Accomplished By
  void updateAccountSetup({
    required String password,
    required String confirmPassword,
    required String accomplishByLastName,
    required String accomplishByFirstName,
    required String accomplishByMiddleName,
  }) {
    _password = password;
    _confirmPassword = confirmPassword;
    _accomplishByLastName = accomplishByLastName;
    _accomplishByFirstName = accomplishByFirstName;
    _accomplishByMiddleName = accomplishByMiddleName;
    notifyListeners();
  }

  // Get all data for API submission
  Map<String, dynamic> getAllData() {
    return {
      'applicant_type': _applicantType,
      'disability_number': _disabilityNumber?.isEmpty == true ? null : _disabilityNumber,
      'last_name': _lastName,
      'first_name': _firstName,
      'middle_name': _middleName,
      'suffix': _suffix?.isEmpty == true ? null : _suffix,
      'date_of_birth': _dateOfBirth?.toIso8601String(),
      'gender': _gender,
      'civil_status': _civilStatus,
      'father_last_name': _fatherLastName,
      'father_first_name': _fatherFirstName,
      'father_middle_name': _fatherMiddleName,
      'mother_last_name': _motherLastName,
      'mother_first_name': _motherFirstName,
      'mother_middle_name': _motherMiddleName,
      'guardian_last_name': _guardianLastName,
      'guardian_first_name': _guardianFirstName,
      'guardian_middle_name': _guardianMiddleName,
      'type_of_disability': _typeOfDisability,
      'cause_of_disability': _causeOfDisability,
      'house_no_and_street': _houseNoAndStreet,
      'barangay': _barangay,
      'municipality': _municipality,
      'province': _province,
      'region': _region,
      'landline_no': _landlineNo?.isEmpty == true ? null : _landlineNo,
      'mobile_no': _mobileNo,
      'email_address': _emailAddress,
      'educational_attainment': _educationalAttainment,
      'status_of_employment': _statusOfEmployment?.isEmpty == true ? null : _statusOfEmployment,
      'category_of_employment': _categoryOfEmployment?.isEmpty == true ? null : _categoryOfEmployment,
      'type_of_employment': _typeOfEmployment?.isEmpty == true ? null : _typeOfEmployment,
      'occupation': _occupation?.isEmpty == true ? null : _occupation,
      'other_occupation': _otherOccupation?.isEmpty == true ? null : _otherOccupation,
      'organization_affiliated': _organizationAffiliated?.isEmpty == true ? null : _organizationAffiliated,
      'contact_person': _contactPerson?.isEmpty == true ? null : _contactPerson,
      'office_address': _officeAddress?.isEmpty == true ? null : _officeAddress,
      'office_tel_no': _officeTelNo?.isEmpty == true ? null : _officeTelNo,
      'sss_no': _sssNo?.isEmpty == true ? null : _sssNo,
      'gsis_no': _gsisNo?.isEmpty == true ? null : _gsisNo,
      'pagibig_no': _pagIBIGNo?.isEmpty == true ? null : _pagIBIGNo,
      'psn_no': _psnNo?.isEmpty == true ? null : _psnNo,
      'philhealth_no': _philHealthNo?.isEmpty == true ? null : _philHealthNo,
      'accomplish_by_last_name': _accomplishByLastName,
      'accomplish_by_first_name': _accomplishByFirstName,
      'accomplish_by_middle_name': _accomplishByMiddleName,
      'password': _password,
    };
  }

  void reset() {
    _currentStep = 0;
    _applicantType = 'New';
    _disabilityNumber = null;
    _lastName = '';
    _firstName = '';
    _middleName = '';
    _suffix = null;
    _dateOfBirth = null;
    _gender = '';
    _civilStatus = '';
    _fatherLastName = '';
    _fatherFirstName = '';
    _fatherMiddleName = '';
    _motherLastName = '';
    _motherFirstName = '';
    _motherMiddleName = '';
    _guardianLastName = '';
    _guardianFirstName = '';
    _guardianMiddleName = '';
    _typeOfDisability = '';
    _causeOfDisability = '';
    _houseNoAndStreet = '';
    _barangay = '';
    _municipality = '';
    _province = '';
    _region = '';
    _landlineNo = null;
    _mobileNo = '';
    _emailAddress = '';
    _educationalAttainment = '';
    _statusOfEmployment = null;
    _categoryOfEmployment = null;
    _typeOfEmployment = null;
    _occupation = null;
    _otherOccupation = null;
    _organizationAffiliated = null;
    _contactPerson = null;
    _officeAddress = null;
    _officeTelNo = null;
    _sssNo = null;
    _gsisNo = null;
    _pagIBIGNo = null;
    _psnNo = null;
    _philHealthNo = null;
    _password = '';
    _confirmPassword = '';
    _accomplishByLastName = '';
    _accomplishByFirstName = '';
    _accomplishByMiddleName = '';
    _supportingDocument = null;
    notifyListeners();
  }

  // Validation methods for each step
  bool isStep1Valid() {
    return _lastName.isNotEmpty &&
           _firstName.isNotEmpty &&
           _middleName.isNotEmpty &&
           _dateOfBirth != null &&
           _gender.isNotEmpty &&
           _civilStatus.isNotEmpty &&
           _fatherLastName.isNotEmpty &&
           _fatherFirstName.isNotEmpty &&
           _fatherMiddleName.isNotEmpty &&
           _motherLastName.isNotEmpty &&
           _motherFirstName.isNotEmpty &&
           _motherMiddleName.isNotEmpty;
  }

  bool isStep2Valid() {
    return _typeOfDisability.isNotEmpty &&
           _causeOfDisability.isNotEmpty &&
           _houseNoAndStreet.isNotEmpty &&
           _barangay.isNotEmpty &&
           _municipality.isNotEmpty &&
           _province.isNotEmpty &&
           _region.isNotEmpty &&
           _mobileNo.isNotEmpty &&
           _emailAddress.isNotEmpty &&
           _educationalAttainment.isNotEmpty;
  }

  bool isStep3Valid() {
    return _password.isNotEmpty &&
           _password == _confirmPassword &&
           _accomplishByLastName.isNotEmpty &&
           _accomplishByFirstName.isNotEmpty &&
           _accomplishByMiddleName.isNotEmpty;
  }
}