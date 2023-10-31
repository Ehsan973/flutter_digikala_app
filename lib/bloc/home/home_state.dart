import 'package:dartz/dartz.dart';
import 'package:digikala_app/data/model/banner.dart';
import 'package:digikala_app/data/model/product.dart';

import '../../data/model/category.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeRequestSuccessState extends HomeState {
  Either<String, List<BannerHome>> bannerEither;
  Either<String, List<Category>> categoryEither;
  Either<String, List<Product>> productEither;
  HomeRequestSuccessState(
      this.bannerEither, this.categoryEither, this.productEither);
}
