import 'package:dartz/dartz.dart';
import 'package:digikala_app/data/datasource/product_datasource.dart';
import 'package:digikala_app/data/model/product.dart';
import 'package:digikala_app/di/di.dart';
import 'package:digikala_app/util/api_exeption.dart';

abstract class IProductRepository {
  Future<Either<String, List<Product>>> getProducts();
}

class ProductRepository extends IProductRepository {
  final IProductDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<Product>>> getProducts() async {
    try {
      var response = await _datasource.getProducts();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
