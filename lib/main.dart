import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:itboost/models/pagemodel.dart';
import 'package:itboost/models/postlistconsumer.dart';
import 'package:itboost/ui/screens/screens.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

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
  @override
  void initState() {
    super.initState();

    OneSignal.shared.init("284c3838-be62-41ea-80ee-0267bb956346", iOSSettings: {
      OSiOSSettings.autoPrompt: true,
      OSiOSSettings.inAppLaunchUrl: true
    });
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PageModel>(
          builder: (_) => PageModel(),
        ),
        ChangeNotifierProvider<PostListConsumer>(
          builder: (_) => PostListConsumer(),
        )
      ],
      child: MainScaffold(),
    );
  }
}

class MainScaffold extends StatelessWidget {
  final _myScreens = [
    HomeScreen(),
    CategoriesScreen(),
    PostListScreen(),
  ];
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
          Provider.of<PageModel>(context, listen: false)
              .changePage(pageId: 1, categoryId: -1);
        },
      ),
      bottomNavigationBar: Consumer<PageModel>(
        builder: (ctx, _pageModel, _) {
          return BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 7.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: _pageModel.page == 0
                        ? MyColors.orange
                        : MyColors.darkGrey,
                  ),
                  onPressed: () {
                    _pageModel.changePage(pageId: 0, categoryId: -1);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: _pageModel.page == 2
                        ? MyColors.orange
                        : MyColors.darkGrey,
                  ),
                  onPressed: () {
                    _pageModel.changePage(pageId: 2, categoryId: -1);
                    Provider.of<PostListConsumer>(context, listen: false)
                        .getPostList(-1);
                  },
                ),
              ],
            ),
          );
        },
      ),
      body: SafeArea(
        child: Consumer<PageModel>(
          builder: (ctx, page, _) {
            return _myScreens[page.page];
          },
          child: _myScreens[0],
        ),
      ),
    );
  }
}
