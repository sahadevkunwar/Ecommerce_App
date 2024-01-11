import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/features/homepage/cubit/fetch_product_event.dart';
import 'package:ecommerce_project/features/homepage/model/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../resource/product_repository.dart';

class FetchProductCubit extends Bloc<ProductEvent, CommonState> {
  final ProductRepository productRepository;

  FetchProductCubit({required this.productRepository})
      : super(CommonInitialState()) {
    on<FetchProductEvent>((event, emit) async {
      emit(CommonLoadingState());
      final res = await productRepository.fetchProduct(query: event.query);
      res.fold(
        (error) => emit(CommonErrorState(message: error)),
        (data) => emit(CommonSuccessState<List<Product>>(item: data)),
      );
    });

    on<RefreshProductEvent>((event, emit) async {
      emit(CommonLoadingState(showLoading: false));
      final _ = await productRepository.fetchProduct(query: event.query);
      emit(CommonSuccessState<List<Product>>(item: productRepository.items));
    });
    on<LoadMoreProductEvent>(
      (event, emit) async {
        emit(CommonLoadingState(showLoading: false));
        final _ = await productRepository.fetchProduct(isLoadMore: true,query: event.query);
        emit(CommonSuccessState<List<Product>>(item: productRepository.items));
      },
      transformer: droppable(),
    );
  }

// fetchProduct() async {
//   emit(CommonLoadingState());
//   final res = await productRepository.fetchProduct();
//   res.fold((error) => emit(CommonErrorState(message: error)),
//       (data) => emit(CommonSuccessState<List<Product>>(item: data)));
// }

// refreshProduct() async {
//   emit(CommonLoadingState(showLoading: false));
//   final _ = await productRepository.fetchProduct();
//   emit(CommonSuccessState<List<Product>>(item: productRepository.items));
// }
}
