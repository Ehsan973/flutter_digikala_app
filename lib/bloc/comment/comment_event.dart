part of 'comment_bloc.dart';

abstract class CommentEvent {}

class CommentinitializeEvent extends CommentEvent {
  String productId;
  CommentinitializeEvent(this.productId);
}
