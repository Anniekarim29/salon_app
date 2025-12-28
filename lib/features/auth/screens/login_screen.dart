import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:salon_booking_app/core/theme/app_theme.dart';
import 'package:salon_booking_app/features/home/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               FadeInDown(
                 duration: const Duration(milliseconds: 800),
                 child: Text(
                  "Welcome Back",
                  textAlign: TextAlign.center,
                  style: AppTheme.lightTheme.textTheme.displayLarge?.copyWith(
                    color: AppTheme.primaryColor,
                  ),
                           ),
               ),
              const SizedBox(height: 10),
               FadeInDown(
                 delay: const Duration(milliseconds: 200),
                 child: Text(
                  "Login to continue booking your favorite services.",
                  textAlign: TextAlign.center,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                           ),
               ),
              const SizedBox(height: 60),
               FadeInUp(
                 delay: const Duration(milliseconds: 400),
                 child: _buildTextField(
                  label: "Email Address",
                  icon: Icons.email_outlined,
                           ),
               ),
              const SizedBox(height: 20),
               FadeInUp(
                 delay: const Duration(milliseconds: 600),
                 child: _buildTextField(
                  label: "Password",
                  icon: Icons.lock_outline,
                  isObscure: true,
                           ),
               ),
              const SizedBox(height: 10),
               FadeInUp(
                 delay: const Duration(milliseconds: 700),
                 child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                           ),
               ),
              const SizedBox(height: 40),
              FadeInUp(
                delay: const Duration(milliseconds: 800),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  child: const Text("LOGIN"),
                ),
              ),
              const SizedBox(height: 30),
               FadeInUp(
                 delay: const Duration(milliseconds: 1000),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: AppTheme.lightTheme.textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                           ),
               ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    bool isObscure = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        obscureText: isObscure,
        style: AppTheme.lightTheme.textTheme.bodyLarge,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[600]),
          prefixIcon: Icon(icon, color: AppTheme.primaryColor),
          filled: true,
          fillColor: Colors.transparent, // Use container color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: AppTheme.primaryColor, width: 1.5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        ),
      ),
    );
  }
}
