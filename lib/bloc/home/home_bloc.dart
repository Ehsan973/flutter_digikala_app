import 'package:digikala_app/bloc/home/home_event.dart';
import 'package:digikala_app/bloc/home/home_state.dart';
import 'package:digikala_app/data/repository/banner_repository.dart';
import 'package:digikala_app/data/repository/category_repository.dart';
import 'package:digikala_app/data/repository/product_repository.dart';
import 'package:digikala_app/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository _bannerRepository = locator.get();
  final ICatergoryRepository _catergoryRepository = locator.get();
  final IProductRepository _productRepository = locator.get();
  HomeBloc() : super(HomeInitState()) {
    on<HomeGetInitialData>((event, emit) async {
      emit(HomeLoadingState());
      var bannerEither = await _bannerRepository.getBanners();
      var categoryEither = await _catergoryRepository.getCategories();
      var productEither = await _productRepository.getProducts();
      var bestSellerProductEither = await _productRepository.getBestSeller();
      var hottestProductEither = await _productRepository.getHottest();
      emit(
        HomeRequestSuccessState(bannerEither, categoryEither, productEither,
            bestSellerProductEither, hottestProductEither),
      );
    });
  }
}
