import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/utilities/show_success_dialog.dart';

class YouthAccountRegView extends StatefulWidget {
  const YouthAccountRegView({Key? key}) : super(key: key);

  @override
  _YouthAccountRegViewState createState() => _YouthAccountRegViewState();
}

class _YouthAccountRegViewState extends State<YouthAccountRegView> {
  bool isLoading = false;
  late DateTime _dateTime;
  final first_name = TextEditingController();
  final last_name = TextEditingController();
  final full_address = TextEditingController();
  final gender = TextEditingController();
  final msisdn = TextEditingController();
  final national_id = TextEditingController();

  @override
  void initState() {
    _dateTime = DateTime(DateTime.now().year - 26);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference youth_account_reg =
        FirebaseFirestore.instance.collection('youth_account_reg');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Tobacco Account Opening"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder(
              stream: youth_account_reg.snapshots(),
              builder: (context, snapshot) {
                return Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 10),
                        CircleAvatar(
                          radius: 45,
                          backgroundImage: AssetImage('assets/img_1.png'),
                        ),
                        SizedBox(height: 10),
                        Container(
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
                                ListTile(
                                  title: Text(
                                    'Date Of Birth',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  subtitle: Text(
                                    _dateTime.toString(),
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  trailing: Icon(
                                    Icons.calendar_month,
                                    color: Colors.green,
                                  ),
                                  onTap: () => {_pickTime()},
                                  dense: false,
                                  selected: true,
                                  enabled: true,
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  width: 383,
                                  child: TextField(
                                    controller: last_name,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        prefixIcon:
                                            const Icon(Icons.account_box),
                                        hintText: 'Enter Surname',
                                        contentPadding:
                                            const EdgeInsets.all(15),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  width: 383,
                                  child: TextField(
                                    controller: first_name,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        prefixIcon:
                                            const Icon(Icons.accessibility_new),
                                        hintText: 'Enter FirstName',
                                        contentPadding:
                                            const EdgeInsets.all(15),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  width: 383,
                                  child: TextField(
                                    controller: national_id,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        prefixIcon:
                                            const Icon(Icons.book_outlined),
                                        hintText: 'Enter National ID',
                                        contentPadding:
                                            const EdgeInsets.all(15),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  width: 383,
                                  child: TextField(
                                    controller: full_address,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        prefixIcon:
                                            const Icon(Icons.account_balance),
                                        hintText: 'Enter Residential Address',
                                        contentPadding:
                                            const EdgeInsets.all(15),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  width: 383,
                                  child: TextField(
                                    controller: msisdn,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.phone),
                                        hintText: 'Enter Mobile Number',
                                        contentPadding:
                                            const EdgeInsets.all(15),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Radio(
                                        value: 1,
                                        groupValue: 'null',
                                        onChanged: (index) {}),
                                    Expanded(child: Text('Male')),
                                    Radio(
                                        value: 1,
                                        groupValue: 'null',
                                        onChanged: (index) {}),
                                    Expanded(child: Text('Male'))
                                  ],
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green),
                                  onPressed: () async {
                                    Future.delayed(Duration(seconds: 6), () {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      setState(() {
                                        isLoading = true;
                                      });
                                    });
                                    youth_account_reg.add({
                                      'first_name': first_name.text,
                                      'last_name': last_name.text,
                                      'full_address': full_address.text,
                                      'gender': gender.text,
                                      'msisdn': msisdn.text,
                                      'national_id': national_id.text
                                    });
                                    await showSuccessDialog(
                                      context,
                                      'Account Successfully Captured',
                                    );
                                  },
                                  child: Text('Create Account'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  _pickTime() async {
    DateTime? d = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: DateTime(DateTime.now().year + 1));

    if (d != null) {
      setState(() {
        _dateTime = d;
      });
    }
  }
}
