import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import '../../api/firebase_auth.dart';
import '../../ui/components/button/elevated_button.dart';
import '../../ui/components/text_field.dart';
import '../../validators/input_validators.dart';
import 'firebase_profile.dart';

Route<void> get quizRegisterRoute => MaterialPageRoute(builder: (_) => const RegisterPage());

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuthentication _auth = FirebaseAuthentication(Client());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _displayController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> _register() async {
    try {
      setState(() {
        isLoading = true;
      });
      final userCredential = await _auth.registerWithEmailAndPassword(
        _emailController.text,
        _displayController.text,
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
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (kDebugMode) {
        await Fluttertoast.showToast(msg: '$e');
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page'),
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
                      controller: _displayController,
                      label: 'Display Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Display name can't be empty";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
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
                        caption: 'Register',
                        onPressed: _register,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
