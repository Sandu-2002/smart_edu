class AppUser {
  final String uid;
  final String email;
  final String role;
  final String fullName;
  final bool isActive;

  AppUser({
    required this.uid,
    required this.email,
    required this.role,
    required this.fullName,
    required this.isActive,
  });

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? '',
      fullName: map['fullName'] ?? '',
      isActive: map['isActive'] ?? true,
    );
  }
}
