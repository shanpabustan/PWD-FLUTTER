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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<RegistrationProvider>(context, listen: false);
    _emailController.text = provider.email;
    _passwordController.text = provider.password;
    _confirmPasswordController.text = provider.confirmPassword;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _updateProvider() {
    final provider = Provider.of<RegistrationProvider>(context, listen: false);
    provider.updateAccountSetup(
      email: _emailController.text,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: _emailController,
          label: 'Email Address',
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icons.email,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!value.contains('@')) {
              return 'Please enter a valid email';
            }
            return null;
          },
          onChanged: (_) => _updateProvider(),
        ),
        
        const SizedBox(height: 16),
        
        CustomTextField(
          controller: _passwordController,
          label: 'Password',
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
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
          onChanged: (_) => _updateProvider(),
        ),
        
        const SizedBox(height: 16),
        
        CustomTextField(
          controller: _confirmPasswordController,
          label: 'Confirm Password',
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
            borderRadius: BorderRadius.circular(8),
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
              const SizedBox(height: 8),
              _buildPasswordRequirement(
                'At least 6 characters long',
                _passwordController.text.length >= 6,
              ),
              _buildPasswordRequirement(
                'Contains at least one letter',
                _passwordController.text.contains(RegExp(r'[a-zA-Z]')),
              ),
              _buildPasswordRequirement(
                'Passwords match',
                _passwordController.text == _confirmPasswordController.text && 
                _confirmPasswordController.text.isNotEmpty,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordRequirement(String requirement, bool isMet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.circle_outlined,
            size: 16,
            color: isMet ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(
            requirement,
            style: TextStyle(
              fontSize: 12,
              color: isMet ? Colors.green : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}