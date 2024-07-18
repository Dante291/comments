import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> initialize() async {}

  static Future<void> saveUserDetails(User user) async {
    await _firestore.collection('users').doc(user.id).set(user.toJson());
  }

  static Future<User?> getUserDetails(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      return User.fromJson(doc.data()!);
    }
    return null;
  }
}
