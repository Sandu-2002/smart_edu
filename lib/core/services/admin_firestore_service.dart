import 'package:cloud_firestore/cloud_firestore.dart';

class AdminFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addStudent({
    required String studentId,
    required String fullName,
    required String email,
    required String grade,
    required String className,
  }) async {
    await _firestore.collection('students').doc(studentId).set({
      'studentId': studentId,
      'fullName': fullName,
      'email': email,
      'grade': grade,
      'className': className,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> addParent({
    required String parentId,
    required String fullName,
    required String email,
    required String phone,
  }) async {
    await _firestore.collection('parents').doc(parentId).set({
      'parentId': parentId,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> addTeacher({
    required String teacherId,
    required String fullName,
    required String email,
    required String subject,
  }) async {
    await _firestore.collection('teachers').doc(teacherId).set({
      'teacherId': teacherId,
      'fullName': fullName,
      'email': email,
      'subject': subject,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getStudents() {
    return _firestore
        .collection('students')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getParents() {
    return _firestore
        .collection('parents')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getTeachers() {
    return _firestore
        .collection('teachers')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
