import 'package:digikala_app/category/category_event.dart';
import 'package:digikala_app/category/category_state.dart';
import 'package:digikala_app/data/repository/category_repository.dart';
import 'package:digikala_app/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ICatergoryRepository _repository = locator.get();
  CategoryBloc() : super(CategoryInitialState()) {
    on<CategoryListRequest>((event, emit) async {
      emit(CategoryLoadingState());
      var either = await _repository.getCategories();
      emit(CategoryResponseState(either));
    });
  }
}
