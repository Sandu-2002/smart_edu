import 'package:flutter/material.dart';
import '../../../../../shared/navbars/teacher_bottom_nav.dart';

class TeacherChatScreen extends StatelessWidget {
  const TeacherChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat Parent')),
      body: const Center(
        child: Text('Teacher chat screen'),
      ),
      bottomNavigationBar: const TeacherBottomNav(currentIndex: 2),
    );
  }
}
