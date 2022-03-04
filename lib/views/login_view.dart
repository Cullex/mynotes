import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';

import '../firebase_options.dart';
import '../utilities/show_error_dialog.dart';

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
      body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Center(
                  child: SingleChildScrollView(
                    reverse: true,
                    padding: EdgeInsets.all(32),
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
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email),
                              hintText: 'Enter Email',
                              contentPadding: const EdgeInsets.all(15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: _password,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.key),
                              hintText: 'Enter Password',
                              contentPadding: const EdgeInsets.all(15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
                        const SizedBox(height: 5),
                        TextButton(
                          onPressed: () async {
                            final email = _email.text;
                            final password = _password.text;
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: email, password: password);
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  notesRoute, (route) => false);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                await showErrorDialog(
                                    context, 'User not found');
                              } else {
                                if (e.code == 'wrong-password') {
                                  await showErrorDialog(
                                    context,
                                    'Wrong Credentials',
                                  );
                                } else {
                                  await showErrorDialog(
                                      context, 'Error: ${e.code}');
                                }
                              }
                            } catch (e) {
                              await showErrorDialog(
                                context,
                                e.toString(),
                              );
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
                                      builder: (context) => const LoginView()));
                            },
                            child: const Text(
                              'Not Registered? Click Here',
                              style: TextStyle(color: Colors.green),
                            )),
                      ],
                    ),
                  ),
                );
              default:
                return const Text('Loading.....');
            }
          }),
    );
  }
}
