import 'package:digikala_app/di/di.dart';
import 'package:digikala_app/util/api_exeption.dart';
import 'package:dio/dio.dart';

import '../model/banner.dart';

abstract class IBannerDatasource {
  Future<List<BannerHome>> getBanners();
}

class BannerRemoteDatasource extends IBannerDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<BannerHome>> getBanners() async {
    try {
      var response = await _dio.get('collections/banner/records');
      return response.data['items']
          .map<BannerHome>((jsonObject) => BannerHome.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'Unknown error!');
    }
  }
}
