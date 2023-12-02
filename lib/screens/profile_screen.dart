import 'package:digikala_app/bloc/authentication/auth_bloc.dart';
import 'package:digikala_app/screens/login_screen.dart';
import 'package:digikala_app/util/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundScreenColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Image(
                      image: AssetImage('assets/images/icon_apple_blue.png'),
                    ),
                    Expanded(
                      child: Text(
                        'حساب کاربری',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SB',
                          fontSize: 16,
                          color: CustomColors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Text(
              'احسان صالحی',
              style: TextStyle(fontFamily: 'SB', fontSize: 16),
            ),
            const Text(
              '09304629579',
              style: TextStyle(
                fontFamily: 'SM',
                fontSize: 10,
                color: CustomColors.grey,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  AuthManager.logout();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => AuthBloc(),
                        child: LoginScreen(),
                      ),
                    ),
                  );
                },
                child: const Text('خروج')),
            // const Padding(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: 20,
            //     vertical: 20,
            //   ),
            //   child: Directionality(
            //     textDirection: TextDirection.rtl,
            //     child: Wrap(
            //       spacing: 30,
            //       runSpacing: 20,
            //       children: [
            //         CategoryItemChip(),
            //         CategoryItemChip(),
            //         CategoryItemChip(),
            //         CategoryItemChip(),
            //         CategoryItemChip(),
            //         CategoryItemChip(),
            //         CategoryItemChip(),
            //         CategoryItemChip(),
            //         CategoryItemChip(),
            //         CategoryItemChip(),
            //         CategoryItemChip(),
            //       ],
            //     ),
            //   ),
            // ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Column(
                children: [
                  Text(
                    'اپل شاپ',
                    style: TextStyle(
                      color: CustomColors.grey,
                      fontSize: 10,
                      fontFamily: 'SM',
                    ),
                  ),
                  Text(
                    'v-1.0.00',
                    style: TextStyle(
                      color: CustomColors.grey,
                      fontSize: 10,
                      fontFamily: 'SM',
                    ),
                  ),
                  Text(
                    'Instagram.com/Mojava-dev',
                    style: TextStyle(
                      color: CustomColors.grey,
                      fontSize: 10,
                      fontFamily: 'SM',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
