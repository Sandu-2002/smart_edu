import 'package:go_router/go_router.dart';
import '../features/admin/presentation/dashboard/admin_dashboard_screen.dart';
import '../features/admin/presentation/login/admin_login_screen.dart';
import '../features/admin/presentation/parents/admin_parents_screen.dart';
import '../features/admin/presentation/students/admin_students_screen.dart';
import '../features/admin/presentation/teachers/admin_teachers_screen.dart';
import '../features/auth/presentation/forgot_password_screen.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/parent/presentation/chat/parent_chat_screen.dart';
import '../features/parent/presentation/dashboard/parent_dashboard_screen.dart';
import '../features/parent/presentation/profile/parent_profile_screen.dart';
import '../features/parent/presentation/results/parent_results_screen.dart';
import '../features/splash/presentation/splash_screen.dart';
import '../features/student/presentation/courses/student_courses_screen.dart';
import '../features/student/presentation/dashboard/student_dashboard_screen.dart';
import '../features/student/presentation/profile/student_profile_screen.dart';
import '../features/student/presentation/timetable/student_timetable_screen.dart';
import '../features/teacher/presentation/chat/teacher_chat_screen.dart';
import '../features/teacher/presentation/dashboard/teacher_dashboard_screen.dart';
import '../features/teacher/presentation/profile/teacher_profile_screen.dart';
import '../features/teacher/presentation/results/teacher_results_screen.dart';
import 'route_names.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.splash,
  routes: [
    GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const SplashScreen()),
    GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginScreen()),
    GoRoute(
        path: RouteNames.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen()),
    GoRoute(
        path: RouteNames.studentDashboard,
        builder: (context, state) => const StudentDashboardScreen()),
    GoRoute(
        path: RouteNames.studentCourses,
        builder: (context, state) => const StudentCoursesScreen()),
    GoRoute(
        path: RouteNames.studentTimetable,
        builder: (context, state) => const StudentTimetableScreen()),
    GoRoute(
        path: RouteNames.studentProfile,
        builder: (context, state) => const StudentProfileScreen()),
    GoRoute(
        path: RouteNames.parentDashboard,
        builder: (context, state) => const ParentDashboardScreen()),
    GoRoute(
        path: RouteNames.parentResults,
        builder: (context, state) => const ParentResultsScreen()),
    GoRoute(
        path: RouteNames.parentChat,
        builder: (context, state) => const ParentChatScreen()),
    GoRoute(
        path: RouteNames.parentProfile,
        builder: (context, state) => const ParentProfileScreen()),
    GoRoute(
        path: RouteNames.teacherDashboard,
        builder: (context, state) => const TeacherDashboardScreen()),
    GoRoute(
        path: RouteNames.teacherResults,
        builder: (context, state) => const TeacherResultsScreen()),
    GoRoute(
        path: RouteNames.teacherChat,
        builder: (context, state) => const TeacherChatScreen()),
    GoRoute(
        path: RouteNames.teacherProfile,
        builder: (context, state) => const TeacherProfileScreen()),
    GoRoute(
        path: RouteNames.adminLogin,
        builder: (context, state) => const AdminLoginScreen()),
    GoRoute(
        path: RouteNames.adminDashboard,
        builder: (context, state) => const AdminDashboardScreen()),
    GoRoute(
        path: RouteNames.adminStudents,
        builder: (context, state) => const AdminStudentsScreen()),
    GoRoute(
        path: RouteNames.adminParents,
        builder: (context, state) => const AdminParentsScreen()),
    GoRoute(
        path: RouteNames.adminTeachers,
        builder: (context, state) => const AdminTeachersScreen()),
  ],
);
