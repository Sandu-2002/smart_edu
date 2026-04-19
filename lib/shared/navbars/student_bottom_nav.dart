import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../routes/route_names.dart';

class StudentBottomNav extends StatelessWidget {
  final int currentIndex;
  const StudentBottomNav({super.key, required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(RouteNames.studentDashboard);
        break;
      case 1:
        context.go(RouteNames.studentCourses);
        break;
      case 2:
        context.go(RouteNames.studentTimetable);
        break;
      case 3:
        context.go(RouteNames.studentProfile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: (index) => _onTap(context, index),
      destinations: const [
        NavigationDestination(
            icon: Icon(Icons.dashboard_outlined), label: 'Home'),
        NavigationDestination(
            icon: Icon(Icons.menu_book_outlined), label: 'Courses'),
        NavigationDestination(
            icon: Icon(Icons.schedule_outlined), label: 'Timetable'),
        NavigationDestination(
            icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
    );
  }
}
