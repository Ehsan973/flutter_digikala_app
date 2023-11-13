import 'package:digikala_app/bloc/product/product_event.dart';
import 'package:digikala_app/bloc/product/product_state.dart';
import 'package:digikala_app/data/repository/product_detail_repository.dart';
import 'package:digikala_app/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IDetailProductRepository _repository = locator.get();
  ProductBloc() : super(ProductInitState()) {
    on<ProductInitializEvent>((event, emit) async {
      emit(ProductLoadingState());
      var productImageEither =
          await _repository.getProductImage(event.productId);
      var productVariantsEither =
          await _repository.getProductVariants(event.productId);
      var productCategory =
          await _repository.getProductCategory(event.categoryId);
      var productProperties = await _repository.getProperties(event.productId);
      emit(
        ProductResponseState(productImageEither, productVariantsEither,
            productCategory, productProperties),
      );
    });
  }
}
