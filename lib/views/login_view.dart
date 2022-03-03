import 'dart:developer' as devtools show log;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/views/register_view.dart';

import '../firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

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
      body: SafeArea(
        child: FutureBuilder(
            future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
            ),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        const CircleAvatar(
                          radius: 95,
                          backgroundImage: AssetImage(
                            'assets/img_1.png',
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'AFC Commercial Bank',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          '(Account Opening App)',
                          style: TextStyle(color: Colors.green),
                        ),
                        const SizedBox(height: 25),
                        TextField(
                          controller: _email,
                          enableSuggestions: false,
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            hintText: "Enter Email Here",
                          ),
                        ),
                        TextField(
                          controller: _password,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.key),
                            hintText: "Enter Password Here",
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () async {
                            final email = _email.text;
                            final password = _password.text;
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: email, password: password);
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/notes/', (route) => false);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                devtools.log('User Not Found');
                              } else {
                                if (e.code == 'wrong-password') {
                                  devtools.log('wrong password');
                                }
                              }
                            } catch (e) {
                              devtools.log('user profile not found');
                              print(e.runtimeType);
                            }
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterView()));
                            },
                            child: const Text(
                              'Not Registered? Click Here',
                              style: TextStyle(color: Colors.green),
                            )),
                      ],
                    ),
                  );
                default:
                  return const Text('Loading.....');
              }
            }),
      ),
    );
  }
}
