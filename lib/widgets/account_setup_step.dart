import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/registration_provider.dart';
import 'custom_text_field.dart';

class AccountSetupStep extends StatefulWidget {
  const AccountSetupStep({super.key});

  @override
  State<AccountSetupStep> createState() => _AccountSetupStepState();
}

class _AccountSetupStepState extends State<AccountSetupStep> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  // Accomplished By Controllers
  final _accomplishByLastNameController = TextEditingController();
  final _accomplishByFirstNameController = TextEditingController();
  final _accomplishByMiddleNameController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<RegistrationProvider>(context, listen: false);
    _passwordController.text = provider.password;
    _confirmPasswordController.text = provider.confirmPassword;
    _accomplishByLastNameController.text = provider.accomplishByLastName;
    _accomplishByFirstNameController.text = provider.accomplishByFirstName;
    _accomplishByMiddleNameController.text = provider.accomplishByMiddleName;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _accomplishByLastNameController.dispose();
    _accomplishByFirstNameController.dispose();
    _accomplishByMiddleNameController.dispose();
    super.dispose();
  }

  void _updateProvider() {
    final provider = Provider.of<RegistrationProvider>(context, listen: false);
    provider.updateAccountSetup(
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
      accomplishByLastName: _accomplishByLastNameController.text,
      accomplishByFirstName: _accomplishByFirstNameController.text,
      accomplishByMiddleName: _accomplishByMiddleNameController.text,
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Account Credentials'),
          
          CustomTextField(
            controller: _passwordController,
            label: 'Password *',
            obscureText: _obscurePassword,
            prefixIcon: Icons.lock,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() => _obscurePassword = !_obscurePassword);
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              if (value.length < 8) {
                return 'Password must be at least 8 characters';
              }
              return null;
            },
            onChanged: (_) => _updateProvider(),
          ),
          
          const SizedBox(height: 16),
          
          CustomTextField(
            controller: _confirmPasswordController,
            label: 'Confirm Password *',
            obscureText: _obscureConfirmPassword,
            prefixIcon: Icons.lock_outline,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
            onChanged: (_) => _updateProvider(),
          ),
          
          const SizedBox(height: 24),
          
          // Password Requirements
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Password Requirements:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildPasswordRequirement(
                  'At least 8 characters long',
                  _passwordController.text.length >= 8,
                ),
                _buildPasswordRequirement(
                  'Contains at least one letter',
                  _passwordController.text.contains(RegExp(r'[a-zA-Z]')),
                ),
                _buildPasswordRequirement(
                  'Contains at least one number',
                  _passwordController.text.contains(RegExp(r'[0-9]')),
                ),
                _buildPasswordRequirement(
                  'Passwords match',
                  _passwordController.text == _confirmPasswordController.text && 
                  _confirmPasswordController.text.isNotEmpty,
                ),
              ],
            ),
          ),

          _buildSectionHeader('Form Accomplished By'),

          Text(
            'Please provide the information of the person who is filling out this form.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _accomplishByLastNameController,
                  label: 'Last Name *',
                  prefixIcon: Icons.person,
                  onChanged: (_) => _updateProvider(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomTextField(
                  controller: _accomplishByFirstNameController,
                  label: 'First Name *',
                  onChanged: (_) => _updateProvider(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          CustomTextField(
            controller: _accomplishByMiddleNameController,
            label: 'Middle Name *',
            onChanged: (_) => _updateProvider(),
          ),

          const SizedBox(height: 24),

          // Information Notice
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info,
                      size: 20,
                      color: Colors.blue.shade700,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Important Information',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '• Your account will be created using the email address provided in the previous step.\n'
                  '• Please ensure all information is accurate as it will be used for your PWD ID application.\n'
                  '• You will receive a confirmation email after successful registration.\n'
                  '• Keep your password secure and do not share it with anyone.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue.shade700,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Terms and Conditions Checkbox
          Consumer<RegistrationProvider>(
            builder: (context, provider, child) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.verified_user,
                          color: Theme.of(context).colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Data Privacy Notice',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'By proceeding with this registration, you acknowledge that you have read and understood our Data Privacy Policy. '
                                'Your personal information will be processed in accordance with Republic Act 10173 (Data Privacy Act of 2012) '
                                'and will be used solely for PWD registration and related services.',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[700],
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildPasswordRequirement(String requirement, bool isMet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.circle_outlined,
            size: 16,
            color: isMet ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              requirement,
              style: TextStyle(
                fontSize: 12,
                color: isMet ? Colors.green : Colors.grey[600],
                fontWeight: isMet ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}