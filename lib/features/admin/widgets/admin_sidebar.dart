import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../routes/route_names.dart';

class AdminSidebar extends StatelessWidget {
  final String selectedRoute;
  const AdminSidebar({super.key, required this.selectedRoute});

  Widget _item(
      BuildContext context, String title, IconData icon, String route) {
    final bool selected = selectedRoute == route;
    return ListTile(
      leading: Icon(icon, color: selected ? Colors.blue : Colors.black87),
      title: Text(
        title,
        style: TextStyle(
          color: selected ? Colors.blue : Colors.black87,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: selected,
      onTap: () => context.go(route),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: Colors.white,
      child: Column(
        children: [
          const DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.school, size: 48),
                SizedBox(height: 12),
                Text(
                  'Smart Edu Admin',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          _item(context, 'Dashboard', Icons.dashboard_outlined,
              RouteNames.adminDashboard),
          _item(context, 'Students', Icons.school_outlined,
              RouteNames.adminStudents),
          _item(context, 'Parents', Icons.people_outline,
              RouteNames.adminParents),
          _item(context, 'Teachers', Icons.person_outline,
              RouteNames.adminTeachers),
        ],
      ),
    );
  }
}
