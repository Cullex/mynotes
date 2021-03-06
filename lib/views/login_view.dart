import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/views/register_view.dart';

import '../firebase_options.dart';
import '../utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLoading = false;
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
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/img_4.png"), fit: BoxFit.cover),
        ),
        child: FutureBuilder(
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
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 25),
                          TextField(
                            style: TextStyle(color: Colors.green),
                            controller: _email,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Colors.green,
                                ),
                                hintText: 'Enter Email',
                                contentPadding: const EdgeInsets.all(15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30))),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            style: TextStyle(color: Colors.green),
                            controller: _password,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: const Icon(
                                  Icons.key,
                                  color: Colors.green,
                                ),
                                hintText: 'Enter Password',
                                contentPadding: const EdgeInsets.all(15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30))),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            child: TextButton(
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                Future.delayed(Duration(seconds: 3), () {
                                  setState(() {
                                    isLoading = false;
                                  });
                                });
                                final email = _email.text;
                                final password = _password.text;
                                try {
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: email, password: password);
                                  final user =
                                      FirebaseAuth.instance.currentUser;
                                  if (user?.emailVerified ?? false) {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            notesRoute, (route) => false);
                                  } else {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            verifyEmailRoute, (route) => false);
                                  }
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
                                          context, 'Error:${e.code}');
                                    }
                                  }
                                } catch (e) {
                                  await showErrorDialog(
                                    context,
                                    e.toString(),
                                  );
                                }
                              },
                              child: isLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.green)
                                  : Text(
                                      'Sign In',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
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
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
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
