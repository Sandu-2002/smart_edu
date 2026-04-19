import 'package:flutter/material.dart';
import '../../../../../shared/navbars/teacher_bottom_nav.dart';

class TeacherResultsScreen extends StatelessWidget {
  const TeacherResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Teacher Results')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(child: ListTile(title: Text('Add ICT Marks'))),
          Card(child: ListTile(title: Text('Add Maths Marks'))),
        ],
      ),
      bottomNavigationBar: const TeacherBottomNav(currentIndex: 1),
    );
  }
}
