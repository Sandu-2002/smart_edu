import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_edu/routes/route_names.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Future<String> signInAndGetRoute({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final lowerEmail = email.toLowerCase();

    if (lowerEmail.contains('student')) {
      return RouteNames.studentDashboard;
    } else if (lowerEmail.contains('parent')) {
      return RouteNames.parentDashboard;
    } else if (lowerEmail.contains('teacher')) {
      return RouteNames.teacherDashboard;
    } else if (lowerEmail.contains('admin')) {
      return RouteNames.adminDashboard;
    } else {
      return RouteNames.login;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
