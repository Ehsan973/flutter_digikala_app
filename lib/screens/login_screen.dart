import 'package:digikala_app/authentication/auth_bloc.dart';
import 'package:digikala_app/authentication/auth_event.dart';
import 'package:digikala_app/authentication/auth_state.dart';
import 'package:digikala_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: CustomColors.blue,
        body: Column(
          children: [
            const Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    width: 100,
                    height: 100,
                    image: AssetImage('assets/images/icon_application.png'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'اپل شاپ',
                    style: TextStyle(
                        fontFamily: 'SB', fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                margin: const EdgeInsets.all(20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _usernameTextController,
                      decoration: const InputDecoration(
                        labelText: 'نام کاربری',
                        labelStyle: TextStyle(
                          fontFamily: 'SM',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              BorderSide(color: CustomColors.blue, width: 3),
                        ),
                        floatingLabelStyle: TextStyle(
                          color: CustomColors.blue,
                          fontSize: 18,
                          fontFamily: 'SB',
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: _passwordTextController,
                      decoration: const InputDecoration(
                        labelText: 'رمز عبور',
                        labelStyle: TextStyle(
                          fontFamily: 'SM',
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide:
                              BorderSide(color: CustomColors.blue, width: 3),
                        ),
                        floatingLabelStyle: TextStyle(
                          color: CustomColors.blue,
                          fontSize: 18,
                          fontFamily: 'SB',
                        ),
                      ),
                    ),
                    const Spacer(),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthInitialState) {
                          return ElevatedButton(
                            onPressed: () {
                              var username = _usernameTextController.text;
                              var password = _passwordTextController.text;
                              BlocProvider.of<AuthBloc>(context)
                                  .add(AuthLoginRequest(username, password));
                            },
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(
                                fontFamily: 'SB',
                                fontSize: 18,
                              ),
                              minimumSize: const Size(250, 48),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                            child: const Text('ورود به حساب کاربری'),
                          );
                        } else if (state is AuthLoadingState) {
                          return const CircularProgressIndicator();
                        } else if (state is AuthResponseState) {
                          var widget = Text('');
                          state.response.fold(
                            (l) {
                              widget = Text(l);
                            },
                            (r) {
                              widget = Text(r);
                            },
                          );

                          return widget;
                        }

                        return Text('خطای نا مشخص');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
