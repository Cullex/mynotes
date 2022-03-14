import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

import 'login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
              image: AssetImage("assets/img_14.png"), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
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
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              '(Account Opening App)',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 25),
            TextField(
              style: TextStyle(color: Colors.green),
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
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
            SizedBox(height: 10),
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
            TextButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                Future.delayed(Duration(seconds: 8), () {
                  setState(() {
                    isLoading = false;
                  });
                });
                final email = _email.text;
                final password = _password.text;
                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email, password: password);
                  final user = FirebaseAuth.instance.currentUser;
                  user?.sendEmailVerification();
                  Navigator.of(context).pushNamed(verifyEmailRoute);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    await showErrorDialog(context, 'Weak Password');
                  } else {
                    if (e.code == 'email-already-in-use') {
                      await showErrorDialog(context, 'Email Already In Use');
                    } else {
                      if (e.code == 'invalid-email') {
                        await showErrorDialog(context, 'Invalid Email');
                      } else {
                        await showErrorDialog(context, 'Error ${e.code}');
                      }
                    }
                  }
                }
              },
              child: isLoading
                  ? CircularProgressIndicator(color: Colors.green)
                  : Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginView()));
              },
              child: const Text(
                'Already Registered. Login',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
