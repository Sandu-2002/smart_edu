import 'package:flutter/material.dart';
import '../../../../core/services/admin_firestore_service.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../routes/route_names.dart';
import '../../widgets/admin_sidebar.dart';
import '../../widgets/admin_user_form_card.dart';
import '../../widgets/admin_user_list_card.dart';
import '../../../../core/services/manual_id_service.dart';

class AdminTeachersScreen extends StatefulWidget {
  const AdminTeachersScreen({super.key});

  @override
  State<AdminTeachersScreen> createState() => _AdminTeachersScreenState();
}

class _AdminTeachersScreenState extends State<AdminTeachersScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final ManualIdService _idService = ManualIdService();
  final AdminFirestoreService _service = AdminFirestoreService();

  bool isLoading = false;

  @override
  Future<void> _saveTeacher() async {
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final subject = _subjectController.text.trim();

    if (fullName.isEmpty || email.isEmpty || subject.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fill all teacher fields')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final teacherId = await _idService.generateId('teacher');

      await _service.addTeacher(
        teacherId: teacherId,
        fullName: fullName,
        email: email,
        subject: subject,
      );

      _fullNameController.clear();
      _emailController.clear();
      _subjectController.clear();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Teacher saved: $teacherId')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: Row(
        children: [
          const AdminSidebar(selectedRoute: RouteNames.adminTeachers),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Manage Teachers',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AdminUserFormCard(
                          title: 'Add Teacher',
                          children: [
                            CustomTextField(
                              controller: _fullNameController,
                              hintText: 'Full Name',
                            ),
                            const SizedBox(height: 12),
                            CustomTextField(
                              controller: _emailController,
                              hintText: 'Email',
                            ),
                            const SizedBox(height: 12),
                            CustomTextField(
                              controller: _subjectController,
                              hintText: 'Subject',
                            ),
                            const SizedBox(height: 16),
                            CustomButton(
                              text: isLoading ? 'Saving...' : 'Save Teacher',
                              onPressed: isLoading ? () {} : _saveTeacher,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: AdminUserListCard(
                          title: 'Teacher Records',
                          child: StreamBuilder(
                            stream: _service.getTeachers(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return const Text('No teachers added yet');
                              }

                              final docs = snapshot.data!.docs;

                              return ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: docs.length,
                                separatorBuilder: (_, __) => const Divider(),
                                itemBuilder: (context, index) {
                                  final data = docs[index].data();

                                  return ListTile(
                                    leading: const CircleAvatar(
                                      child: Icon(Icons.person),
                                    ),
                                    title: Text(data['fullName'] ?? ''),
                                    subtitle: Text(
                                      '${data['email'] ?? ''} | ${data['subject'] ?? ''}',
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
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
