import 'package:digikala_app/data/model/basket_item.dart';
import 'package:hive_flutter/adapters.dart';

abstract class IBasketDatasource {
  Future<void> addProduct(BasketItem basketItem);
  Future<List<BasketItem>> getAllBasketItems();
  Future<int> getBasketFinalPrice();
  Future<void> removeProduct(int index);
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

  @override
  Future<int> getBasketFinalPrice() async {
    var productList = box.values.toList();
    var finalPrice = productList.fold(
        0, (accumulator, product) => accumulator + product.realPrice!);

    return finalPrice;
  }

  @override
  Future<void> removeProduct(int index) async {
    box.delete(index);
  }
}
