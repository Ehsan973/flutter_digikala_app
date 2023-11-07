import 'dart:convert';

import 'package:digikala_app/data/model/product_image.dart';
import 'package:digikala_app/data/model/product_variant.dart';
import 'package:digikala_app/data/model/variant.dart';
import 'package:digikala_app/data/model/variant_type.dart';
import 'package:digikala_app/di/di.dart';
import 'package:digikala_app/util/api_exeption.dart';
import 'package:dio/dio.dart';

abstract class IDetailProductDatasource {
  Future<List<ProductImage>> getGallery();
  Future<List<VariantType>> getVariantTypes();
  Future<List<Variant>> getVariants();
  Future<List<ProductVariant>> getProductVariant();
}

class DetailProductRemoteDatasource extends IDetailProductDatasource {
  final Dio _dio = locator.get();

  @override
  Future<List<ProductImage>> getGallery() async {
    try {
      Map<String, String> qParams = {
        'filter': 'product_id="0tc0e5ju89x5ogj"',
      };
      var response = await _dio.get(
        'collections/gallery/records',
        queryParameters: qParams,
      );
      return response.data['items']
          .map<ProductImage>((jsonObject) => ProductImage.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'Unknown Error!');
    }
  }

  @override
  Future<List<VariantType>> getVariantTypes() async {
    try {
      var response = await _dio.get('collections/variants_type/records');

      return response.data['items']
          .map<VariantType>((jsonObject) => VariantType.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'Unknown Error!');
    }
  }

  @override
  Future<List<Variant>> getVariants() async {
    try {
      Map<String, String> qParams = {
        'filter': 'product_id="0tc0e5ju89x5ogj"',
      };
      var response = await _dio.get('collections/variants/records');
      return response.data['items']
          .map<Variant>((jsonObject) => Variant.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'Unknown Error!');
    }
  }

  @override
  Future<List<ProductVariant>> getProductVariant() async {
    var variantTypeList = await getVariantTypes();
    var variantList = await getVariants();

    List<ProductVariant> productVariantList = [];

    for (var variantType in variantTypeList) {
      var variantList1 = variantList
          .where((element) => element.typeId == variantType.id)
          .toList();
      productVariantList.add(ProductVariant(variantType, variantList1));
    }

    return productVariantList;
  }
}
