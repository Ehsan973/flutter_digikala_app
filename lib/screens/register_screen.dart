import 'package:digikala_app/bloc/authentication/auth_bloc.dart';
import 'package:digikala_app/bloc/authentication/auth_event.dart';
import 'package:digikala_app/bloc/authentication/auth_state.dart';
import 'package:digikala_app/constants/colors.dart';
import 'package:digikala_app/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _usernameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _passwordConfirmTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewContainer(
        usernameTextController: _usernameTextController,
        passwordTextController: _passwordTextController,
        passwordConfirmTextController: _passwordConfirmTextController);
  }
}

class ViewContainer extends StatelessWidget {
  const ViewContainer({
    super.key,
    required TextEditingController usernameTextController,
    required TextEditingController passwordTextController,
    required TextEditingController passwordConfirmTextController,
  })  : _usernameTextController = usernameTextController,
        _passwordTextController = passwordTextController,
        _passwordConfirmTextController = passwordConfirmTextController;

  final TextEditingController _usernameTextController;
  final TextEditingController _passwordTextController;
  final TextEditingController _passwordConfirmTextController;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            const SizedBox(
              height: 200,
              child: Image(
                image: AssetImage('assets/images/register.jpg'),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'تکرار رمز عبور',
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
                      controller: _passwordConfirmTextController,
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
            const Spacer(),
            BlocConsumer<AuthBloc, AuthState>(
              listener: ((context, state) {
                if (state is AuthResponseState) {
                  state.response.fold((l) {}, (r) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const DashBoardScreen(),
                      ),
                    );
                  });
                }
              }),
              builder: (context, state) {
                if (state is AuthInitialState) {
                  return ElevatedButton(
                    onPressed: () {
                      var username = _usernameTextController.text;
                      var password = _passwordTextController.text;
                      var passwordConfirm = _passwordConfirmTextController.text;
                      BlocProvider.of<AuthBloc>(context).add(
                        AuthRegisterRequest(
                            username, password, passwordConfirm),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      minimumSize: const Size(250, 48),
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: const Text(
                      'ثبت نام',
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
                  var widget = const Text('');
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

                return const Text('خطای نا مشخص');
              },
            ),
            const SizedBox(
              height: 48,
            ),
          ],
        ),
      ),
    );
  }
}
