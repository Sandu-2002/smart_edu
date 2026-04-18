import 'package:go_router/go_router.dart';

import '../features/admin/presentation/dashboard/admin_dashboard_screen.dart';
import '../features/auth/presentation/forgot_password_screen.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/parent/presentation/dashboard/parent_dashboard_screen.dart';
import '../features/splash/presentation/splash_screen.dart';
import '../features/student/presentation/dashboard/student_dashboard_screen.dart';
import '../features/teacher/presentation/dashboard/teacher_dashboard_screen.dart';
import 'route_names.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.splash,
  routes: [
    GoRoute(
      path: RouteNames.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RouteNames.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RouteNames.forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: RouteNames.studentDashboard,
      builder: (context, state) => const StudentDashboardScreen(),
    ),
    GoRoute(
      path: RouteNames.parentDashboard,
      builder: (context, state) => const ParentDashboardScreen(),
    ),
    GoRoute(
      path: RouteNames.teacherDashboard,
      builder: (context, state) => const TeacherDashboardScreen(),
    ),
    GoRoute(
      path: RouteNames.adminDashboard,
      builder: (context, state) => const AdminDashboardScreen(),
    ),
  ],
);
