import 'package:flutter/material.dart';
import '../../../../../shared/navbars/student_bottom_nav.dart';

class StudentCoursesScreen extends StatelessWidget {
  const StudentCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Courses')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
              title: Text('ICT Grade 10'), subtitle: Text('Course Module 1')),
          ListTile(
              title: Text('ICT Grade 11'), subtitle: Text('Course Module 2')),
        ],
      ),
      bottomNavigationBar: const StudentBottomNav(currentIndex: 1),
    );
  }
}
