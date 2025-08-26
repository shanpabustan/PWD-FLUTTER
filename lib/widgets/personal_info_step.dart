import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/registration_provider.dart';
import 'custom_text_field.dart';

class PersonalInfoStep extends StatefulWidget {
  const PersonalInfoStep({super.key});

  @override
  State<PersonalInfoStep> createState() => _PersonalInfoStepState();
}

class _PersonalInfoStepState extends State<PersonalInfoStep> {
  // Basic Info Controllers
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _suffixController = TextEditingController();
  final _disabilityNumberController = TextEditingController();
  
  // Father's Info Controllers
  final _fatherLastNameController = TextEditingController();
  final _fatherFirstNameController = TextEditingController();
  final _fatherMiddleNameController = TextEditingController();
  
  // Mother's Info Controllers
  final _motherLastNameController = TextEditingController();
  final _motherFirstNameController = TextEditingController();
  final _motherMiddleNameController = TextEditingController();
  
  // Guardian's Info Controllers
  final _guardianLastNameController = TextEditingController();
  final _guardianFirstNameController = TextEditingController();
  final _guardianMiddleNameController = TextEditingController();

  DateTime? _selectedDate;
  String _selectedGender = '';
  String _selectedCivilStatus = '';
  String _selectedApplicantType = 'New';

  final List<String> _genderOptions = ['Male', 'Female'];
  final List<String> _civilStatusOptions = [
    'Single',
    'Married',
    'Widowed',
    'Separated',
    'Divorced'
  ];
  final List<String> _applicantTypeOptions = ['New', 'Renewal'];

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<RegistrationProvider>(context, listen: false);
    
    // Initialize controllers with existing data
    _lastNameController.text = provider.lastName;
    _firstNameController.text = provider.firstName;
    _middleNameController.text = provider.middleName;
    _suffixController.text = provider.suffix ?? '';
    _disabilityNumberController.text = provider.disabilityNumber ?? '';
    
    _fatherLastNameController.text = provider.fatherLastName;
    _fatherFirstNameController.text = provider.fatherFirstName;
    _fatherMiddleNameController.text = provider.fatherMiddleName;
    
    _motherLastNameController.text = provider.motherLastName;
    _motherFirstNameController.text = provider.motherFirstName;
    _motherMiddleNameController.text = provider.motherMiddleName;
    
    _guardianLastNameController.text = provider.guardianLastName;
    _guardianFirstNameController.text = provider.guardianFirstName;
    _guardianMiddleNameController.text = provider.guardianMiddleName;
    
    _selectedDate = provider.dateOfBirth;
    _selectedGender = provider.gender;
    _selectedCivilStatus = provider.civilStatus;
    _selectedApplicantType = provider.applicantType;
  }

  @override
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
    _middleNameController.dispose();
    _suffixController.dispose();
    _disabilityNumberController.dispose();
    _fatherLastNameController.dispose();
    _fatherFirstNameController.dispose();
    _fatherMiddleNameController.dispose();
    _motherLastNameController.dispose();
    _motherFirstNameController.dispose();
    _motherMiddleNameController.dispose();
    _guardianLastNameController.dispose();
    _guardianFirstNameController.dispose();
    _guardianMiddleNameController.dispose();
    super.dispose();
  }

  void _updateProvider() {
    final provider = Provider.of<RegistrationProvider>(context, listen: false);
    provider.updatePersonalInfo(
      applicantType: _selectedApplicantType,
      disabilityNumber: _disabilityNumberController.text.isEmpty ? null : _disabilityNumberController.text,
      lastName: _lastNameController.text,
      firstName: _firstNameController.text,
      middleName: _middleNameController.text,
      suffix: _suffixController.text.isEmpty ? null : _suffixController.text,
      dateOfBirth: _selectedDate,
      gender: _selectedGender,
      civilStatus: _selectedCivilStatus,
      fatherLastName: _fatherLastNameController.text,
      fatherFirstName: _fatherFirstNameController.text,
      fatherMiddleName: _fatherMiddleNameController.text,
      motherLastName: _motherLastNameController.text,
      motherFirstName: _motherFirstNameController.text,
      motherMiddleName: _motherMiddleNameController.text,
      guardianLastName: _guardianLastNameController.text,
      guardianFirstName: _guardianFirstNameController.text,
      guardianMiddleName: _guardianMiddleNameController.text,
    );
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now().subtract(const Duration(days: 365 * 20)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() => _selectedDate = date);
      _updateProvider();
    }
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 16),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Applicant Type
          DropdownButtonFormField<String>(
            value: _selectedApplicantType,
            decoration: InputDecoration(
              labelText: 'Application Type *',
              prefixIcon: const Icon(Icons.assignment),
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
            ),
            items: _applicantTypeOptions.map((type) {
              return DropdownMenuItem<String>(
                value: type,
                child: Text(type),
              );
            }).toList(),
            onChanged: (value) {
              setState(() => _selectedApplicantType = value ?? 'New');
              _updateProvider();
            },
          ),

          const SizedBox(height: 16),

          // PWD ID Number (for renewal)
          if (_selectedApplicantType == 'Renewal') ...[
            CustomTextField(
              controller: _disabilityNumberController,
              label: 'Existing PWD ID Number',
              prefixIcon: Icons.badge,
              onChanged: (_) => _updateProvider(),
            ),
            const SizedBox(height: 16),
          ],

          _buildSectionHeader('Personal Information'),

          // Name Fields Row
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _lastNameController,
                  label: 'Last Name *',
                  prefixIcon: Icons.person,
                  onChanged: (_) => _updateProvider(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomTextField(
                  controller: _firstNameController,
                  label: 'First Name *',
                  onChanged: (_) => _updateProvider(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                flex: 2,
                child: CustomTextField(
                  controller: _middleNameController,
                  label: 'Middle Name *',
                  onChanged: (_) => _updateProvider(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 1,
                child: CustomTextField(
                  controller: _suffixController,
                  label: 'Suffix',
                  onChanged: (_) => _updateProvider(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Date of Birth
          InkWell(
            onTap: _selectDate,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
                color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Select Date of Birth *'
                          : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                      style: TextStyle(
                        color: _selectedDate == null ? Colors.grey[600] : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Gender and Civil Status Row
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedGender.isEmpty ? null : _selectedGender,
                  decoration: InputDecoration(
                    labelText: 'Gender *',
                    prefixIcon: const Icon(Icons.person_outline),
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
                  ),
                  items: _genderOptions.map((gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedGender = value ?? '');
                    _updateProvider();
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedCivilStatus.isEmpty ? null : _selectedCivilStatus,
                  decoration: InputDecoration(
                    labelText: 'Civil Status *',
                    prefixIcon: const Icon(Icons.favorite),
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
                  ),
                  items: _civilStatusOptions.map((status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedCivilStatus = value ?? '');
                    _updateProvider();
                  },
                ),
              ),
            ],
          ),

          _buildSectionHeader("Father's Information"),

          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _fatherLastNameController,
                  label: "Father's Last Name *",
                  prefixIcon: Icons.man,
                  onChanged: (_) => _updateProvider(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomTextField(
                  controller: _fatherFirstNameController,
                  label: "Father's First Name *",
                  onChanged: (_) => _updateProvider(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          CustomTextField(
            controller: _fatherMiddleNameController,
            label: "Father's Middle Name *",
            onChanged: (_) => _updateProvider(),
          ),

          _buildSectionHeader("Mother's Information"),

          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _motherLastNameController,
                  label: "Mother's Last Name *",
                  prefixIcon: Icons.woman,
                  onChanged: (_) => _updateProvider(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomTextField(
                  controller: _motherFirstNameController,
                  label: "Mother's First Name *",
                  onChanged: (_) => _updateProvider(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          CustomTextField(
            controller: _motherMiddleNameController,
            label: "Mother's Middle Name *",
            onChanged: (_) => _updateProvider(),
          ),

          _buildSectionHeader("Guardian's Information"),

          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _guardianLastNameController,
                  label: "Guardian's Last Name",
                  prefixIcon: Icons.shield,
                  onChanged: (_) => _updateProvider(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomTextField(
                  controller: _guardianFirstNameController,
                  label: "Guardian's First Name",
                  onChanged: (_) => _updateProvider(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          CustomTextField(
            controller: _guardianMiddleNameController,
            label: "Guardian's Middle Name",
            onChanged: (_) => _updateProvider(),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}