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
  final TextEditingController grossIncomeController = TextEditingController();
  final TextEditingController contactPersonController = TextEditingController();
  final TextEditingController referenceController = TextEditingController();

  late PlatformFile? nationalIdFile,
      scanned_id_or_passport,
      aditional_documents;

  _register() async {
    var url = Uri.parse('https://payments.agribank.co.zw/api/customers');

    var request = new http.MultipartRequest("POST", url);

    request.fields.addAll({
      'first_name': first_nameController.text,
      'last_name': last_nameController.text,
      'mnemonic': 'XX-XXXXXXX-XX',
      'gender': genderDropdownValue,
      'marital_status': maritalStatusDropdownValue,
      'target': targetInitialValue,
      'sector': sectorInitialValue,
      'industry': industryController.text,
      'nationality': nationalityInitialValue,
      'date_of_birth': '2022-03-05',
      'aml_risk_profile': amlRiskProfile,
      'language': languages,
      'full_address': full_addressController.text,
      'msisdn': msisdnController.text,
      'legal': legalController.text,
      'gross_income': grossIncomeController.text,
      'negative_status': customerStatusInitialValue,
      'residency': 'Zimbabwe',
      'contact_person': contactPersonController.text,
      'class_of_customer': customerStatusInitialValue,
      'description': 'description',
      'aditional_documents': 'additional_documents',
      'status_id': customerStatusInitialValue,
      'country_of_birth': countryOfBirth,
      'citizenship': citizenshipInitialValue,
      'ocupation': ocupationController.text,
      'reference': referenceController.text,
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

  String genderDropdownValue = 'Select Gender';
  var genderItems = [
    'male',
    'female',
  ];
  String customerStatusInitialValue = 'Select Customer Status';
  var customerStatusItems = [
    'Standard',
    'Deceased Indiv',
    'Under Litigat',
    'Fin. Inst Susp',
    'Bankrupt',
    'Hotlisted',
    'Cust Deletion',
    'T24 Updates'
  ];

  String sectorInitialValue = 'Select Customer Sector';
  var sectorItems = [
    'Individual',
    'Agriculture',
    'Banks Foreign',
    'Local Banks',
    'Central Banks',
    'Post Office',
    'Bank Branches',
    'Financial Inst',
    'Embas & NGO',
    'State ENT',
    'Energy',
    'Mining',
    'Const and Propt',
    'Manufacturing',
    'Distribution',
    'Transport',
    'Communication',
    'Services',
    'Thirdpart User',
    'Other IB User'
  ];

  String maritalStatusDropdownValue = 'Select Marital Status';
  var maritalStatusItems = [
    'Single',
    'Married',
    'Divorced',
    'Widowed',
    'Engaged'
  ];
  String amlRiskProfile = 'Select AML Risk';
  var amlRiskProfileItems = [
    'low risk',
    'medium risk',
    'high risk',
    'aml risk'
  ];
  String languages = 'Select Language';
  var languagesList = ['English', 'Shona', 'Ndebele', 'Other', 'Language'];

  String countryOfBirth = 'Select Country Of Birth';
  var countryOfBirthList = [
    'Zimbabwe',
    'South Africa',
    'Botswana',
    'Zambia',
    'Malawi'
  ];
  String nationalityInitialValue = 'Select Nationality';
  var nationalityItemsList = [
    'South Africa',
    'Botswana',
    'Zimbabwe',
    'Namibia',
    'Zambia'
  ];
  String citizenshipInitialValue = 'Select Citizenship';
  var citizenshipList = [
    'Zimbabwe',
    'South Africa',
    'Botswana',
    'Zambia',
    'Malawi'
  ];
  String targetInitialValue = 'Select Target';
  var targetItemsList = [
    'Standard Individual',
    'Individual High NetWorth',
    'Low Income',
    'Minor',
    'Student',
    'Youth',
    'Pensioners',
    'Special Clients',
    'Staff',
    'Cross Boarder',
    'Artisanal Miner',
    'Farmer A1',
    'Farmer A2',
    'Sole Proprietor',
    'PEP',
    'Communal Farmer',
    'Female Executive',
    'SmallScale Miner'
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
                  image: AssetImage("assets/img_15.png"), fit: BoxFit.cover),
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
                      color: Colors.yellow.shade300),
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
                          Icons.account_circle_outlined,
                          color: Colors.green,
                        ),
                        hintText: 'Enter FirstName',
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),

                ///contact person
                Container(
                  padding: EdgeInsets.all(10),
                  width: 360,
                  child: TextField(
                    style: TextStyle(color: Colors.green),
                    controller: contactPersonController,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.app_registration,
                          color: Colors.green,
                        ),
                        hintText: 'Enter Contact Person',
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),

                ///nationality
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
                      hint: Text(nationalityInitialValue),
                      underline: Container(color: Colors.transparent),
                      items: nationalityItemsList.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          nationalityInitialValue = newValue!;
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

                ///
                ///
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
                      hint: Text(targetInitialValue),
                      underline: Container(color: Colors.transparent),
                      items: targetItemsList.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          targetInitialValue = newValue!;
                        });
                      }),
                ),
                SizedBox(height: 10),
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
                    controller: industryController,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.add_business,
                          color: Colors.green,
                        ),
                        hintText: 'Enter Industry',
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
                SizedBox(height: 10),
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
                      hint: Text(targetInitialValue),
                      underline: Container(color: Colors.transparent),
                      items: targetItemsList.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          targetInitialValue = newValue!;
                        });
                      }),
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
                    hint: Text(sectorInitialValue),
                    underline: Container(color: Colors.transparent),
                    items: sectorItems.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        sectorInitialValue = newValue!;
                      });
                    }),
              ),

              ///legal
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                width: 360,
                child: TextField(
                  style: TextStyle(color: Colors.green),
                  controller: legalController,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.app_registration,
                        color: Colors.green,
                      ),
                      hintText: 'Enter Name on ID',
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
                        citizenshipInitialValue =
                            newValue ?? "Select Citizenship";
                      });
                    }),
              ),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.all(10),
                width: 360,
                child: TextField(
                  style: TextStyle(color: Colors.green),
                  controller: grossIncomeController,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.vignette_outlined,
                        color: Colors.green,
                      ),
                      hintText: 'Enter Gross Income',
                      contentPadding: const EdgeInsets.all(15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),

              ///enetr status
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
                    hint: Text(sectorInitialValue),
                    underline: Container(color: Colors.transparent),
                    items: sectorItems.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        sectorInitialValue = newValue!;
                      });
                    }),
              ),

              ///reference
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.all(10),
                width: 360,
                child: TextField(
                  style: TextStyle(color: Colors.green),
                  controller: referenceController,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(
                        Icons.add_chart,
                        color: Colors.green,
                      ),
                      hintText: 'Enter Reference',
                      contentPadding: const EdgeInsets.all(15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),

              SizedBox(
                height: 13,
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
                    "Upload Profile Photo",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
              SizedBox(
                height: 13,
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
                    "Upload Scanned ID",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
              SizedBox(
                height: 13,
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
                    "Upload Proof Of Residence",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
            ],
          ),
        ),
      ];
}