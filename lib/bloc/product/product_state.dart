import 'package:dartz/dartz.dart';
import 'package:digikala_app/data/model/product_image.dart';

abstract class ProductState {}

class ProductInitState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductResponseState extends ProductState {
  Either<String, List<ProductImage>> getProductImage;
  ProductResponseState(this.getProductImage);
}