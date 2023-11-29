part of 'comment_bloc.dart';

abstract class CommentState {}

class CommentInitialState extends CommentState {}

class CommentLoading extends CommentState {}

class CommentResponse extends CommentState {
  Either<String, List<Comment>> commentEither;
  CommentResponse(this.commentEither);
}

class CommentPostLoading extends CommentState {
  final bool isLoading;
  CommentPostLoading(this.isLoading);
}

class CommentPostResponse extends CommentState {
  final Either<String, String> postEither;

  CommentPostResponse(this.postEither);
}
