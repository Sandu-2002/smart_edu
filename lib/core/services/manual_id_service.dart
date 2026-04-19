import 'package:cloud_firestore/cloud_firestore.dart';

class ManualIdService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> generateId(String role) async {
    final year = DateTime.now().year;

    String prefix;
    String counterKey;

    switch (role) {
      case 'student':
        prefix = 'STU';
        counterKey = 'student_$year';
        break;
      case 'parent':
        prefix = 'PAR';
        counterKey = 'parent_$year';
        break;
      case 'teacher':
        prefix = 'TEA';
        counterKey = 'teacher_$year';
        break;
      default:
        throw Exception('Invalid role');
    }

    final counterRef = _firestore.collection('manual_counters').doc(counterKey);

    final nextNumber = await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(counterRef);
      int current = 0;

      if (snapshot.exists) {
        current = (snapshot.data()?['lastNumber'] ?? 0) as int;
      }

      final updated = current + 1;
      transaction.set(
          counterRef, {'lastNumber': updated}, SetOptions(merge: true));
      return updated;
    });

    final padded = nextNumber.toString().padLeft(4, '0');
    return '$prefix-$year-$padded';
  }
}
