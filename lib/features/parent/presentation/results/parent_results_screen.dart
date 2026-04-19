import 'package:flutter/material.dart';
import '../../../../../shared/navbars/parent_bottom_nav.dart';

class ParentResultsScreen extends StatelessWidget {
  const ParentResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Results')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(child: ListTile(title: Text('ICT'), trailing: Text('85'))),
          Card(child: ListTile(title: Text('Maths'), trailing: Text('78'))),
        ],
      ),
      bottomNavigationBar: const ParentBottomNav(currentIndex: 1),
    );
  }
}
