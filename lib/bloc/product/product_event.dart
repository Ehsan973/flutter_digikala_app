abstract class ProductEvent {}

class ProductInitializEvent extends ProductEvent {
  String productId;
  String categoryId;
  ProductInitializEvent(this.productId, this.categoryId);
}
