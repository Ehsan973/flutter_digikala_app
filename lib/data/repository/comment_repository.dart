import 'package:dartz/dartz.dart';
import 'package:digikala_app/data/datasource/comment_datasource.dart';
import 'package:digikala_app/data/model/comment.dart';
import 'package:digikala_app/di/di.dart';
import 'package:digikala_app/util/api_exeption.dart';

abstract class ICommentRepository {
  Future<Either<String, List<Comment>>> getComments(String productId);
  Future<Either<String, String>> postComment(String productId, String comment);
}

class CommentRepository extends ICommentRepository {
  final ICommentDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<Comment>>> getComments(String productId) async {
    try {
      var response = await _datasource.getComments(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message ?? 'پیام محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> postComment(
      String productId, String comment) async {
    try {
      var response = await _datasource.postComment(productId, comment);
      return right('نظر شما اضافه شد');
    } on ApiException catch (ex) {
      return left(ex.message ?? 'پیام محتوای متنی ندارد');
    }
  }
}
