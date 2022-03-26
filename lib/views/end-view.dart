import 'package:flutter/material.dart';

class EndView extends StatelessWidget {
  String first_name,
      last_name,
      full_address,
      genderDropdownValue,
      maritalStatusInitialValue,
      msisdn,
      mnemonic,
      gross_income;

  EndView(
      {required this.first_name,
      required this.last_name,
      required this.full_address,
      required this.genderDropdownValue,
      required this.maritalStatusInitialValue,
      required this.msisdn,
      required this.gross_income,
      required this.mnemonic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transferring Data"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text('$first_name'),
            Text('$last_name'),
            Text('$full_address'),
            Text('$genderDropdownValue'),
            Text('$maritalStatusInitialValue'),
            Text('$msisdn'),
            Text('$gross_income'),
            Text('$mnemonic'),
          ],
        ),
      ),
    );
  }
}
