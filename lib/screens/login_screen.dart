import 'package:digikala_app/bloc/authentication/auth_bloc.dart';
import 'package:digikala_app/bloc/authentication/auth_event.dart';
import 'package:digikala_app/bloc/authentication/auth_state.dart';
import 'package:digikala_app/constants/colors.dart';
import 'package:digikala_app/main.dart';
import 'package:digikala_app/screens/dashboard_screen.dart';
import 'package:digikala_app/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: ViewContainer(
          usernameTextController: _usernameTextController,
          passwordTextController: _passwordTextController),
    );
  }
}

class ViewContainer extends StatelessWidget {
  const ViewContainer({
    super.key,
    required TextEditingController usernameTextController,
    required TextEditingController passwordTextController,
  })  : _usernameTextController = usernameTextController,
        _passwordTextController = passwordTextController;

  final TextEditingController _usernameTextController;
  final TextEditingController _passwordTextController;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                const SizedBox(
                  height: 200,
                  child: Image(
                    image: AssetImage('assets/images/login_photo.jpg'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'نام کاربری',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'sm',
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(color: Colors.grey[300]),
                        child: TextField(
                          controller: _usernameTextController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'رمز عبور',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'sm',
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(color: Colors.grey[300]),
                        child: TextField(
                          controller: _passwordTextController,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // const Spacer(),
                const SizedBox(
                  height: 120,
                ),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: ((context, state) {
                    //logic
                    //toast //snack //dialog //navigate
                    if (state is AuthResponseState) {
                      state.response.fold(
                        (l) {
                          _usernameTextController.text = '';
                          _passwordTextController.text = '';
                          var snackBar = SnackBar(
                            content: Text(l),
                            backgroundColor: Colors.amber,
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 3),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          BlocProvider.of<AuthBloc>(context)
                              .add(AuthInitialize());
                        },
                        (r) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const DashBoardScreen(),
                            ),
                          );
                        },
                      );
                    }
                  }),
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
                          backgroundColor: Colors.blue[700],
                          minimumSize: const Size(250, 48),
                          shape: const RoundedRectangleBorder(),
                        ),
                        child: const Text(
                          'ورود به حساب کاربری',
                          style: TextStyle(
                            fontFamily: 'SB',
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      );
                    } else if (state is AuthLoadingState) {
                      return const CircularProgressIndicator();
                    } else if (state is AuthResponseState) {
                      Widget widget = const Text('');
                      state.response.fold(
                        (l) {
                          widget = ElevatedButton(
                            onPressed: () {
                              var username = _usernameTextController.text;
                              var password = _passwordTextController.text;
                              BlocProvider.of<AuthBloc>(context)
                                  .add(AuthLoginRequest(username, password));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[700],
                              minimumSize: const Size(250, 48),
                              shape: const RoundedRectangleBorder(),
                            ),
                            child: const Text(
                              'ورود به حساب کاربری',
                              style: TextStyle(
                                fontFamily: 'SB',
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                        (r) {
                          widget = Text(r);
                        },
                      );

                      return widget;
                    }

                    return const Text('خطای نا مشخص');
                  },
                ),
                const SizedBox(
                  height: 18,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text('اگر حساب کاربری ندارید، ثبت نام کنید'),
                ),
                const SizedBox(
                  height: 48,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
