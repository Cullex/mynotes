import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AgriplusRegView extends StatefulWidget {
  const AgriplusRegView({Key? key}) : super(key: key);

  @override
  _AgriplusRegViewState createState() => _AgriplusRegViewState();
}

class _AgriplusRegViewState extends State<AgriplusRegView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Open AgriPlus Account"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: 10),
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage('assets/img_2.png'),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 580,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      elevation: 25,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const ListTile(
                            title: Text(
                              'Input Details Below',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: 383,
                            child: TextField(
                              enableSuggestions: false,
                              autocorrect: false,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.account_box),
                                  hintText: 'Enter Surname',
                                  contentPadding: const EdgeInsets.all(15),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30))),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: 383,
                            child: TextField(
                              enableSuggestions: false,
                              autocorrect: false,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.account_box),
                                  hintText: 'Enter FirstName',
                                  contentPadding: const EdgeInsets.all(15),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30))),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: 383,
                            child: TextField(
                              enableSuggestions: false,
                              autocorrect: false,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.account_box),
                                  hintText: 'Enter National ID',
                                  contentPadding: const EdgeInsets.all(15),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
