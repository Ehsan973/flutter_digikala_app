import 'package:digikala_app/data/datasource/authentication_datasource.dart';
import 'package:digikala_app/data/datasource/category_datasource.dart';
import 'package:digikala_app/data/repository/authentication_repository.dart';
import 'package:digikala_app/data/repository/category_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.I;

Future<void> getItInit() async {
  locator.registerSingleton<Dio>(
    Dio(BaseOptions(baseUrl: 'http://startflutter.ir/api/')),
  );

  //dataSources
  locator
      .registerFactory<IAuthenticationDatasource>(() => AuthenticationRemote());
  locator
      .registerFactory<ICatergoryDatasource>(() => CategoryRemoteDatesource());

  //repositories
  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());
  locator.registerFactory<ICatergoryRepository>(() => CategoryRepository());

  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
}
