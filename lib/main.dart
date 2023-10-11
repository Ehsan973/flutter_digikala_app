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
        backgroundColor: CustomColors.backgroundScreenColor,
        body: SafeArea(
          child: Center(
            child: Container(
              height: 216,
              width: 160,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset('assets/images/iphone.png'),
                  const Text(
                    'آیفون 13 پرو مکس',
                    style: TextStyle(
                      fontFamily: 'SM',
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 53,
                    decoration: const BoxDecoration(
                      color: CustomColors.blue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: CustomColors.blue,
                          blurRadius: 25,
                          spreadRadius: -12,
                          offset: Offset(0, 15),
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Text('تومان'),
                        Column(
                          children: [
                            Text('423535000'),
                            Text('324000000'),
                          ],
                        ),
                        Image(
                          image: AssetImage(
                            'assets/images/icon_right_arrow_cricle.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _getCategoryList() {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.only(left: 20),
              child: CategoryHorizontalListItem(),
            );
          },
        ),
      ),
    );
  }
}

class CategoryHorizontalListItem extends StatelessWidget {
  const CategoryHorizontalListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 56,
          width: 56,
          decoration: ShapeDecoration(
            shadows: const [
              BoxShadow(
                color: Colors.amber,
                blurRadius: 25,
                spreadRadius: -12,
                offset: Offset(0, 15),
              )
            ],
            color: Colors.amber,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: const Icon(
            Icons.mouse,
            size: 32,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'همه',
          style: TextStyle(
            fontFamily: 'SB',
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
