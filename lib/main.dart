import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:itboost/ui/screens/screens.dart';
import 'package:itboost/ui/screens/test.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'global.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics analytics = FirebaseAnalytics();
    return MaterialApp(
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: SplashScreen(),
      home: SplashScreen(),
      routes: {
        'home': (ctx) => HomeApp(),
      },
    );
  }
}

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  int _active = 0;
  final _myScreens = [
    HomeScreen(),
    CategoriesScreen(),
    PostListScreen(),
  ];
  @override
  void initState() {
    super.initState();

    OneSignal.shared.init("5a0bd6e8-7024-460c-84d6-9cd1f45ac62c", iOSSettings: {
      OSiOSSettings.autoPrompt: true,
      OSiOSSettings.inAppLaunchUrl: true
    });
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.blue,
        child: Container(
          height: 15,
          width: 15,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: MyColors.orange),
        ),
        onPressed: () {
          setState(() {
            _active = 1;
          });
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 7.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                color: MyColors.darkGrey,
              ),
              onPressed: () {
                setState(() {
                  _active = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.menu, color: MyColors.darkGrey),
              onPressed: () {
                setState(() {
                  _active = 2;
                });
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: _myScreens[_active],
      ),
    );
  }
}
