import 'package:digikala_app/bloc/basket/basket_bloc.dart';
import 'package:digikala_app/data/datasource/authentication_datasource.dart';
import 'package:digikala_app/data/datasource/banner_datasource.dart';
import 'package:digikala_app/data/datasource/basket_datasource.dart';
import 'package:digikala_app/data/datasource/category_datasource.dart';
import 'package:digikala_app/data/datasource/category_product_datasource.dart';
import 'package:digikala_app/data/datasource/product_datasource.dart';
import 'package:digikala_app/data/datasource/product_detail_datasource.dart';
import 'package:digikala_app/data/repository/authentication_repository.dart';
import 'package:digikala_app/data/repository/banner_repository.dart';
import 'package:digikala_app/data/repository/basket_repository.dart';
import 'package:digikala_app/data/repository/category_product_repository.dart';
import 'package:digikala_app/data/repository/category_repository.dart';
import 'package:digikala_app/data/repository/product_detail_repository.dart';
import 'package:digikala_app/data/repository/product_repository.dart';
import 'package:digikala_app/util/payment_handler.dart';
import 'package:digikala_app/util/url_handler.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.I;

Future<void> getItInit() async {
  await _initComponents();

  //dataSources
  _initDatasources();

  //repositories
  _initRepositories();

  // bloc
  locator
      .registerSingleton<BasketBloc>(BasketBloc(locator.get(), locator.get()));
}

Future<void> _initComponents() async {
  locator.registerSingleton<UrlHandler>(UrlLauncher());
  locator
      .registerSingleton<PaymentHandler>(ZarinpalPaymentHandler(locator.get()));
  locator.registerSingleton<Dio>(
    Dio(BaseOptions(baseUrl: 'http://startflutter.ir/api/')),
  );
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
}

void _initDatasources() {
  locator
      .registerFactory<IAuthenticationDatasource>(() => AuthenticationRemote());
  locator
      .registerFactory<ICatergoryDatasource>(() => CategoryRemoteDatesource());
  locator.registerFactory<IBannerDatasource>(() => BannerRemoteDatasource());
  locator.registerFactory<IProductDatasource>(() => ProductRemoteDatasource());
  locator.registerFactory<IDetailProductDatasource>(
      () => DetailProductRemoteDatasource());
  locator.registerFactory<ICatergoryProductDatasource>(
      () => CategoryProductRemoteDatasource());
  locator.registerFactory<IBasketDatasource>(() => BasketLocalDatasouce());
}

void _initRepositories() {
  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());
  locator.registerFactory<ICatergoryRepository>(() => CategoryRepository());
  locator.registerFactory<IBannerRepository>(() => BannerRepository());
  locator.registerFactory<IProductRepository>(() => ProductRepository());
  locator.registerFactory<IDetailProductRepository>(
      () => DetailProductRepository());
  locator.registerFactory<ICategoryProductRepository>(
      () => CatergoryProductRepository());
  locator.registerFactory<IBasketRepository>(() => BasketRepository());
}
