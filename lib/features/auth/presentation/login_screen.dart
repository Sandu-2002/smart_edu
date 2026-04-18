import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_edu/core/services/auth_service.dart';
import 'package:smart_edu/routes/route_names.dart';
import 'package:smart_edu/shared/widgets/custom_button.dart';
import 'package:smart_edu/shared/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter email and password')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final route = await _authService.signInAndGetRoute(
        email: email,
        password: password,
      );

      if (!mounted) return;
      context.go(route);
    } on FirebaseAuthException catch (e) {
      String message = 'Login failed';

      if (e.code == 'user-not-found') {
        message = 'No user found for that email';
      } else if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        message = 'Invalid email or password';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email format';
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
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
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomTextField(
              controller: emailController,
              hintText: 'Email',
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: isLoading ? 'Loading...' : 'Login',
              onPressed: isLoading ? () {} : handleLogin,
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => context.go(RouteNames.forgotPassword),
              child: const Text('Forgot Password?'),
            ),
          ],
        ),
      ),
    );
  }
}
