import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/route_names.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void handleLogin() {
    final email = emailController.text.trim().toLowerCase();

    if (email.contains('student')) {
      context.go(RouteNames.studentDashboard);
    } else if (email.contains('parent')) {
      context.go(RouteNames.parentDashboard);
    } else if (email.contains('teacher')) {
      context.go(RouteNames.teacherDashboard);
    } else if (email.contains('admin')) {
      context.go(RouteNames.adminDashboard);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Use demo emails with student/parent/teacher/admin'),
        ),
      );
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
              text: 'Login',
              onPressed: handleLogin,
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => context.go(RouteNames.forgotPassword),
              child: const Text('Forgot Password?'),
            ),
            const SizedBox(height: 20),
            const Text('Demo:'),
            const Text('student@gmail.com'),
            const Text('parent@gmail.com'),
            const Text('teacher@gmail.com'),
            const Text('admin@gmail.com'),
          ],
        ),
      ),
    );
  }
}
