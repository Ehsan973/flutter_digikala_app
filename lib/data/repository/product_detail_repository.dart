import 'package:dartz/dartz.dart';
import 'package:digikala_app/data/datasource/product_detail_datasource.dart';
import 'package:digikala_app/data/model/product_image.dart';
import 'package:digikala_app/di/di.dart';
import 'package:digikala_app/util/api_exeption.dart';

abstract class IDetailProductRepository {
  Future<Either<String, List<ProductImage>>> getProductImage();
}

class DetailProductRepository extends IDetailProductRepository {
  final IDetailProductDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<ProductImage>>> getProductImage() async {
    try {
      var response = await _datasource.getGallery();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
