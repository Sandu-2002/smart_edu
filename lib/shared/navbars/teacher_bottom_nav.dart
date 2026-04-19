import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../routes/route_names.dart';

class TeacherBottomNav extends StatelessWidget {
  final int currentIndex;
  const TeacherBottomNav({super.key, required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(RouteNames.teacherDashboard);
        break;
      case 1:
        context.go(RouteNames.teacherResults);
        break;
      case 2:
        context.go(RouteNames.teacherChat);
        break;
      case 3:
        context.go(RouteNames.teacherProfile);
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
            icon: Icon(Icons.edit_note_outlined), label: 'Results'),
        NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
        NavigationDestination(
            icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
    );
  }
}
