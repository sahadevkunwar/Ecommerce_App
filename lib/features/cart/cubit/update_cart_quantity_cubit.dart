import 'package:ecommerce_project/features/cart/models/cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/bloc/common_state.dart';
import '../resources/cart_repository.dart';

class UpdateCartQuantityCubit extends Cubit<CommonState> {
  final CartRepository cartRepository;

  UpdateCartQuantityCubit({required this.cartRepository})
      : super(CommonInitialState());

  update({required Cart cart, required int quantity}) async {
    emit(CommonLoadingState());
    emit(
      CommonSuccessState<Cart>(
        item: Cart(
          id: cart.id,
          quantity: quantity,
          product: cart.product,
        ),
      ),
    );
    final res = await cartRepository.updateCartsQuantity(
      cartId: cart.id,
      quantity: quantity,
    );
    res.fold((error) {
      emit(CommonErrorState(message: error));
      emit(CommonSuccessState<Cart>(item: cart));
    }, (data) => null);
  }
}
