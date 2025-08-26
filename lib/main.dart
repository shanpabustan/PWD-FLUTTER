import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/registration_stepper.dart';
import 'screens/dashboard/dashboard_container.dart';
import 'providers/auth_provider.dart';
import 'providers/registration_provider.dart';
import 'providers/user_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Define your PWD DSWD color palette
  static const Color primaryBlue = Color(0xFF007bff);
  static const Color accentRed = Color(0xFFdc3545);
  static const Color lightBlue = Color(0xFFe9f1ff);
  static const Color secondaryColor = Color(0xFF6c757d); // A neutral grey

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => RegistrationProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'PWD Digital ID',
        theme: ThemeData(
          useMaterial3: true,
          // Use the ColorScheme to define a consistent palette
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: primaryBlue,
            onPrimary: Colors.white,
            secondary: secondaryColor,
            onSecondary: Colors.white,
            error: accentRed,
            onError: Colors.white,
            onBackground: Colors.black,
            surface: Colors.white,
            onSurface: Colors.black,
          ),
          // Set button themes for global consistency
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: primaryBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
          // Set text field themes
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.grey, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: primaryBlue, width: 2.0),
            ),
            labelStyle: const TextStyle(color: Colors.black54),
            hintStyle: const TextStyle(color: Colors.grey),
          ),
        ),
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            if (authProvider.isLoggedIn) {
              return const DashboardContainer();
            }
            return const LoginScreen();
          },
        ),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegistrationStepper(),
          '/dashboard': (context) => const DashboardContainer(),
        },
      ),
    );
  }
}