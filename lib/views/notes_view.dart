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
        title: Text(
          "Open Account",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
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
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/img_5.png"), fit: BoxFit.cover),
        ),
        child: SafeArea(
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
                        color: Colors.transparent,
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
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              subtitle: Text(
                                "Select Account Type You'd Like To Open",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.account_balance),
                              title: Text(
                                'FlexiCash',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(flexiCashAccountRegRoute);
                              },
                              subtitle: Text('Full KYC Account'),
                            ),
                            ListTile(
                              leading: Icon(Icons.wb_sunny),
                              title: Text(
                                'Tobacco Account',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(tobaccoRequirementsRoute);
                              },
                              subtitle: Text('Full KYC For Farmers'),
                            ),
                            ListTile(
                              leading: Icon(Icons.accessibility_new),
                              title: Text(
                                'Youth Account',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(youthAccountRegRoute);
                              },
                              subtitle: Text('Full KYC For Youths'),
                            ),
                            ListTile(
                              leading: Icon(Icons.whatshot),
                              title: Text(
                                'Cotton Account',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(cottonAccountRegRoute);
                              },
                              subtitle: Text('Full KYC For Farmers'),
                            ),

                            ///add grid here
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
      ),
    );
  }
}
