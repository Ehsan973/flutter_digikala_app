import 'package:digikala_app/data/model/basket_item.dart';
import 'package:hive_flutter/adapters.dart';

abstract class IBasketDatasource {
  Future<void> addProduct(BasketItem basketItem);
  Future<List<BasketItem>> getAllBasketItems();
}

class BasketLocalDatasouce extends IBasketDatasource {
  var box = Hive.box<BasketItem>('CartBox');

  @override
  Future<void> addProduct(BasketItem basketItem) async {
    box.add(basketItem);
  }

  @override
  Future<List<BasketItem>> getAllBasketItems() async {
    return box.values.toList();
  }
}
