import 'package:flutter/material.dart';
import '../../../../../shared/navbars/student_bottom_nav.dart';

class StudentTimetableScreen extends StatelessWidget {
  const StudentTimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Timetable')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(
              child: ListTile(
                  title: Text('Monday'), subtitle: Text('ICT - 8.00 AM'))),
          Card(
              child: ListTile(
                  title: Text('Tuesday'), subtitle: Text('Maths - 9.00 AM'))),
        ],
      ),
      bottomNavigationBar: const StudentBottomNav(currentIndex: 2),
    );
  }
}
