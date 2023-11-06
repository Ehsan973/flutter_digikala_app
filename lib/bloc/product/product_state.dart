import 'package:dartz/dartz.dart';
import 'package:digikala_app/data/model/product_image.dart';
import 'package:digikala_app/data/model/variant_type.dart';

abstract class ProductState {}

class ProductInitState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductResponseState extends ProductState {
  Either<String, List<ProductImage>> productImage;
  Either<String, List<VariantType>> variantTypes;
  ProductResponseState(this.productImage, this.variantTypes);
}
