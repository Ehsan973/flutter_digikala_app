import 'package:digikala_app/data/model/product.dart';

abstract class ProductEvent {}

class ProductInitializEvent extends ProductEvent {
  String productId;
  String categoryId;
  ProductInitializEvent(this.productId, this.categoryId);
}

class ProductAddToBasket extends ProductEvent {
  Product product;
  ProductAddToBasket(this.product);
}
