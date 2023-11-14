import 'package:dartz/dartz.dart';
import 'package:digikala_app/data/model/product.dart';

abstract class CategoryProductState {}

class CategoryProductLoadingState extends CategoryProductState {}

class CategoryProductResponseSuccessState extends CategoryProductState {
  Either<String, List<Product>> productListByCategoryEither;

  CategoryProductResponseSuccessState(this.productListByCategoryEither);
}
