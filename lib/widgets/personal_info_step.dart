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
  final _fullNameController = TextEditingController();
  final _contactController = TextEditingController();
  DateTime? _selectedDate;
  String _selectedGender = '';

  final List<String> _genderOptions = ['Male', 'Female', 'Other'];

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<RegistrationProvider>(context, listen: false);
    _fullNameController.text = provider.fullName;
    _contactController.text = provider.contactNumber;
    _selectedDate = provider.dateOfBirth;
    _selectedGender = provider.gender;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  void _updateProvider() {
    final provider = Provider.of<RegistrationProvider>(context, listen: false);
    provider.updatePersonalInfo(
      fullName: _fullNameController.text,
      dateOfBirth: _selectedDate,
      gender: _selectedGender,
      contactNumber: _contactController.text,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: _fullNameController,
          label: 'Full Name',
          prefixIcon: Icons.person,
          onChanged: (_) => _updateProvider(),
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
                        ? 'Select Date of Birth'
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
        
        // Gender Dropdown
        DropdownButtonFormField<String>(
          value: _selectedGender.isEmpty ? null : _selectedGender,
          decoration: InputDecoration(
            labelText: 'Gender',
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
        
        const SizedBox(height: 16),
        
        CustomTextField(
          controller: _contactController,
          label: 'Contact Number',
          keyboardType: TextInputType.phone,
          prefixIcon: Icons.phone,
          onChanged: (_) => _updateProvider(),
        ),
      ],
    );
  }
}