import 'dart:math';

import 'package:digikala_app/constants/colors.dart';
import 'package:digikala_app/screens/category_screen.dart';
import 'package:digikala_app/screens/home_screen.dart';
import 'package:digikala_app/screens/product_list_screen.dart';
import 'package:digikala_app/widgets/banner_slider.dart';
import 'package:digikala_app/widgets/product_item.dart';
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductListScreen(),
    );
  }
}
