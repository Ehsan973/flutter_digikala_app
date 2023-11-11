import 'package:dartz/dartz.dart';
import 'package:digikala_app/data/model/category.dart';
import 'package:digikala_app/data/model/product_image.dart';
import 'package:digikala_app/data/model/product_variant.dart';
import 'package:digikala_app/data/model/variant_type.dart';

abstract class ProductState {}

class ProductInitState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductResponseState extends ProductState {
  Either<String, List<ProductImage>> productImageEither;
  Either<String, List<ProductVariant>> productVariantEither;
  Either<String, Category> productCategoryEither;
  ProductResponseState(this.productImageEither, this.productVariantEither,
      this.productCategoryEither);
}
