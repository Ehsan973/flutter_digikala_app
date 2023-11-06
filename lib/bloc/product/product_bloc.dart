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
      var productImageEither = await _repository.getProductImage();
      var variantTypesEither = await _repository.getVariantTypes();
      emit(ProductResponseState(productImageEither, variantTypesEither));
    });
  }
}
