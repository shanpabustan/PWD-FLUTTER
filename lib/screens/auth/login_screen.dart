import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.login(
      _emailController.text.trim(),
      _passwordController.text,
    );

    setState(() => _isLoading = false);

    if (success) {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/dashboard');
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid credentials')),
        );
      }
    }
  }

  // Helper method to get responsive dimensions
  double getResponsiveDimension(BuildContext context, {
    required double small,
    required double medium,
    required double large,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      return small;
    } else if (screenWidth < 1200) {
      return medium;
    } else {
      return large;
    }
  }

  // Helper method to get responsive padding
  EdgeInsets getResponsivePadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    double horizontal = screenWidth * 0.06; // 6% of screen width
    double vertical = screenHeight * 0.06; // 6% of screen height
    
    // Clamp values to reasonable ranges
    horizontal = horizontal.clamp(16.0, 48.0);
    vertical = vertical.clamp(24.0, 80.0);
    
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 600;
    final bool isMediumScreen = size.width >= 600 && size.width < 1200;
    final bool isLandscape = size.width > size.height;

    // Define the color palette
    const primaryBlue = Color(0xFF007bff);
    const accentRed = Color(0xFFdc3545);
    const lightBlue = Color(0xFFe9f1ff);

    // Responsive dimensions
    final logoHeight = getResponsiveDimension(
      context,
      small: size.height * 0.12,
      medium: size.height * 0.15,
      large: size.height * 0.18,
    );

    final titleFontSize = getResponsiveDimension(
      context,
      small: 24.0,
      medium: 28.0,
      large: 32.0,
    );

    final subtitleFontSize = getResponsiveDimension(
      context,
      small: 14.0,
      medium: 16.0,
      large: 18.0,
    );

    final formSpacing = getResponsiveDimension(
      context,
      small: 16.0,
      medium: 20.0,
      large: 24.0,
    );

    // Container constraints for different screen sizes
    final maxWidth = isSmallScreen ? double.infinity : 
                     isMediumScreen ? 500.0 : 600.0;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [lightBlue, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: SingleChildScrollView(
                padding: getResponsivePadding(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Add top spacing for better centering on larger screens
                    if (!isSmallScreen && !isLandscape) 
                      SizedBox(height: size.height * 0.05),
                    
                    // Logo Section
                    Center(
                      child: Image.asset(
                        'assets/doh.png',
                        height: logoHeight,
                        fit: BoxFit.contain,
                      ),
                    ),
                    
                    SizedBox(height: formSpacing),
                    
                    // Title with responsive font size
                    Text(
                      'PWD Monitoring System',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: primaryBlue,
                        fontSize: titleFontSize,
                      ),
                    ),
                    
                    SizedBox(height: formSpacing * 0.5),
                    
                    // Subtitle with responsive font size
                    Text(
                      'Sign in to access your digital PWD ID and services.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.black54,
                        fontSize: subtitleFontSize,
                      ),
                    ),
                    
                    SizedBox(height: formSpacing * 2),
                    
                    // Login Form
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Email Field
                          CustomTextField(
                            controller: _emailController,
                            label: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: Icons.email_outlined,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          
                          SizedBox(height: formSpacing),
                          
                          // Password Field
                          CustomTextField(
                            controller: _passwordController,
                            label: 'Password',
                            obscureText: _obscurePassword,
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() => _obscurePassword = !_obscurePassword);
                              },
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          
                          SizedBox(height: formSpacing * 1.5),
                          
                          // Login Button with responsive height
                          SizedBox(
                            width: double.infinity,
                            height: getResponsiveDimension(
                              context,
                              small: 48.0,
                              medium: 52.0,
                              large: 56.0,
                            ),
                            child: CustomButton(
                              onPressed: _isLoading ? null : _login,
                              isLoading: _isLoading,
                              color: accentRed,
                              child: Text(
                                'Login',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: getResponsiveDimension(
                                    context,
                                    small: 16.0,
                                    medium: 17.0,
                                    large: 18.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: formSpacing * 1.5),
                    
                    // Register Link
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.black54,
                            fontSize: getResponsiveDimension(
                              context,
                              small: 14.0,
                              medium: 15.0,
                              large: 16.0,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/register');
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Register',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: primaryBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: getResponsiveDimension(
                                context,
                                small: 14.0,
                                medium: 15.0,
                                large: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // Add bottom spacing for better centering on larger screens
                    if (!isSmallScreen && !isLandscape) 
                      SizedBox(height: size.height * 0.05),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}