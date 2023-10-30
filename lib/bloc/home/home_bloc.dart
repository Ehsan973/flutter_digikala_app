import 'package:digikala_app/bloc/home/home_event.dart';
import 'package:digikala_app/bloc/home/home_state.dart';
import 'package:digikala_app/data/repository/banner_repository.dart';
import 'package:digikala_app/data/repository/category_repository.dart';
import 'package:digikala_app/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository _bannerRepository = locator.get();
  final ICatergoryRepository _catergoryRepository = locator.get();
  HomeBloc() : super(HomeInitState()) {
    on<HomeGetInitialData>((event, emit) async {
      emit(HomeLoadingState());
      var bannerEither = await _bannerRepository.getBanners();
      var categoryEither = await _catergoryRepository.getCategories();
      emit(HomeRequestSuccessState(bannerEither, categoryEither));
    });
  }
}
