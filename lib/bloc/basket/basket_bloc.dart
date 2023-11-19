import 'package:digikala_app/bloc/basket/basket_event.dart';
import 'package:digikala_app/bloc/basket/basket_state.dart';
import 'package:digikala_app/data/repository/basket_repository.dart';
import 'package:digikala_app/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IBasketRepository _repository = locator.get();
  BasketBloc() : super(BasketInitState()) {
    on<BasketFetchFromHiveEvent>((event, emit) async {
      var basketItemListEither = await _repository.getAllBasketItems();
      emit(BasketDataFetchedState(basketItemListEither));
    });
  }
}
