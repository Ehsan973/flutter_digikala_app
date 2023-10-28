import 'package:dartz/dartz.dart';
import 'package:digikala_app/data/datasource/banner_datasource.dart';
import 'package:digikala_app/data/model/banner.dart';
import 'package:digikala_app/di/di.dart';
import 'package:digikala_app/util/api_exeption.dart';

abstract class IBannerRepository {
  Future<Either<String, List<Banner>>> getBanners();
}

class BannerRepository extends IBannerRepository {
  final IBannerDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<Banner>>> getBanners() async {
    try {
      var response = await _datasource.getBanners();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
}
