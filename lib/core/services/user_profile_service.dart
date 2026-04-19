import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getCurrentUserProfileStream() {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('No authenticated user found');
    }

    return _firestore.collection('users').doc(user.uid).snapshots();
  }
}
