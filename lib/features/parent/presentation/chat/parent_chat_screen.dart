import 'package:flutter/material.dart';
import '../../../../../shared/navbars/parent_bottom_nav.dart';

class ParentChatScreen extends StatelessWidget {
  const ParentChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Message to Teacher')),
      body: const Center(
        child: Text('Parent chat screen'),
      ),
      bottomNavigationBar: const ParentBottomNav(currentIndex: 2),
    );
  }
}
