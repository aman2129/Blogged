import 'package:blog_app/views/blog_screens/animations/route_animation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

import 'error_dialog_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  late final TextEditingController _email;
  late final TextEditingController _password;
  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.only(top: 100, left: 10, right: 10),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Form(
            key: _key,
            child: Column(
              children: [
                Text(
                  'Blogged',
                  style: GoogleFonts.aleo(
                    fontSize: 50,
                    color: Colors.cyan,
                  )
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Text(
                  'Login',
                  style: GoogleFonts.aleo(
                    fontSize: 40,
                    color: Colors.cyan,
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white70,
                    filled: true,
                    hintText: 'Enter valid email',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.lightBlueAccent,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  controller: _email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email required';
                    }
                    return null;
                  },
                  enableSuggestions: true,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: _password,
                  decoration: InputDecoration(
                    fillColor: Colors.white70,
                    filled: true,
                    hintText: 'Enter password',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.lightBlueAccent,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password required';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 55,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        try {
                          setState(() {
                            isLoading = true;
                          });
                          final String email = _email.text;
                          final String password = _password.text;
                          await firebaseAuth.signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          await Future.delayed(const Duration(seconds: 2), () {
                            setState(() {
                              isLoading = false;
                            });
                          });
                          final user = FirebaseAuth.instance.currentUser;
                          if (user!.emailVerified) {
                            await Navigator.of(context).pushReplacement(RouteAnimation().createBlogViewRoute());
                          } else {
                            await user.sendEmailVerification();
                            await Navigator.of(context).pushNamedAndRemoveUntil(
                              '/VerifyEmailView/',
                              (route) => false,
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            await showErrorDialog(context, 'User not Found');
                          } else if (e.code == 'wrong-password') {
                            await showErrorDialog(context, 'Wrong password');
                          }
                        }
                      }
                    },
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text('Login'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/RegisterScreen/',
                      (route) => false,
                    );
                  },
                  child: const Text('Not registered yet? Register here'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
