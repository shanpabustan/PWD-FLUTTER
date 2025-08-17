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
  final _pwdIdController = TextEditingController();
  String _selectedDisabilityType = '';

  final List<String> _disabilityTypes = [
    'Visual Impairment',
    'Hearing Impairment',
    'Physical Disability',
    'Intellectual Disability',
    'Mental Health Disability',
    'Multiple Disabilities',
  ];

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<RegistrationProvider>(context, listen: false);
    _pwdIdController.text = provider.pwdIdNumber;
    _selectedDisabilityType = provider.disabilityType;
  }

  @override
  void dispose() {
    _pwdIdController.dispose();
    super.dispose();
  }

  void _updateProvider() {
    final provider = Provider.of<RegistrationProvider>(context, listen: false);
    provider.updatePwdDetails(
      pwdIdNumber: _pwdIdController.text,
      disabilityType: _selectedDisabilityType,
    );
  }

  Future<void> _pickDocument() async {
    // Simulate file picker
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Document Upload'),
        content: const Text('Document upload simulation - file selected successfully!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegistrationProvider>(
      builder: (context, provider, _) {
        return Column(
          children: [
            CustomTextField(
              controller: _pwdIdController,
              label: 'PWD ID Number',
              prefixIcon: Icons.badge,
              onChanged: (_) => _updateProvider(),
            ),
            
            const SizedBox(height: 16),
            
            // Disability Type Dropdown
            DropdownButtonFormField<String>(
              value: _selectedDisabilityType.isEmpty ? null : _selectedDisabilityType,
              decoration: InputDecoration(
                labelText: 'Disability Type',
                prefixIcon: const Icon(Icons.accessibility),
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              ),
              items: _disabilityTypes.map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _selectedDisabilityType = value ?? '');
                _updateProvider();
              },
            ),
            
            const SizedBox(height: 24),
            
            // Document Upload
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade50,
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.upload_file,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Upload Supporting Document',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'PWD ID, Medical Certificate, or other supporting documents',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: _pickDocument,
                    icon: const Icon(Icons.attach_file),
                    label: const Text('Choose File'),
                  ),
                  if (provider.supportingDocument != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle, color: Colors.green, size: 16),
                          const SizedBox(width: 4),
                          const Text(
                            'Document uploaded',
                            style: TextStyle(color: Colors.green, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}