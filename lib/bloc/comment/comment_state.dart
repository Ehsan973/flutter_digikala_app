part of 'comment_bloc.dart';

abstract class CommentState {}

class CommentInitialState extends CommentState {}

class CommentLoading extends CommentState {}

class CommentResponse extends CommentState {
  Either<String, List<Comment>> commentEither;
  CommentResponse(this.commentEither);
}
