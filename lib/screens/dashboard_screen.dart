import 'dart:ui';

import 'package:digikala_app/bloc/authentication/auth_bloc.dart';
import 'package:digikala_app/bloc/basket/basket_bloc.dart';
import 'package:digikala_app/bloc/basket/basket_event.dart';
import 'package:digikala_app/bloc/category/category_bloc.dart';
import 'package:digikala_app/bloc/home/home_bloc.dart';
import 'package:digikala_app/bloc/home/home_event.dart';
import 'package:digikala_app/bloc/home/home_state.dart';
import 'package:digikala_app/constants/colors.dart';
import 'package:digikala_app/data/model/basket_item.dart';
import 'package:digikala_app/di/di.dart';
import 'package:digikala_app/screens/cart_screen.dart';
import 'package:digikala_app/screens/category_screen.dart';
import 'package:digikala_app/screens/home_screen.dart';
import 'package:digikala_app/screens/login_screen.dart';
import 'package:digikala_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int _selectedBottomNavigationItem = 0;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: CustomColors.backgroundScreenColor,
        bottomNavigationBar: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: BottomNavigationBar(
              currentIndex: _selectedBottomNavigationItem,
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: const TextStyle(
                fontSize: 10,
                fontFamily: 'SB',
                color: CustomColors.blue,
              ),
              unselectedLabelStyle: const TextStyle(
                color: Colors.black,
                fontFamily: 'SB',
                fontSize: 10,
              ),
              onTap: (index) {
                setState(() {
                  _selectedBottomNavigationItem = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Image(
                      image: AssetImage('assets/images/icon_profile.png'),
                    ),
                  ),
                  activeIcon: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CustomColors.blue,
                          blurRadius: 20,
                          spreadRadius: -7,
                          offset: Offset(0, 10),
                        )
                      ],
                    ),
                    child: const Image(
                      image: AssetImage(
                        'assets/images/icon_profile_active.png',
                      ),
                    ),
                  ),
                  label: 'حساب کاربری',
                ),
                BottomNavigationBarItem(
                  icon: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Image(
                      image: AssetImage('assets/images/icon_basket.png'),
                    ),
                  ),
                  activeIcon: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CustomColors.blue,
                          blurRadius: 20,
                          spreadRadius: -7,
                          offset: Offset(0, 10),
                        )
                      ],
                    ),
                    child: const Image(
                      image: AssetImage(
                        'assets/images/icon_basket_active.png',
                      ),
                    ),
                  ),
                  label: 'سبد خرید',
                ),
                BottomNavigationBarItem(
                  icon: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Image(
                      image: AssetImage('assets/images/icon_category.png'),
                    ),
                  ),
                  activeIcon: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CustomColors.blue,
                          blurRadius: 20,
                          spreadRadius: -7,
                          offset: Offset(0, 10),
                        )
                      ],
                    ),
                    child: const Image(
                      image: AssetImage(
                        'assets/images/icon_category_active.png',
                      ),
                    ),
                  ),
                  label: 'دسته بندی',
                ),
                BottomNavigationBarItem(
                  icon: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Image(
                      image: AssetImage('assets/images/icon_home.png'),
                    ),
                  ),
                  activeIcon: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CustomColors.blue,
                          blurRadius: 20,
                          spreadRadius: -7,
                          offset: Offset(0, 10),
                        )
                      ],
                    ),
                    child: const Image(
                      image: AssetImage(
                        'assets/images/icon_home_active.png',
                      ),
                    ),
                  ),
                  label: 'حساب کاربری',
                ),
              ],
            ),
          ),
        ),
        body:
            // BlocProvider(
            //   create: (context) => AuthBloc(),
            //   child: LoginScreen(),
            // )

            IndexedStack(
          index: _selectedBottomNavigationItem,
          children: _getScreens(),
        ),
      ),
    );
  }

  Widget _getBlocProviderLoginScreen() {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: LoginScreen(),
    );
  }

  Widget _getBody() {
    return IndexedStack(
      index: _selectedBottomNavigationItem,
      children: _getScreens(),
    );
  }

  List<Widget> _getScreens() {
    return <Widget>[
      ProfileScreen(),
      BlocProvider(
        create: (context) {
          var bloc = locator.get<BasketBloc>();
          bloc.add(BasketFetchFromHiveEvent());
          return bloc;
        },
        child: const CartScreen(),
      ),
      BlocProvider(
        create: (context) => CategoryBloc(),
        child: const CategoryScreen(),
      ),
      BlocProvider(
        create: (context) {
          var bloc = HomeBloc();
          bloc.add(HomeGetInitialData());
          return bloc;
        },
        child: const HomeScreen(),
      )
    ];
  }
}
