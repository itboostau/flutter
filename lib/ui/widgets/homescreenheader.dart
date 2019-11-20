import 'dart:math';

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
        // Positioned.fill(
        //   child: Transform(
        //     // transform: Matrix4.skewY(3.2)..translate(-20.0, -70.0, 10)..scale(1.1)..rotateX(pi*.3),
        //     transform: Matrix4.skewY(.2)..translate(-51.0, -91.0, 0.0)
        //       ..scale(1.2),
        //     child: ClipOval(
        //       child: Container(
        //         height: MediaQuery.of(context).size.height,
        //         width: double.infinity,
        //         decoration: BoxDecoration(
        //           color: MyColors.orange,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
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
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "ITBOOST",
                    style: Theme.of(context).textTheme.display2.apply(
                          fontWeightDelta: 5,
                          color: Color(0xff7f4c00),
                        ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Australia",
                      style: Theme.of(context).textTheme.display2.apply(
                            fontWeightDelta: 5,
                            color: Colors.white,
                          ),
                    ),
                    SizedBox(width: 25),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
