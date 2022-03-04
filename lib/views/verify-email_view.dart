import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
              const Text('Please Verify Email Address'),
              TextButton(
                onPressed: () async {
                  final user = FirebaseAuth.instance.currentUser;
                  await user?.sendEmailVerification();
                },
                child: const Text('Send Email Verification'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
