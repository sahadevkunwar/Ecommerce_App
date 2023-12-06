import 'dart:io';

import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/features/homepage/resource/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductCubit extends Cubit<CommonState> {
  final ProductRepository productRepository;
  AddProductCubit({required this.productRepository})
      : super(CommonInitialState());

  addProduct({
    required String name,
    required File image,
    required String description,
    required String brand,
    required int price,
    required List<String> catagories,
  }) async {
    emit(CommonLoadingState());
    final res = await productRepository.addProduct(
      name: name,
      image: image,
      description: description,
      brand: brand,
      price: price,
      catagories: catagories,
    );
    res.fold(
      (error) => emit(CommonErrorState(message: error)),
      (data) => emit(CommonSuccessState(item: null)),
    );
  }
}
