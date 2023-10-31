import 'package:digikala_app/data/model/product.dart';
import 'package:digikala_app/di/di.dart';
import 'package:digikala_app/util/api_exeption.dart';
import 'package:dio/dio.dart';

abstract class IProductDatasource {
  Future<List<Product>> getProducts();
}

class ProductRemoteDatasource extends IProductDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<Product>> getProducts() async {
    try {
      var response = await _dio.get('collections/products/records');
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
