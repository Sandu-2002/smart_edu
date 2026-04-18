import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:smart_edu/core/constants/app_assets.dart';
import 'package:smart_edu/core/services/auth_service.dart';
import 'package:smart_edu/core/services/role_redirect_service.dart';
import 'package:smart_edu/routes/route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService _authService = AuthService();
  final RoleRedirectService _roleRedirectService = RoleRedirectService();

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  Future<void> _checkUser() async {
    await Future.delayed(const Duration(seconds: 2));

    final user = _authService.currentUser;

    if (!mounted) return;

    if (user == null) {
      context.go(RouteNames.login);
      return;
    }

    final route = await _roleRedirectService.getUserRoute(user.uid);

    if (!mounted) return;
    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.appLogo,
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 16),
            const Text(
              'Smart Edu',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
