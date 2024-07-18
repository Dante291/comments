import 'package:comments_assignment/services/auth_service.dart';
import 'package:comments_assignment/view_models/auth_view_model.dart';
import 'package:comments_assignment/view_models/comments_view_model.dart';
import 'package:comments_assignment/views/comments.dart';
import 'package:comments_assignment/views/sign_In.dart';
import 'package:comments_assignment/views/sign_Up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationViewModel()),
        ChangeNotifierProvider(create: (_) => CommentsViewModel()),
      ],
      child: MaterialApp(
        routes: {
          '/signup': (context) => const SignUpView(),
          '/comments': (context) => const CommentsView(),
          '/signin': (context) => const SignInView()
        },
        debugShowCheckedModeBanner: false,
        title: 'Comments App',
        theme: ThemeData(
          fontFamily: 'Poppins',
          primarySwatch: Colors.blue,
        ),
        home: FirebaseAuthService.isLoggedIn()
            ? const CommentsView()
            : const SignUpView(),
      ),
    );
  }
}
