import 'package:bloc/bloc.dart';
import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/features/homepage/model/product.dart';

import '../resource/product_repository.dart';

class FetchProductDetailCubit extends Cubit<CommonState> {
  final ProductRepository productRepository;

  FetchProductDetailCubit({required this.productRepository})
      : super(CommonInitialState());

  fetchProductDetails({required String productId}) async {
    emit(CommonLoadingState());
    final res =
        await productRepository.fetchProductDetails(productId: productId);
    res.fold(
      (error) => emit(CommonErrorState(message: error)),
      (data) => emit(CommonSuccessState<Product>(item: data)),
    );
  }
}
