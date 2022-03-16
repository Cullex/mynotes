import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FlexiCashAccountRegView extends StatefulWidget {
  const FlexiCashAccountRegView({Key? key}) : super(key: key);

  @override
  _FlexiCashAccountRegViewState createState() =>
      _FlexiCashAccountRegViewState();
}

class _FlexiCashAccountRegViewState extends State<FlexiCashAccountRegView> {
  bool isLoading = false;
  final TextEditingController first_nameController = TextEditingController();
  final TextEditingController last_nameController = TextEditingController();
  final TextEditingController mnemonicController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController marital_statusController =
      TextEditingController();
  final TextEditingController targetController = TextEditingController();
  final TextEditingController sectorController = TextEditingController();
  final TextEditingController industryController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController date_of_birthController = TextEditingController();
  final TextEditingController aml_risk_profileController =
      TextEditingController();
  final TextEditingController languageController = TextEditingController();
  final TextEditingController full_addressController = TextEditingController();
  final TextEditingController msisdnController = TextEditingController();
  final TextEditingController legalController = TextEditingController();
  final TextEditingController class_of_customerController =
      TextEditingController();
  final TextEditingController country_of_birthController =
      TextEditingController();
  final TextEditingController citizenshipController = TextEditingController();
  final TextEditingController ocupationController = TextEditingController();

  late PlatformFile? nationalIdFile,
      scanned_id_or_passport,
      aditional_documents;

  _register() async {
    var url = Uri.parse('https://payments.agribank.co.zw/api/customers');

    var request = new http.MultipartRequest("POST", url);

    request.fields.addAll({
      'first_name': first_nameController.text,
      'last_name': last_nameController.text,
      'mnemonic': 'sidney',
      'gender': 'sidney',
      'marital_status': 'sidney',
      'target': 'sidney',
      'sector': 'sidney',
      'industry': 'sidney',
      'nationality': 'sidney',
      'date_of_birth': '2022-03-05',
      'aml_risk_profile': 'sidney',
      'language': 'sidney',
      'full_address': 'nelson',
      'msisdn': msisdnController.text,
      'legal': 'sidney',
      'gross_income': "250.0",
      'negative_status': 'negative_status',
      'residency': 'residency',
      'contact_person': 'contact_person',
      'class_of_customer': 'sidney',
      'description': 'description',
      'aditional_documents': 'aditional_documents',
      'status_id': 'status_id',
      'country_of_birth': 'sidney',
      'citizenship': 'sidney',
      'ocupation': 'sidney',
      'reference': 'aasssss',
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

  String genderDropdownValue = 'gender';
  var genderItems = ['male', 'female', 'gender'];
  String maritalStatusDropdownValue = 'marital status';
  var maritalStatusItems = ['married', 'single', 'divorced', 'marital status'];
  String amlRiskProfile = 'aml risk';
  var amlRiskProfileItems = [
    'low risk',
    'medium risk',
    'high risk',
    'aml risk'
  ];
  String languages = 'Language';
  var languagesList = ['English', 'Shona', 'Ndebele', 'Other', 'Language'];
  String customerClass = 'sector';
  var customerClassList = [
    'white collar',
    'blue collar',
    'self employed',
    'sector'
  ];
  String countryOfBirth = 'Country Of Birth';
  var countryOfBirthList = [
    'Zimbabwe',
    'South Africa',
    'Botswana',
    'Zambia',
    'Malawi'
  ];
  String citizenshipInitialValue = 'Citizenship';
  var citizenshipList = [
    'Zimbabwe',
    'South Africa',
    'Botswana',
    'Zambia',
    'Malawi'
  ];
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Theme(
          data: ThemeData(
              accentColor: Colors.green,
              colorScheme: ColorScheme.light(primary: Colors.green)),
          child: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img_14.png"), fit: BoxFit.cover),
            ),
            child: Stepper(
              physics: ScrollPhysics(),
              type: StepperType.horizontal,
              steps: getSteps(),
              currentStep: currentStep,
              onStepContinue: () {
                final isLastStep = currentStep == getSteps().length - 1;
                if (isLastStep) {
                  _register();
                } else {
                  setState(() {
                    currentStep += 1;
                  });
                }
              },
              onStepCancel: () {
                currentStep == 0
                    ? null
                    : setState(() {
                        currentStep -= 1;
                      });
              },
            ),
          ),
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
          isActive: currentStep >= 0,
          title: Text('Requirements'),
          content: Container(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage('assets/img_1.png'),
                ),
                SizedBox(height: 15),
                Text(
                  'FlexiCash Opening Requirements',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Card(
                  elevation: 20,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Container(
                    height: 449,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Proof Of Residence",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Proof of residence in the name of the customer "
                            "(if not an affidavit from the Landlord or letter from employer confirming the"
                            " residence of the customer)",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "National ID/Passport/Drivers License",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "A valid ID, passport or a driver's license",
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Recent Photograph",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "One recent colour passport size photograph (within 3 months)",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Initial Deposit",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "An initial deposit of 100 Zimbabwean dollars)",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Non-Citizens",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Proof Of Income",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            "Residency Permit",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            "Copy of Passport",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            "One recent colour passport size photograph (within 3 months)",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
          isActive: currentStep >= 1,
          title: Text('Details'),
          content: Card(
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
                  width: 315,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  padding: EdgeInsets.all(10),
                  child: DropdownButton(
                      iconEnabledColor: Colors.green,
                      isExpanded: true,
                      hint: Text(genderDropdownValue),
                      underline: Container(color: Colors.transparent),
                      items: genderItems.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          genderDropdownValue = newValue!;
                        });
                      }),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  width: 360,
                  child: TextField(
                    style: TextStyle(color: Colors.green),
                    controller: last_nameController,
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
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: 360,
                  child: TextField(
                    style: TextStyle(color: Colors.green),
                    controller: first_nameController,
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
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: 360,
                  child: TextField(
                    style: TextStyle(color: Colors.green),
                    controller: nationalityController,
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
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
                SizedBox(height: 13),
                Container(
                  width: 315,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  padding: EdgeInsets.all(10),
                  child: DropdownButton(
                      iconEnabledColor: Colors.green,
                      isExpanded: true,
                      hint: Text(maritalStatusDropdownValue),
                      underline: Container(color: Colors.transparent),
                      items: maritalStatusItems.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          maritalStatusDropdownValue = newValue!;
                        });
                      }),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  width: 360,
                  child: TextField(
                    style: TextStyle(color: Colors.green),
                    controller: full_addressController,
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
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: 360,
                  child: TextField(
                    style: TextStyle(color: Colors.green),
                    controller: msisdnController,
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
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  width: 360,
                  child: TextField(
                    style: TextStyle(color: Colors.green),
                    controller: sectorController,
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
                        hintText: 'Enter Employment Sector',
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  width: 360,
                  child: TextField(
                    style: TextStyle(color: Colors.green),
                    controller: ocupationController,
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
                        hintText: 'Enter Occupation',
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
          isActive: currentStep >= 2,
          title: Text('Attachments'),
          content: Column(
            children: [
              Container(
                width: 360,
                height: 49,
              ),
              SizedBox(height: 13),
              Container(
                width: 315,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                padding: EdgeInsets.all(10),
                child: DropdownButton(
                    iconEnabledColor: Colors.green,
                    isExpanded: true,
                    hint: Text(amlRiskProfile),
                    underline: Container(color: Colors.transparent),
                    items: amlRiskProfileItems.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        amlRiskProfile = newValue!;
                      });
                    }),
              ),
              SizedBox(height: 13),
              Container(
                width: 315,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                padding: EdgeInsets.all(10),
                child: DropdownButton(
                    iconEnabledColor: Colors.green,
                    isExpanded: true,
                    hint: Text(languages),
                    underline: Container(color: Colors.transparent),
                    items: languagesList.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        languages = newValue!;
                      });
                    }),
              ),
              SizedBox(height: 13),
              Container(
                width: 315,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                padding: EdgeInsets.all(10),
                child: DropdownButton(
                    iconEnabledColor: Colors.green,
                    isExpanded: true,
                    hint: Text(customerClass),
                    underline: Container(color: Colors.transparent),
                    items: customerClassList.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        customerClass = newValue!;
                      });
                    }),
              ),
              SizedBox(height: 13),
              Container(
                width: 315,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                padding: EdgeInsets.all(10),
                child: DropdownButton(
                    iconEnabledColor: Colors.green,
                    isExpanded: true,
                    hint: Text(countryOfBirth),
                    underline: Container(color: Colors.transparent),
                    items: countryOfBirthList.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        countryOfBirth = newValue!;
                      });
                    }),
              ),
              SizedBox(height: 13),
              Container(
                width: 315,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                padding: EdgeInsets.all(10),
                child: DropdownButton(
                    iconEnabledColor: Colors.green,
                    isExpanded: true,
                    hint: Text(citizenshipInitialValue),
                    underline: Container(color: Colors.transparent),
                    items: citizenshipList.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        citizenshipInitialValue = newValue!;
                      });
                    }),
              ),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.all(10),
                width: 360,
                child: TextField(
                  style: TextStyle(color: Colors.green),
                  controller: first_nameController,
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
                      hintText: 'Enter Gross Income',
                      contentPadding: const EdgeInsets.all(15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: 360,
                child: TextField(
                  style: TextStyle(color: Colors.green),
                  controller: first_nameController,
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
                      hintText: 'Enter Residency',
                      contentPadding: const EdgeInsets.all(15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: 360,
                child: TextField(
                  style: TextStyle(color: Colors.green),
                  controller: mnemonicController,
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
                      hintText: 'Enter mnemonic',
                      contentPadding: const EdgeInsets.all(15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
              Container(
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
                    "Upload National ID",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
              Container(
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
                    "Upload National ID",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
              Container(
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
                    "Upload National ID",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
            ],
          ),
        ),
      ];
}
