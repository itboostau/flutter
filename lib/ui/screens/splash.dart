import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:itboost/global.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
      () => Navigator.of(context).pushReplacementNamed('home'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.orange,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/logo.png",
                width: 51,
                height: 51,
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "IT BOOST AUSTRALIA",
                style: Theme.of(context)
                    .textTheme
                    .title
                    .apply(color: MyColors.magenta),
              ),
              Text(
                "itboost.com.au",
                style: Theme.of(context)
                    .textTheme
                    .title
                    .apply(color: Color(0xff5e352c)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
