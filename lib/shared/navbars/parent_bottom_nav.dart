import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../routes/route_names.dart';

class ParentBottomNav extends StatelessWidget {
  final int currentIndex;
  const ParentBottomNav({super.key, required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(RouteNames.parentDashboard);
        break;
      case 1:
        context.go(RouteNames.parentResults);
        break;
      case 2:
        context.go(RouteNames.parentChat);
        break;
      case 3:
        context.go(RouteNames.parentProfile);
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
            icon: Icon(Icons.assessment_outlined), label: 'Result'),
        NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
        NavigationDestination(
            icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
    );
  }
}
