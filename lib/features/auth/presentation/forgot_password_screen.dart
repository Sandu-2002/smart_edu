import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_edu/core/services/auth_service.dart';
import 'package:smart_edu/shared/widgets/custom_button.dart';
import 'package:smart_edu/shared/widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final AuthService _authService = AuthService();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> resetPassword() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter your email')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      await _authService.sendPasswordResetEmail(email);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent')),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'Failed to send reset email';

      if (e.code == 'invalid-email') {
        message = 'Invalid email format';
      } else if (e.code == 'user-not-found') {
        message = 'No user found for that email';
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomTextField(
              controller: emailController,
              hintText: 'Enter your email',
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: isLoading ? 'Sending...' : 'Send Reset Link',
              onPressed: isLoading ? () {} : resetPassword,
            ),
          ],
        ),
      ),
    );
  }
}
