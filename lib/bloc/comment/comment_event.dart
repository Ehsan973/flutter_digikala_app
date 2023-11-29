part of 'comment_bloc.dart';

abstract class CommentEvent {}

class CommentinitializeEvent extends CommentEvent {
  String productId;
  CommentinitializeEvent(this.productId);
}

class CommentPostEvent extends CommentEvent {
  final String productId;
  final String comment;
  CommentPostEvent(this.productId, this.comment);
}
