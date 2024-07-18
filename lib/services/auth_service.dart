import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  static final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  static auth.User? get currentUser => _auth.currentUser;

  static Future<void> signInWithEmail(
      BuildContext context, String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/comments');
      }
    } on auth.FirebaseAuthException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  static Future<void> signUpWithEmail(
      BuildContext context, String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Account created successfully!"),
            backgroundColor: Color(0xff0C54BE),
          ),
        );
        await Future.delayed(const Duration(seconds: 1));
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/signin');
        }
      }
    } on auth.FirebaseAuthException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign Up Failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  static Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  static bool isLoggedIn() {
    return _auth.currentUser != null;
  }
}
