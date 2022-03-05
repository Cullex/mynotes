import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  _VerifyEmailViewState createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
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
              TextButton(
                onPressed: () async {},
                child: const Text(
                  "We've sent you an email verification.Please open it to verify your email",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {},
                child: const Text(
                  "If you haven't received a verification email yet, press the link below",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final user = FirebaseAuth.instance.currentUser;
                  await user?.sendEmailVerification();
                },
                child: const Text('Send Email Verification'),
              ),
              TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(registerRoute, (route) => false);
                },
                child: Text('Click Here To Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
