import 'package:bloc/bloc.dart';
import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/features/homepage/model/product.dart';

import '../resource/product_repository.dart';

class FetchProductDetailCubit extends Cubit<CommonState> {
  final ProductRepository productRepository;

  FetchProductDetailCubit({required this.productRepository})
      : super(CommonInitialState());

// Flag to indicate whether to fetch product details
  // bool shouldFetchDetails = true;

  fetchProductDetails({required String productId}) async {
    // if (shouldFetchDetails) {
    emit(CommonLoadingState());
    final res =
        await productRepository.fetchProductDetails(productId: productId);
    res.fold(
      (error) => emit(CommonErrorState(message: error)),
      (data) => emit(CommonSuccessState<Product>(item: data)),
    );

    // Reset the flag to avoid repeated fetching
    // shouldFetchDetails = false;
    // }
  }
}
