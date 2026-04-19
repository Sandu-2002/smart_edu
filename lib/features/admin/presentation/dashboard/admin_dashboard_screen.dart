import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_edu/core/services/auth_service.dart';
import 'package:smart_edu/routes/route_names.dart';
import 'package:smart_edu/shared/widgets/custom_button.dart';
import '../../widgets/admin_sidebar.dart';
import '../../widgets/admin_stat_card.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: Row(
        children: [
          const AdminSidebar(selectedRoute: RouteNames.adminDashboard),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Admin Dashboard',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        child: CustomButton(
                          text: 'Logout',
                          onPressed: () async {
                            await AuthService().signOut();
                            if (context.mounted) {
                              context.go(RouteNames.login);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      children: const [
                        AdminStatCard(
                          title: 'Total Students',
                          value: '120',
                          icon: Icons.school_outlined,
                        ),
                        AdminStatCard(
                          title: 'Total Parents',
                          value: '98',
                          icon: Icons.people_outline,
                        ),
                        AdminStatCard(
                          title: 'Total Teachers',
                          value: '18',
                          icon: Icons.person_outline,
                        ),
                        AdminStatCard(
                          title: 'Courses',
                          value: '12',
                          icon: Icons.menu_book_outlined,
                        ),
                        AdminStatCard(
                          title: 'Notices',
                          value: '08',
                          icon: Icons.notifications_outlined,
                        ),
                        AdminStatCard(
                          title: 'Materials',
                          value: '34',
                          icon: Icons.folder_outlined,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
