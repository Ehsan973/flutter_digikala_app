import 'package:digikala_app/data/model/comment.dart';
import 'package:digikala_app/di/di.dart';
import 'package:digikala_app/util/api_exeption.dart';
import 'package:digikala_app/util/auth_manager.dart';
import 'package:dio/dio.dart';

abstract class ICommentDatasource {
  Future<List<Comment>> getComments(String productId);
  Future<void> postComment(String productId, String comment);
}

class CommentRemoteDatasource extends ICommentDatasource {
  final Dio _dio = locator.get();
  final String userId = AuthManager.getId();
  @override
  Future<List<Comment>> getComments(String productId) async {
    try {
      Map<String, dynamic> qParams = {
        'filter': 'product_id="$productId"',
        'expand': 'user_id',
        'perPage': 200,
      };

      var response = await _dio.get(
        'collections/comment/records',
        queryParameters: qParams,
      );
      return response.data['items']
          .map<Comment>((jsonObject) => Comment.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'Unknown Error!');
    }
  }

  @override
  Future<void> postComment(String productId, String comment) async {
    try {
      final response = await _dio.post('collections/comment/records', data: {
        'text': comment,
        'user_id': userId,
        'product_id': productId,
      });
      print(response.data);
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'Unknown error!');
    }
  }
}
