import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comments_assignment/view_models/auth_view_model.dart';
import 'package:comments_assignment/widgets/custom_text_field.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F9FD),
      appBar: AppBar(
        backgroundColor: const Color(0xffF5F9FD),
        title: const Text(
          'Comments',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Color(0xff0C54BE),
          ),
        ),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 160.0),
                      child: Column(
                        children: [
                          CustomTextField(
                            hintText: 'Name',
                            onChanged: (value) => viewModel.name = value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10.0),
                          CustomTextField(
                            hintText: 'Email',
                            onChanged: (value) => viewModel.email = value,
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
                          ),
                          const SizedBox(height: 10.0),
                          CustomTextField(
                            hintText: 'Password',
                            onChanged: (value) => viewModel.password = value,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password.';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters long.';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              viewModel.signUp(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff0C54BE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 90.0, vertical: 15.0),
                          ),
                          child: const Text(
                            'Signup',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Already have an account?',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              const TextSpan(text: ' '),
                              TextSpan(
                                text: 'Login',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xff0C54BE),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      Navigator.pushReplacementNamed(
                                          context, '/signin'),
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
