import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mynotes/views/tobacco_reg.dart';

class TobaccoRegViewCont extends StatelessWidget {
  TextEditingController reference = new TextEditingController();

  String first_name,
      last_name,
      full_address,
      gender,
      marital_status,
      msisdn,
      mnemonic,
      citizenship,
      ocupation,
      gross_income;

  TobaccoRegViewCont(
      {required this.first_name,
      required this.last_name,
      required this.full_address,
      required this.gender,
      required this.marital_status,
      required this.msisdn,
      required this.gross_income,
      required this.citizenship,
      required this.mnemonic,
      required this.ocupation});

  late PlatformFile? nationalIdFile,
      scanned_id_or_passport,
      aditional_documents;

  _createTobaccoAccount() async {
    var url = Uri.parse('https://payments.agribank.co.zw/api/customers');

    var request = new http.MultipartRequest("POST", url);

    request.fields.addAll({
      'first_name': first_name,
      'last_name': last_name,
      'full_address': full_address,
      'genderDropdownValue': gender,
      'marital_status': marital_status,
      'msisdn': msisdn,
      'gross_income': gross_income,
      'mnemonic': mnemonic,
      'date_of_birth': '19801212',
      'legal': 'XX-XXXXXXX-X-XX',
      'country_of_birth': 'Zimbabwe',
      'contact_person': 'Agribank',
      'gender': gender,
      'citizenship': citizenship,
      'ocupation': ocupation,
    });
    // add file to multipart
    request.files.addAll([
      http.MultipartFile.fromBytes(
        'profile_photo',
        File(nationalIdFile?.path ?? '').readAsBytesSync(),
        filename: nationalIdFile?.name,
      ),
      http.MultipartFile.fromBytes(
        'scanned_id_or_passport',
        File(scanned_id_or_passport?.path ?? '').readAsBytesSync(),
        filename: scanned_id_or_passport?.name,
      ),
      http.MultipartFile.fromBytes(
        'aditional_documents',
        File(aditional_documents?.path ?? '').readAsBytesSync(),
        filename: aditional_documents?.name,
      ),
    ]);

    // send
    var response = await request.send();
    final respStr = await response.stream.bytesToString();

    print('Response status: ${response.statusCode}');
    print('Response body: ${respStr}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/img_6.png"),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
        )),
        child: SafeArea(
            child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(55),
            image: DecorationImage(
              image: AssetImage("assets/img_10.png"),
            ),
          ),
          child: Card(
            color: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 30,
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: 250),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 330,
                    height: 49,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30),
                          ),
                          primary: Colors.white),
                      onPressed: () async {
                        final results = await FilePicker.platform.pickFiles(
                          allowMultiple: true,
                          type: FileType.custom,
                          allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf'],
                        );

                        if (results == null) {
                          print("no file picked");
                          return;
                        }

                        scanned_id_or_passport = results?.files?.isEmpty ?? true
                            ? null
                            : results.files.first;

                        // final path = results?.files;
                        // final fileName = results?.files.single.name;
                        //
                        // print(path);
                        // print(fileName);
                      },
                      child: Text(
                        "Upload Scanned ID",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 330,
                    height: 49,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30),
                          ),
                          primary: Colors.white),
                      onPressed: () async {
                        final results = await FilePicker.platform.pickFiles(
                          allowMultiple: true,
                          type: FileType.custom,
                          allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf'],
                        );

                        if (results == null) {
                          print("no file picked");
                          return;
                        }

                        nationalIdFile = results?.files?.isEmpty ?? true
                            ? null
                            : results.files.first;

                        // final path = results?.files;
                        // final fileName = results?.files.single.name;
                        //
                        // print(path);
                        // print(fileName);
                      },
                      child: Text(
                        "Upload Profile Photo",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 330,
                    height: 49,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30),
                          ),
                          primary: Colors.white),
                      onPressed: () async {
                        final results = await FilePicker.platform.pickFiles(
                          allowMultiple: true,
                          type: FileType.custom,
                          allowedExtensions: ['png', 'jpg', 'jpeg', 'pdf'],
                        );

                        if (results == null) {
                          print("no file picked");
                          return;
                        }

                        aditional_documents = results?.files?.isEmpty ?? true
                            ? null
                            : results.files.first;

                        // final path = results?.files;
                        // final fileName = results?.files.single.name;
                        //
                        // print(path);
                        // print(fileName);
                      },
                      child: Text(
                        "Upload Proof Of Residence",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints.tightFor(width: 200),
                        child: ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.green),
                            onPressed: () {
                              _createTobaccoAccount();
                            },
                            child: Text("Continue")),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints.tightFor(width: 120),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.redAccent.shade200),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => TobaccoRegView()));
                            },
                            child: Text("Cancel")),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
