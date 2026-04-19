import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/services/auth_service.dart';
import '../../../../../core/services/user_profile_service.dart';
import '../../../../../routes/route_names.dart';
import '../../../../../shared/navbars/student_bottom_nav.dart';
import '../../../../../shared/widgets/custom_button.dart';
import '../../../../../shared/widgets/profile_info_tile.dart';

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileService = UserProfileService();

    return Scaffold(
      appBar: AppBar(title: const Text('Student Profile')),
      body: StreamBuilder(
        stream: userProfileService.getCurrentUserProfileStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Profile not found'));
          }

          final data = snapshot.data!.data()!;
          final fullName = data['fullName'] ?? '';
          final email = data['email'] ?? '';
          final role = data['role'] ?? '';
          final customId = data['customId'] ?? '';

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 42,
                    child: Icon(Icons.person, size: 42),
                  ),
                ),
                const SizedBox(height: 20),
                ProfileInfoTile(label: 'Full Name', value: fullName),
                ProfileInfoTile(label: 'Email', value: email),
                ProfileInfoTile(label: 'Role', value: role),
                ProfileInfoTile(label: 'Student ID', value: customId),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Logout',
                  onPressed: () async {
                    await AuthService().signOut();
                    if (context.mounted) context.go(RouteNames.login);
                  },
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const StudentBottomNav(currentIndex: 3),
    );
  }
}
