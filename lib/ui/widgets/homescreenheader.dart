import 'package:flutter/material.dart';
import 'package:itboost/global.dart';

class HomeScreenHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: MyColors.orange,
              borderRadius: BorderRadius.only(
                bottomRight:
                    Radius.elliptical(200, 150),
                    topRight:
                    Radius.elliptical(200, 250),
                    bottomLeft:
                    Radius.elliptical(250, 250),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.asset(
              "assets/logo.png",
              width: 41,
              height: 41,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 55),
                    Text(
                      "ITBOOST",
                      style: Theme.of(context).textTheme.display2.apply(
                            fontWeightDelta: 5,
                            color: Color(0xff7f4c00),
                          ),
                    ),
                  ],
                ),
                Text(
                  "Australia",
                  style: Theme.of(context).textTheme.display2.apply(
                        fontWeightDelta: 5,
                        color: Colors.white,
                      ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
