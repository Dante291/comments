import 'package:comments_assignment/view_models/auth_view_model.dart';
import 'package:comments_assignment/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F9FD),
      appBar: AppBar(
        title: const Text(
          'Comments',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xff0C54BE)),
        ),
        backgroundColor: const Color(0xffF5F9FD),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<AuthenticationViewModel>(
            builder: (context, viewModel, child) {
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 200),
                      child: Column(
                        children: [
                          CustomTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email.';
                              }
                              if (!value.contains('@')) {
                                return 'Please enter your email.';
                              }
                              if (!value.contains('.') ||
                                  value.indexOf('.') < value.indexOf('@')) {
                                return 'Please enter your email.';
                              }
                              return null;
                            },
                            hintText: 'Email',
                            onChanged: (value) => viewModel.email = value,
                          ),
                          const SizedBox(height: 15.0),
                          CustomTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password.';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters long.';
                              }
                              return null;
                            },
                            hintText: 'Password',
                            onChanged: (value) => viewModel.password = value,
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              viewModel.signIn(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff0C54BE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 100.0, vertical: 15.0),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'New here?',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              const TextSpan(
                                text: ' ',
                              ),
                              TextSpan(
                                text: 'Signup',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xff0C54BE),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      Navigator.pushReplacementNamed(
                                          context, '/signup'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
