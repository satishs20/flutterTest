import 'package:example/api/firebase_auth.dart';
import 'package:example/ui/components/text_field.dart';
import 'package:example/validators/input_validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import '../../ui/components/button/elevated_button.dart';
import 'firebase_profile.dart';
import 'firebase_sign_up.dart';

Route<void> get quizSignInRoute => MaterialPageRoute(builder: (_) => const SignInPage());

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FirebaseAuthentication _auth = FirebaseAuthentication(Client());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> signIn() async {
    try {
      if (_formKey.currentState?.validate() ?? false) {
        setState(() {
          isLoading = true;
        });
        final userCredential = await _auth.signInWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        );
        setState(() {
          isLoading = false;
        });
        // log(userCredential.toString());
        // print(jsonEncode(userCredential));
        if (userCredential?.email != null) {
          await _auth.saveData(userCredential!);
          await Navigator.push(context, quizProfileRoute);
        }
      }
      // Navigate to profile page or another screen upon successful sign-in
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (kDebugMode) {
        await Fluttertoast.showToast(msg: '$e');
        print('Error: $e');
      }
      // Handle sign-in errors (e.g., invalid email/password, user not found)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In Page'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PTTextField(
                      controller: _emailController,
                      label: 'Email',
                      validator: validateEmail,
                    ),
                    const SizedBox(height: 10),
                    PTTextField(
                      controller: _passwordController,
                      label: 'Password',
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password can't be empty";
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: PTElevatedButton(
                        caption: 'Sign In',
                        onPressed: signIn,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, quizRegisterRoute);
                      },
                      child: const Text("Don't have an account? Register here"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
