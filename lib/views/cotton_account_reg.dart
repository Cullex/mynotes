import 'package:flutter/material.dart';

class CottonAccountRegView extends StatefulWidget {
  const CottonAccountRegView({Key? key}) : super(key: key);

  @override
  _CottonAccountRegViewState createState() => _CottonAccountRegViewState();
}

class _CottonAccountRegViewState extends State<CottonAccountRegView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cotton"),
      ),
      body: SafeArea(
        child: Column(
          children: [Text("Hello Tinaye")],
        ),
      ),
    );
  }
}
