import 'package:comments_assignment/services/auth_service.dart';
import 'package:comments_assignment/services/firestore_service.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class AuthenticationViewModel extends ChangeNotifier {
  String email = '';
  String password = '';
  String name = '';

  Future<void> signUp(BuildContext context) async {
    await FirebaseAuthService.signUpWithEmail(context, email, password);
    final user = User(
      id: FirebaseAuthService.currentUser!.uid,
      name: name,
      email: email,
    );
    await FirestoreService.saveUserDetails(user);
    notifyListeners();
  }

  Future<void> signIn(BuildContext context) async {
    await FirebaseAuthService.signInWithEmail(
      context,
      email,
      password,
    );
    notifyListeners();
  }

  Future<void> signOut(BuildContext context) async {
    await FirebaseAuthService.signOut(context);
    notifyListeners();
  }
}
