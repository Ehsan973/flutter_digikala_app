import 'package:dartz/dartz.dart';
import 'package:digikala_app/data/model/product.dart';

import '../../di/di.dart';
import '../../util/api_exeption.dart';
import '../datasource/category_product_datasource.dart';

abstract class ICategoryProductRepository {
  Future<Either<String, List<Product>>> getProductByCategoryId(
      String categoryId);
}

class CatergoryProductRepository extends ICategoryProductRepository {
  final ICatergoryProductDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<Product>>> getProductByCategoryId(
      String categoryId) async {
    try {
      var response = await _datasource.getProductByCategoryId(categoryId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
