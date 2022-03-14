import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Kindacode.com'),
        ),
        body: Center(
          child: Card(
              elevation: 20,
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: SizedBox(
                width: 300,
                height: 200,
                child:
                    Center(child: Text('YoYo', style: TextStyle(fontSize: 50))),
              )),
        ));
  }
}
