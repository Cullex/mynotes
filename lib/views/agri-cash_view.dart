import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/services/storage_service.dart';
import 'package:mynotes/utilities/show_success_dialog.dart';

import '../utilities/show_error_dialog.dart';

class AgriCashRegView extends StatefulWidget {
  const AgriCashRegView({Key? key}) : super(key: key);

  @override
  _AgriCashRegViewState createState() => _AgriCashRegViewState();
}

class _AgriCashRegViewState extends State<AgriCashRegView> {
  bool isLoading = false;
  late DateTime _dateTime;
  final first_name = TextEditingController();
  final last_name = TextEditingController();
  final full_address = TextEditingController();
  final gender = TextEditingController();
  final msisdn = TextEditingController();
  final national_id = TextEditingController();

  var myInitialItem = 'male';
  List<String> myItems = ['male', 'female'];

  /// final Storage storage = Storage();

  @override
  void initState() {
    _dateTime = DateTime(DateTime.now().year - 26);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference flexicash =
        FirebaseFirestore.instance.collection('flexicash');
    final Storage storage = Storage();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("FlexiCash Account Opening"),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/img_4.png"), fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: StreamBuilder(
                stream: flexicash.snapshots(),
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
                                      'Input Details Below',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    width: 360,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: DropdownButton(
                                        iconEnabledColor: Colors.green,
                                        isExpanded: true,
                                        hint: Text("Select Gender"),
                                        underline: Container(
                                            color: Colors.transparent),
                                        items: myItems.map((items) {
                                          return DropdownMenuItem(
                                              value: items, child: Text(items));
                                        }).toList(),
                                        onChanged: (value) {
                                          myInitialItem = 'male';
                                          setState(() {});
                                        }),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width: 383,
                                    child: TextField(
                                      style: TextStyle(color: Colors.green),
                                      controller: last_name,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          prefixIcon: const Icon(
                                            Icons.account_box,
                                            color: Colors.green,
                                          ),
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
                                      style: TextStyle(color: Colors.green),
                                      controller: first_name,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          prefixIcon: const Icon(
                                            Icons.accessibility_new,
                                            color: Colors.green,
                                          ),
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
                                      style: TextStyle(color: Colors.green),
                                      controller: national_id,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          prefixIcon: const Icon(
                                            Icons.book_outlined,
                                            color: Colors.green,
                                          ),
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
                                      style: TextStyle(color: Colors.green),
                                      controller: full_address,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          prefixIcon: const Icon(
                                            Icons.account_balance,
                                            color: Colors.green,
                                          ),
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
                                      style: TextStyle(color: Colors.green),
                                      controller: msisdn,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          prefixIcon: const Icon(
                                            Icons.phone,
                                            color: Colors.green,
                                          ),
                                          hintText: 'Enter Mobile Number',
                                          contentPadding:
                                              const EdgeInsets.all(15),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30))),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    width: 360,
                                    height: 49,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(30),
                                          ),
                                          primary: Colors.white),
                                      onPressed: () async {
                                        final results =
                                            await FilePicker.platform.pickFiles(
                                                allowMultiple: true,
                                                type: FileType.custom,
                                                allowedExtensions: [
                                              'png',
                                              'jpg',
                                              'jpeg',
                                              'pdf'
                                            ]);
                                        if (results == null) {
                                          await showErrorDialog(
                                              context, "Upload Attachments");
                                        } else {
                                          return null;
                                        }
                                        final path =
                                            results?.files.single.path!;
                                        final fileName =
                                            results?.files.single.name;
                                        storage
                                            .uploadFile(path!, fileName!)
                                            .then((value) => print("Done"));

                                        print(path);
                                        print(fileName);
                                      },
                                      child: Text(
                                        "Upload Attachments",
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: 150,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(30),
                                          ),
                                          primary: Colors.white),
                                      onPressed: () async {
                                        Future.delayed(Duration(seconds: 6),
                                            () {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          setState(() {
                                            isLoading = true;
                                          });
                                        });
                                        flexicash.add({
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
                                      child: Text(
                                        'Create Account',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ),
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
