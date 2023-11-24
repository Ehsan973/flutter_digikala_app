import 'package:digikala_app/bloc/basket/basket_event.dart';
import 'package:digikala_app/bloc/basket/basket_state.dart';
import 'package:digikala_app/data/repository/basket_repository.dart';
import 'package:digikala_app/util/payment_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IBasketRepository _repository;
  final PaymentHandler _paymentHandler;

  BasketBloc(this._repository, this._paymentHandler)
      : super(BasketInitState()) {
    on<BasketFetchFromHiveEvent>((event, emit) async {
      var basketItemListEither = await _repository.getAllBasketItems();
      var basketFinalPrice = await _repository.getBasketFinalPrice();
      emit(BasketDataFetchedState(basketItemListEither, basketFinalPrice));
    });

    on<BasketPaymentInitEvent>((event, emit) async {
      _paymentHandler.initPaymentRequest();
    });

    on<BasketPaymentRequestEvent>((event, emit) async {
      _paymentHandler.sendPaymentRequest();
    });
  }
}
