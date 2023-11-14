import 'package:bloc/bloc.dart';
import 'package:digikala_app/bloc/categoryProduct/category_product_event.dart';
import 'package:digikala_app/bloc/categoryProduct/category_product_state.dart';
import 'package:digikala_app/data/repository/category_product_repository.dart';
import 'package:digikala_app/di/di.dart';

class CategoryProductBloc
    extends Bloc<CategoryProductEvent, CategoryProductState> {
  final ICategoryProductRepository _repository = locator.get();
  CategoryProductBloc() : super(CategoryProductLoadingState()) {
    on<CategoryProductInitialize>((event, emit) async {
      var productListByCategoryEither =
          await _repository.getProductByCategoryId(event.categoryId);
      emit(CategoryProductResponseSuccessState(productListByCategoryEither));
    });
  }
}
