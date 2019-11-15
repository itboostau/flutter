import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text("Test"),
          onPressed: () {
            
          },
        ),
      ),
    );
  }
}
