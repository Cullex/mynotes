import 'package:flutter/material.dart';
import 'package:mynotes/views/notes_view.dart';
import 'package:mynotes/views/tobacco_reg.dart';

class TobaccoRequirementsView extends StatelessWidget {
  const TobaccoRequirementsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img_14.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.darken),
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: AssetImage('assets/img_1.png'),
                      ),
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
                    Container(
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
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ConstrainedBox(
                                    constraints:
                                        BoxConstraints.tightFor(width: 200),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.green),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TobaccoRegView()));
                                        },
                                        child: Text("Continue")),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ConstrainedBox(
                                    constraints:
                                        BoxConstraints.tightFor(width: 130),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.redAccent.shade200),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NotesView()));
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
                  ],
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
