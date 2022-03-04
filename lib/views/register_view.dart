import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
      body: SingleChildScrollView(
        reverse: true,
        padding: EdgeInsets.all(32),
        child: Column(children: [
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
                fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
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
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email),
                hintText: 'Enter Email',
                contentPadding: const EdgeInsets.all(15),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
          ),
          SizedBox(height: 10),
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
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                final userCredential = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: email, password: password);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  print('weak password');
                } else {
                  if (e.code == 'email-already-in-use') {
                    print('Email Already In Use');
                  } else {
                    if (e.code == 'invalid-email') {
                      print('Invalid Email Entered');
                    }
                  }
                }
              }
            },
            child: const Text(
              'Register',
              style: TextStyle(color: Colors.green),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginView()));
            },
            child: const Text(
              'Already Registered. Login',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ]),
      ),
    );
  }
}
