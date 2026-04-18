import 'package:cloud_firestore/cloud_firestore.dart';
import '../../routes/route_names.dart';

class RoleRedirectService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> getUserRoute(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();

    if (!doc.exists) {
      return RouteNames.login;
    }

    final data = doc.data() as Map<String, dynamic>;
    final role = data['role'];
    final isActive = data['isActive'] ?? true;

    if (isActive != true) {
      return RouteNames.login;
    }

    switch (role) {
      case 'student':
        return RouteNames.studentDashboard;
      case 'parent':
        return RouteNames.parentDashboard;
      case 'teacher':
        return RouteNames.teacherDashboard;
      case 'admin':
        return RouteNames.adminDashboard;
      default:
        return RouteNames.login;
    }
  }
}
