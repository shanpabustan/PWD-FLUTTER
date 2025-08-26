import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../providers/registration_provider.dart';
import 'custom_text_field.dart';

class PwdDetailsStep extends StatefulWidget {
  const PwdDetailsStep({super.key});

  @override
  State<PwdDetailsStep> createState() => _PwdDetailsStepState();
}

class _PwdDetailsStepState extends State<PwdDetailsStep> {
  // Disability Controllers
  String _selectedDisabilityType = '';
  final _causeOfDisabilityController = TextEditingController();
  
  // Address Controllers
  final _houseNoAndStreetController = TextEditingController();
  final _barangayController = TextEditingController();
  final _municipalityController = TextEditingController();
  final _provinceController = TextEditingController();
  final _regionController = TextEditingController();
  
  // Contact Controllers
  final _landlineController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  
  // Education and Employment Controllers
  String _selectedEducationalAttainment = '';
  String _selectedStatusOfEmployment = '';
  String _selectedCategoryOfEmployment = '';
  String _selectedTypeOfEmployment = '';
  String _selectedOccupation = '';
  final _otherOccupationController = TextEditingController();
  final _organizationAffiliatedController = TextEditingController();
  final _contactPersonController = TextEditingController();
  final _officeAddressController = TextEditingController();
  final _officeTelController = TextEditingController();
  
  // Government ID Controllers
  final _sssController = TextEditingController();
  final _gsisController = TextEditingController();
  final _pagibigController = TextEditingController();
  final _psnController = TextEditingController();
  final _philHealthController = TextEditingController();

  // Dropdown Options
  final List<String> _disabilityTypes = [
    'Visual Impairment',
    'Hearing Impairment',
    'Physical Disability',
    'Intellectual Disability',
    'Psychosocial Disability',
    'Multiple Disabilities',
    'Speech and Language Impairment',
    'Learning Disability',
    'Chronic Illness',
    'Other'
  ];

  final List<String> _educationalAttainmentOptions = [
    'No Formal Education',
    'Elementary Level',
    'Elementary Graduate',
    'High School Level',
    'High School Graduate',
    'Vocational Course',
    'College Level',
    'College Graduate',
    'Post Graduate'
  ];

  final List<String> _employmentStatusOptions = [
    'Employed',
    'Unemployed',
    'Self-Employed',
    'Retired',
    'Student',
    'Not Applicable'
  ];

  final List<String> _categoryOfEmploymentOptions = [
    'Government',
    'Private',
    'NGO',
    'International Organization'
  ];

  final List<String> _typeOfEmploymentOptions = [
    'Regular',
    'Contractual',
    'Casual',
    'Job Order'
  ];

  final List<String> _occupationOptions = [
    'Professional',
    'Technical',
    'Clerical',
    'Service Worker',
    'Skilled Worker',
    'Elementary Occupation',
    'Manager/Supervisor',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<RegistrationProvider>(context, listen: false);
    
    // Initialize controllers with existing data
    _selectedDisabilityType = provider.typeOfDisability;
    _causeOfDisabilityController.text = provider.causeOfDisability;
    
    _houseNoAndStreetController.text = provider.houseNoAndStreet;
    _barangayController.text = provider.barangay;
    _municipalityController.text = provider.municipality;
    _provinceController.text = provider.province;
    _regionController.text = provider.region;
    
    _landlineController.text = provider.landlineNo ?? '';
    _mobileController.text = provider.mobileNo;
    _emailController.text = provider.emailAddress;
    
    _selectedEducationalAttainment = provider.educationalAttainment;
    _selectedStatusOfEmployment = provider.statusOfEmployment ?? '';
    _selectedCategoryOfEmployment = provider.categoryOfEmployment ?? '';
    _selectedTypeOfEmployment = provider.typeOfEmployment ?? '';
    _selectedOccupation = provider.occupation ?? '';
    
    _otherOccupationController.text = provider.otherOccupation ?? '';
    _organizationAffiliatedController.text = provider.organizationAffiliated ?? '';
    _contactPersonController.text = provider.contactPerson ?? '';
    _officeAddressController.text = provider.officeAddress ?? '';
    _officeTelController.text = provider.officeTelNo ?? '';
    
    _sssController.text = provider.sssNo ?? '';
    _gsisController.text = provider.gsisNo ?? '';
    _pagibigController.text = provider.pagIBIGNo ?? '';
    _psnController.text = provider.psnNo ?? '';
    _philHealthController.text = provider.philHealthNo ?? '';
  }

  @override
  void dispose() {
    _causeOfDisabilityController.dispose();
    _houseNoAndStreetController.dispose();
    _barangayController.dispose();
    _municipalityController.dispose();
    _provinceController.dispose();
    _regionController.dispose();
    _landlineController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _otherOccupationController.dispose();
    _organizationAffiliatedController.dispose();
    _contactPersonController.dispose();
    _officeAddressController.dispose();
    _officeTelController.dispose();
    _sssController.dispose();
    _gsisController.dispose();
    _pagibigController.dispose();
    _psnController.dispose();
    _philHealthController.dispose();
    super.dispose();
  }

  void _updateProvider() {
    final provider = Provider.of<RegistrationProvider>(context, listen: false);
    provider.updatePwdDetailsAndAddress(
      typeOfDisability: _selectedDisabilityType,
      causeOfDisability: _causeOfDisabilityController.text,
      houseNoAndStreet: _houseNoAndStreetController.text,
      barangay: _barangayController.text,
      municipality: _municipalityController.text,
      province: _provinceController.text,
      region: _regionController.text,
      landlineNo: _landlineController.text.isEmpty ? null : _landlineController.text,
      mobileNo: _mobileController.text,
      emailAddress: _emailController.text,
      educationalAttainment: _selectedEducationalAttainment,
      statusOfEmployment: _selectedStatusOfEmployment.isEmpty ? null : _selectedStatusOfEmployment,
      categoryOfEmployment: _selectedCategoryOfEmployment.isEmpty ? null : _selectedCategoryOfEmployment,
      typeOfEmployment: _selectedTypeOfEmployment.isEmpty ? null : _selectedTypeOfEmployment,
      occupation: _selectedOccupation.isEmpty ? null : _selectedOccupation,
      otherOccupation: _otherOccupationController.text.isEmpty ? null : _otherOccupationController.text,
      organizationAffiliated: _organizationAffiliatedController.text.isEmpty ? null : _organizationAffiliatedController.text,
      contactPerson: _contactPersonController.text.isEmpty ? null : _contactPersonController.text,
      officeAddress: _officeAddressController.text.isEmpty ? null : _officeAddressController.text,
      officeTelNo: _officeTelController.text.isEmpty ? null : _officeTelController.text,
      sssNo: _sssController.text.isEmpty ? null : _sssController.text,
      gsisNo: _gsisController.text.isEmpty ? null : _gsisController.text,
      pagIBIGNo: _pagibigController.text.isEmpty ? null : _pagibigController.text,
      psnNo: _psnController.text.isEmpty ? null : _psnController.text,
      philHealthNo: _philHealthController.text.isEmpty ? null : _philHealthController.text,
      supportingDocument: null, // Handle file upload separately
    );
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

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> options,
    required Function(String?) onChanged,
    IconData? prefixIcon,
    bool isRequired = false,
  }) {
    return DropdownButtonFormField<String>(
      value: value.isEmpty ? null : value,
      decoration: InputDecoration(
        labelText: '$label${isRequired ? ' *' : ''}',
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
      ),
      items: options.map((option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Disability Information'),
          
          _buildDropdown(
            label: 'Type of Disability',
            value: _selectedDisabilityType,
            options: _disabilityTypes,
            prefixIcon: Icons.accessibility,
            isRequired: true,
            onChanged: (value) {
              setState(() => _selectedDisabilityType = value ?? '');
              _updateProvider();
            },
          ),

          const SizedBox(height: 16),

          CustomTextField(
            controller: _causeOfDisabilityController,
            label: 'Cause of Disability *',
            prefixIcon: Icons.medical_services,
            onChanged: (_) => _updateProvider(),
          ),

          _buildSectionHeader('Address Information'),

          CustomTextField(
            controller: _houseNoAndStreetController,
            label: 'House No. and Street *',
            prefixIcon: Icons.home,
            onChanged: (_) => _updateProvider(),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _barangayController,
                  label: 'Barangay *',
                  onChanged: (_) => _updateProvider(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomTextField(
                  controller: _municipalityController,
                  label: 'Municipality *',
                  onChanged: (_) => _updateProvider(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _provinceController,
                  label: 'Province *',
                  onChanged: (_) => _updateProvider(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomTextField(
                  controller: _regionController,
                  label: 'Region *',
                  onChanged: (_) => _updateProvider(),
                ),
              ),
            ],
          ),

          _buildSectionHeader('Contact Information'),

          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _landlineController,
                  label: 'Landline Number',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone,
                  onChanged: (_) => _updateProvider(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomTextField(
                  controller: _mobileController,
                  label: 'Mobile Number *',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.smartphone,
                  onChanged: (_) => _updateProvider(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          CustomTextField(
            controller: _emailController,
            label: 'Email Address *',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email,
            onChanged: (_) => _updateProvider(),
          ),

          _buildSectionHeader('Educational & Employment Information'),

          _buildDropdown(
            label: 'Educational Attainment',
            value: _selectedEducationalAttainment,
            options: _educationalAttainmentOptions,
            prefixIcon: Icons.school,
            isRequired: true,
            onChanged: (value) {
              setState(() => _selectedEducationalAttainment = value ?? '');
              _updateProvider();
            },
          ),

          const SizedBox(height: 16),

          _buildDropdown(
            label: 'Status of Employment',
            value: _selectedStatusOfEmployment,
            options: _employmentStatusOptions,
            prefixIcon: Icons.work,
            onChanged: (value) {
              setState(() => _selectedStatusOfEmployment = value ?? '');
              _updateProvider();
            },
          ),

          const SizedBox(height: 16),

          // Show employment details if employed
          if (_selectedStatusOfEmployment == 'Employed' || _selectedStatusOfEmployment == 'Self-Employed') ...[
            Row(
              children: [
                Expanded(
                  child: _buildDropdown(
                    label: 'Category of Employment',
                    value: _selectedCategoryOfEmployment,
                    options: _categoryOfEmploymentOptions,
                    onChanged: (value) {
                      setState(() => _selectedCategoryOfEmployment = value ?? '');
                      _updateProvider();
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDropdown(
                    label: 'Type of Employment',
                    value: _selectedTypeOfEmployment,
                    options: _typeOfEmploymentOptions,
                    onChanged: (value) {
                      setState(() => _selectedTypeOfEmployment = value ?? '');
                      _updateProvider();
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            _buildDropdown(
              label: 'Occupation',
              value: _selectedOccupation,
              options: _occupationOptions,
              prefixIcon: Icons.badge,
              onChanged: (value) {
                setState(() => _selectedOccupation = value ?? '');
                _updateProvider();
              },
            ),

            const SizedBox(height: 16),

            if (_selectedOccupation == 'Other') ...[
              CustomTextField(
                controller: _otherOccupationController,
                label: 'Please specify occupation',
                onChanged: (_) => _updateProvider(),
              ),
              const SizedBox(height: 16),
            ],

            CustomTextField(
              controller: _organizationAffiliatedController,
              label: 'Organization/Company Name',
              prefixIcon: Icons.business,
              onChanged: (_) => _updateProvider(),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: _contactPersonController,
                    label: 'Contact Person',
                    onChanged: (_) => _updateProvider(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomTextField(
                    controller: _officeTelController,
                    label: 'Office Tel. No.',
                    keyboardType: TextInputType.phone,
                    onChanged: (_) => _updateProvider(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            CustomTextField(
              controller: _officeAddressController,
              label: 'Office Address',
              prefixIcon: Icons.location_on,
              maxLines: 2,
              onChanged: (_) => _updateProvider(),
            ),

            const SizedBox(height: 16),
          ],

          _buildSectionHeader('Government IDs (Optional)'),

          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _sssController,
                  label: 'SSS No.',
                  prefixIcon: Icons.credit_card,
                  onChanged: (_) => _updateProvider(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomTextField(
                  controller: _gsisController,
                  label: 'GSIS No.',
                  prefixIcon: Icons.credit_card,
                  onChanged: (_) => _updateProvider(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _pagibigController,
                  label: 'Pag-IBIG No.',
                  prefixIcon: Icons.credit_card,
                  onChanged: (_) => _updateProvider(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomTextField(
                  controller: _psnController,
                  label: 'PSN No.',
                  prefixIcon: Icons.credit_card,
                  onChanged: (_) => _updateProvider(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          CustomTextField(
            controller: _philHealthController,
            label: 'PhilHealth No.',
            prefixIcon: Icons.health_and_safety,
            onChanged: (_) => _updateProvider(),
          ),

          const SizedBox(height: 24),

          // Document Upload Section
          _buildSectionHeader('Supporting Documents'),
          
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 2, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade50,
            ),
            child: Column(
              children: [
                Icon(
                  Icons.upload_file,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Upload Supporting Documents',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Medical Certificate, Disability Assessment Report, or other relevant documents',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () {
                    // Simulate file picker
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Document Upload'),
                        content: const Text('Document upload functionality will be implemented with file_picker package.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.attach_file),
                  label: const Text('Choose Files'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Supported formats: PDF, JPG, PNG (Max 5MB)',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}