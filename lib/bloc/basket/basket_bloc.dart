import 'package:digikala_app/bloc/basket/basket_event.dart';
import 'package:digikala_app/bloc/basket/basket_state.dart';
import 'package:digikala_app/data/repository/basket_repository.dart';
import 'package:digikala_app/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zarinpal/zarinpal.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IBasketRepository _repository = locator.get();
  PaymentRequest _paymentRequest = PaymentRequest();

  BasketBloc() : super(BasketInitState()) {
    on<BasketFetchFromHiveEvent>((event, emit) async {
      var basketItemListEither = await _repository.getAllBasketItems();
      var basketFinalPrice = await _repository.getBasketFinalPrice();
      emit(BasketDataFetchedState(basketItemListEither, basketFinalPrice));
    });

    on<BasketPaymentInitEvent>((event, emit) async {
      _paymentRequest.setIsSandBox(true);
      _paymentRequest.setAmount(1000);
      _paymentRequest.setDescription('This is for test Application Apple shop');
      _paymentRequest.setMerchantID(
          'd645fba8-1b29-11ea-be59-000c295eb8fc'); //Your merchant ID
      _paymentRequest.setCallbackURL('expertflutter://shop');
    });

    on<BasketPaymentRequestEvent>((event, emit) async {
      ZarinPal().startPayment(_paymentRequest, (status, paymentGatewayUri) {
        if (status == 100) {
          launchUrl(
            Uri.parse(paymentGatewayUri!),
            mode: LaunchMode.externalApplication,
          );
        }
      });
    });
  }
}
