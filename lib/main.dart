import 'dart:math';

import 'package:digikala_app/constants/colors.dart';
import 'package:digikala_app/widgets/banner_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 56,
                  width: 56,
                  decoration: ShapeDecoration(
                    shadows: [
                      BoxShadow(
                        color: Colors.amber,
                        blurRadius: 40,
                        spreadRadius: -6,
                        offset: Offset(0, 15),
                      )
                    ],
                    color: Colors.amber,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: Icon(
                    Icons.mouse,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text('Test'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
