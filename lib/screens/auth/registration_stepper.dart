import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/registration_provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/personal_info_step.dart';
import '../../widgets/pwd_details_step.dart';
import '../../widgets/account_setup_step.dart';

class RegistrationStepper extends StatefulWidget {
  const RegistrationStepper({super.key});

  @override
  State<RegistrationStepper> createState() => _RegistrationStepperState();
}

class _RegistrationStepperState extends State<RegistrationStepper> {
  bool _isSubmitting = false;

  Future<void> _submitRegistration() async {
    setState(() => _isSubmitting = true);
    
    final registrationProvider = Provider.of<RegistrationProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    final userData = registrationProvider.getAllData();
    final success = await authProvider.register(userData);
    
    setState(() => _isSubmitting = false);
    
    if (success && mounted) {
      registrationProvider.reset();
      Navigator.of(context).pushReplacementNamed('/dashboard');
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration failed. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      ),
      body: Consumer<RegistrationProvider>(
        builder: (context, provider, _) {
          return Stepper(
            currentStep: provider.currentStep,
            onStepTapped: (step) {
              // Allow tapping to previous steps only
              if (step < provider.currentStep) {
                while (provider.currentStep > step) {
                  provider.previousStep();
                }
              }
            },
            controlsBuilder: (context, details) {
              return Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  children: [
                    if (details.stepIndex == 2)
                      Expanded(
                        child: FilledButton(
                          onPressed: _isSubmitting ? null : _submitRegistration,
                          child: _isSubmitting
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Text('Submit'),
                        ),
                      )
                    else
                      Expanded(
                        child: FilledButton(
                          onPressed: provider.nextStep,
                          child: const Text('Next'),
                        ),
                      ),
                    
                    const SizedBox(width: 12),
                    
                    if (details.stepIndex > 0)
                      OutlinedButton(
                        onPressed: provider.previousStep,
                        child: const Text('Back'),
                      ),
                  ],
                ),
              );
            },
            steps: [
              Step(
                title: const Text('Personal Information'),
                content: const PersonalInfoStep(),
                isActive: provider.currentStep >= 0,
                state: provider.currentStep > 0 ? StepState.complete : StepState.indexed,
              ),
              Step(
                title: const Text('PWD Details'),
                content: const PwdDetailsStep(),
                isActive: provider.currentStep >= 1,
                state: provider.currentStep > 1 ? StepState.complete : 
                       provider.currentStep == 1 ? StepState.indexed : StepState.disabled,
              ),
              Step(
                title: const Text('Account Setup'),
                content: const AccountSetupStep(),
                isActive: provider.currentStep >= 2,
                state: provider.currentStep == 2 ? StepState.indexed : StepState.disabled,
              ),
            ],
          );
        },
      ),
    );
  }
}