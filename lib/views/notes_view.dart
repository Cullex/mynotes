import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';

import '../main.dart';
import 'login_view.dart';

enum MenuAction { logout }

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  _NotesViewState createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Open Account"),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginView()));
                  }
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem<MenuAction>(
                    value: MenuAction.logout, child: Text('Log out')),
              ];
            },
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage('assets/img_1.png'),
                    ),
                    Text(
                      'AFC Commercial Bank',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 35),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      elevation: 25,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const ListTile(
                            title: Text(
                              'Open A New Account',
                              textAlign: TextAlign.center,
                            ),
                            subtitle: Text(
                              "Select Account Type You'd Like To Open",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Divider(
                            color: Colors.green,
                          ),
                          const ListTile(
                            leading: Icon(Icons.account_balance_wallet_sharp),
                            title: Text('Tobacco Account'),
                            subtitle: Text('For Tobacco Farmers'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                child: const Text(
                                  'Open',
                                  style: TextStyle(color: Colors.green),
                                ),
                                onPressed: () {/* ... */},
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.green,
                          ),
                          const ListTile(
                            leading: Icon(Icons.account_balance_wallet_sharp),
                            title: Text('AgriCash'),
                            subtitle: Text('Full KYC Account'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                child: const Text(
                                  'Open',
                                  style: TextStyle(color: Colors.green),
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(agriCashRegRoute);
                                },
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                          Divider(
                            color: Colors.green,
                          ),
                          const ListTile(
                            leading: Icon(Icons.account_balance_wallet_sharp),
                            title: Text('Youth Account'),
                            subtitle: Text('Full KYC Account'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                child: const Text(
                                  'Open',
                                  style: TextStyle(color: Colors.green),
                                ),
                                onPressed: () {/* ... */},
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                          Divider(
                            color: Colors.green,
                          ),
                          const ListTile(
                            leading: Icon(Icons.account_balance_wallet_sharp),
                            title: Text('Cotton Account'),
                            subtitle: Text('Full KYC Account'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                child: const Text(
                                  'Open',
                                  style: TextStyle(color: Colors.green),
                                ),
                                onPressed: () {/* ... */},
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),

                          ///add date widget
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
