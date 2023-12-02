import 'package:digikala_app/bloc/authentication/auth_bloc.dart';
import 'package:digikala_app/data/model/basket_item.dart';
import 'package:digikala_app/di/di.dart';
import 'package:digikala_app/screens/dashboard_screen.dart';
import 'package:digikala_app/screens/login_screen.dart';
import 'package:digikala_app/util/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BasketItemAdapter());
  await Hive.openBox<BasketItem>('CartBox');
  await getItInit();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthManager.readAuth().isEmpty
          ? BlocProvider(
              create: (context) => AuthBloc(),
              child: LoginScreen(),
            )
          : const DashBoardScreen(),
    );
  }
}
