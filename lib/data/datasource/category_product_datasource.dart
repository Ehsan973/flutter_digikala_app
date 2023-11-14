import 'package:digikala_app/data/model/product.dart';
import 'package:digikala_app/di/di.dart';
import 'package:dio/dio.dart';

import '../../util/api_exeption.dart';

abstract class ICatergoryProductDatasource {
  Future<List<Product>> getProductByCategoryId(String categoryId);
}

class CategoryProductRemoteDatasource extends ICatergoryProductDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<Product>> getProductByCategoryId(String categoryId) async {
    try {
      Map<String, String> qParams = {
        'filter': 'category="$categoryId"',
      };
      Response<dynamic> response;
      if (categoryId == '78q8w901e6iipuk') {
        response = await _dio.get('collections/products/records');
      } else {
        response = await _dio.get('collections/products/records',
            queryParameters: qParams);
      }
      return response.data['items']
          .map<Product>((jsonObject) => Product.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'Unknown Error!');
    }
  }
}
