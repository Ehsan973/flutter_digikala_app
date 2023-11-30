import 'package:dartz/dartz.dart';
import 'package:digikala_app/data/model/comment.dart';
import 'package:digikala_app/data/repository/comment_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'comment_state.dart';
part 'comment_event.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final ICommentRepository _repository;
  CommentBloc(this._repository) : super(CommentLoading()) {
    on<CommentinitializeEvent>((event, emit) async {
      final commentEither = await _repository.getComments(event.productId);
      emit(CommentResponse(commentEither));
    });

    on<CommentPostEvent>((event, emit) async {
      emit(CommentLoading());
      await _repository.postComment(event.productId, event.comment);
      final commentEither = await _repository.getComments(event.productId);
      emit(CommentResponse(commentEither));
    });
  }
}
