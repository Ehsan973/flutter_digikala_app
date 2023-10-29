import 'package:dartz/dartz.dart';
import 'package:digikala_app/data/model/banner.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeRequestSuccessState extends HomeState {
  Either<String, List<BannerHome>> bannerEither;
  HomeRequestSuccessState(this.bannerEither);
}
