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
          height: MediaQuery.of(context).size.height / 2.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Image.asset(
                "assets/logo.png",
                width: 71,
                height: 71,
              ),
              SizedBox(
                height: 15.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "IT BOOST AUSTRALIA",
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .apply(color: MyColors.magenta),
                  ),
                  Text(
                    "itboost.com.au",
                    style: Theme.of(context).textTheme.title.apply(
                          color: Color(0xff5e352c),
                        ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
