import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/views/tobacco-reg_cont.dart';
import 'package:mynotes/views/tobacco-requirements-view.dart';

class TobaccoRegView extends StatefulWidget {
  const TobaccoRegView({Key? key}) : super(key: key);

  @override
  _TobaccoRegViewState createState() => _TobaccoRegViewState();
}

class _TobaccoRegViewState extends State<TobaccoRegView> {
  bool _validate = false;
  TextEditingController _first_name = new TextEditingController();
  TextEditingController _last_name = new TextEditingController();
  TextEditingController _full_address = new TextEditingController();
  TextEditingController _msisdn = new TextEditingController();
  TextEditingController _gross_income = new TextEditingController();
  TextEditingController _mnemonic = new TextEditingController();
  TextEditingController _ocupation = new TextEditingController();

  late PlatformFile? nationalIdFile,
      scanned_id_or_passport,
      aditional_documents;

  String gender = 'Select Gender';
  var genderItems = [
    'male',
    'female',
  ];
  String citizenship = 'Select Citizenship';
  var citizenshipItems = [
    'Zimbabwe',
    'South Africa',
    'Botswana',
    'Zambia',
  ];
  String marital_status = 'Select Marital Status';
  var maritalStatusItems = [
    'Single',
    'Divorced',
    'Married',
    'Widowed',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/img_19.png"),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
        )),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'An Error Occured',
                  style: TextStyle(color: Colors.transparent),
                ),
                SizedBox(height: 10),
                CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage("assets/img_1.png"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Tobacco Account Opening",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _first_name,
                    decoration: InputDecoration(
                      fillColor: Colors.white70,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Enter First Name',
                      errorText: _validate ? "Field Cant Be Empty" : null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _last_name,
                    decoration: InputDecoration(
                      fillColor: Colors.white70,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Enter Last Name',
                      errorText: _validate ? "Field Cant Be Empty" : null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _full_address,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Enter Full Address',
                      errorText: _validate ? "Field Cant Be Empty" : null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 383,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    padding: EdgeInsets.all(10),
                    child: DropdownButton(
                        iconEnabledColor: Colors.green,
                        isExpanded: true,
                        hint: Text(gender),
                        underline: Container(color: Colors.transparent),
                        items: genderItems.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            gender = newValue!;
                          });
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 383,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    padding: EdgeInsets.all(10),
                    child: DropdownButton(
                        iconEnabledColor: Colors.green,
                        isExpanded: true,
                        hint: Text(citizenship),
                        underline: Container(color: Colors.transparent),
                        items: citizenshipItems.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            citizenship = newValue!;
                          });
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 383,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    padding: EdgeInsets.all(10),
                    child: DropdownButton(
                        iconEnabledColor: Colors.green,
                        isExpanded: true,
                        hint: Text(
                          marital_status,
                        ),
                        underline: Container(color: Colors.transparent),
                        items: maritalStatusItems.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            marital_status = newValue!;
                          });
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _msisdn,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Enter Full Address',
                      errorText: _validate ? "Field Cant Be Empty" : null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _gross_income,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Enter Gross Income',
                      errorText: _validate ? "Field Cant Be Empty" : null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _mnemonic,
                    decoration: InputDecoration(
                      fillColor: Colors.white70,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Enter National ID#',
                      errorText: _validate ? "Field Cant Be Empty" : null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _ocupation,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Enter Occupation',
                      errorText: _validate ? "Field Cant Be Empty" : null,
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
                              setState(() {
                                _first_name.text.isEmpty
                                    ? _validate = true
                                    : _validate = false;
                                _last_name.text.isEmpty
                                    ? _validate = true
                                    : _validate = false;
                                _full_address.text.isEmpty
                                    ? _validate = true
                                    : _validate = false;
                                gender.isEmpty
                                    ? _validate = true
                                    : _validate = false;
                                marital_status.isEmpty
                                    ? _validate = true
                                    : _validate = false;
                                _msisdn.text.isEmpty
                                    ? _validate = true
                                    : _validate = false;
                                _gross_income.text.isEmpty
                                    ? _validate = true
                                    : _validate = false;
                                citizenship.isEmpty
                                    ? _validate = true
                                    : _validate = false;
                                _ocupation.text.isEmpty
                                    ? _validate = true
                                    : _validate = false;
                                _mnemonic.text.isEmpty
                                    ? _validate = true
                                    : _validate = false;
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => TobaccoRegViewCont(
                                      first_name: _first_name.text,
                                      last_name: _last_name.text,
                                      full_address: _full_address.text,
                                      gender: gender,
                                      marital_status: marital_status,
                                      msisdn: _msisdn.text,
                                      gross_income: _gross_income.text,
                                      citizenship: citizenship,
                                      ocupation: _ocupation.text,
                                      mnemonic: _mnemonic.text)));
                            },
                            child: Text("Continue")),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints.tightFor(width: 150),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.redAccent.shade200),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      TobaccoRequirementsView()));
                            },
                            child: Text("Cancel")),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
