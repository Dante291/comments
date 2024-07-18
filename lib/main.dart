import 'package:comments_assignment/services/auth_service.dart';
import 'package:comments_assignment/services/firestore_service.dart';
import 'package:comments_assignment/services/remote_config_service.dart';
import 'package:flutter/material.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseAuthService.initialize();
  await FirestoreService.initialize();
  await FirebaseRemoteConfigService.initialize();

  runApp(const MyApp());
}
