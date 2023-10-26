import 'package:digikala_app/di/di.dart';
import 'package:digikala_app/util/api_exeption.dart';
import 'package:dio/dio.dart';

import '../model/category.dart';

abstract class ICatergoryDatasource {
  Future<List<Category>> getCategories();
}

class CategoryRemoteDatesource extends ICatergoryDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<Category>> getCategories() async {
    try {
      var response = await _dio.get('collections/category/records');
      return response.data['items']
          .map<Category>((jsonObject) => Category.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'Unknown error!');
    }
  }
}
