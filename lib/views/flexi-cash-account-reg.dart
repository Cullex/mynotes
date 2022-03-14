import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/services/storage_service.dart';

class FlexiCashAccountRegView extends StatefulWidget {
  const FlexiCashAccountRegView({Key? key}) : super(key: key);

  @override
  _FlexiCashAccountRegViewState createState() =>
      _FlexiCashAccountRegViewState();
}

class _FlexiCashAccountRegViewState extends State<FlexiCashAccountRegView> {
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
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    CollectionReference flexicash =
        FirebaseFirestore.instance.collection('flexicash');
    final Storage storage = Storage();
    return Scaffold(
      body: SafeArea(
        child: Theme(
          data: ThemeData(
              accentColor: Colors.green,
              primarySwatch: Colors.green,
              colorScheme: ColorScheme.light(primary: Colors.green)),
          child: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img_14.png"), fit: BoxFit.cover),
            ),
            child: Stepper(
              type: StepperType.horizontal,
              steps: getSteps(),
              currentStep: currentStep,
              onStepContinue: () {
                final isLastStep = currentStep == getSteps().length - 1;
                if (isLastStep) {
                  print('Completed');
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
                      hint: Text("Select Gender"),
                      underline: Container(color: Colors.transparent),
                      items: myItems.map((items) {
                        return DropdownMenuItem(
                            value: items, child: Text(items));
                      }).toList(),
                      onChanged: (value) {
                        myInitialItem = 'male';
                        setState(() {});
                      }),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  width: 360,
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
          title: Text('Complete'),
          content: Container(),
        ),
      ];
}
