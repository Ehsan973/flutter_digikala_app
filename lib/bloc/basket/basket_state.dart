import 'package:dartz/dartz.dart';
import 'package:digikala_app/data/model/basket_item.dart';

abstract class BasketState {}

class BasketInitState extends BasketState {}

class BasketDataFetchedState extends BasketState {
  Either<String, List<BasketItem>> basketItemListEither;
  BasketDataFetchedState(this.basketItemListEither);
}
