import 'package:flutter/material.dart';
import '../../../../core/services/admin_firestore_service.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../../../../routes/route_names.dart';
import '../../widgets/admin_sidebar.dart';
import '../../widgets/admin_user_form_card.dart';
import '../../widgets/admin_user_list_card.dart';
import '../../../../core/services/manual_id_service.dart';

class AdminStudentsScreen extends StatefulWidget {
  const AdminStudentsScreen({super.key});

  @override
  State<AdminStudentsScreen> createState() => _AdminStudentsScreenState();
}

class _AdminStudentsScreenState extends State<AdminStudentsScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _gradeController = TextEditingController();
  final _classController = TextEditingController();

  final AdminFirestoreService _service = AdminFirestoreService();
  final ManualIdService _idService = ManualIdService();

  bool isLoading = false;

  @override
  Future<void> _saveStudent() async {
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final grade = _gradeController.text.trim();
    final className = _classController.text.trim();

    if (fullName.isEmpty ||
        email.isEmpty ||
        grade.isEmpty ||
        className.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fill all student fields')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final studentId = await _idService.generateId('student');

      await _service.addStudent(
        studentId: studentId,
        fullName: fullName,
        email: email,
        grade: grade,
        className: className,
      );

      _fullNameController.clear();
      _emailController.clear();
      _gradeController.clear();
      _classController.clear();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Student saved: $studentId')),
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
          const AdminSidebar(selectedRoute: RouteNames.adminStudents),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Manage Students',
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
                          title: 'Add Student',
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
                              controller: _gradeController,
                              hintText: 'Grade',
                            ),
                            const SizedBox(height: 12),
                            CustomTextField(
                              controller: _classController,
                              hintText: 'Class Name',
                            ),
                            const SizedBox(height: 16),
                            CustomButton(
                              text: isLoading ? 'Saving...' : 'Save Student',
                              onPressed: isLoading ? () {} : _saveStudent,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: AdminUserListCard(
                          title: 'Student Records',
                          child: StreamBuilder(
                            stream: _service.getStudents(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return const Text('No students added yet');
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
                                      child: Icon(Icons.school),
                                    ),
                                    title: Text(data['fullName'] ?? ''),
                                    subtitle: Text(
                                      '${data['email'] ?? ''} | Grade ${data['grade'] ?? ''} | ${data['className'] ?? ''}',
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
