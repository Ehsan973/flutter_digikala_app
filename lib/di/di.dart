import 'package:digikala_app/data/datasource/authentication_datasource.dart';
import 'package:digikala_app/data/datasource/banner_datasource.dart';
import 'package:digikala_app/data/datasource/category_datasource.dart';
import 'package:digikala_app/data/datasource/product_datasource.dart';
import 'package:digikala_app/data/repository/authentication_repository.dart';
import 'package:digikala_app/data/repository/banner_repository.dart';
import 'package:digikala_app/data/repository/category_repository.dart';
import 'package:digikala_app/data/repository/product_repository.dart';
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
  locator.registerFactory<IBannerDatasource>(() => BannerRemoteDatasource());
  locator.registerFactory<IProductDatasource>(() => ProductRemoteDatasource());

  //repositories
  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());
  locator.registerFactory<ICatergoryRepository>(() => CategoryRepository());
  locator.registerFactory<IBannerRepository>(() => BannerRepository());
  locator.registerFactory<IProductRepository>(() => ProductRepository());

  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
}
