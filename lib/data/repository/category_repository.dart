import 'package:dartz/dartz.dart';
import 'package:digikala_app/data/model/category.dart';
import 'package:digikala_app/di/di.dart';
import 'package:digikala_app/util/api_exeption.dart';

import '../datasource/category_datasource.dart';

abstract class ICatergoryRepository {
  Future<Either<String, List<Category>>> getCategories();
}

class CategoryRepository extends ICatergoryRepository {
  final ICatergoryDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<Category>>> getCategories() async {
    try {
      var response = await _datasource.getCategories();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
