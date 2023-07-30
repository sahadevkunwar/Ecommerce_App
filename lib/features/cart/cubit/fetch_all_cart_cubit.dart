import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/features/cart/cubit/update_cart_quantity_cubit.dart';

import '../../checkout/cubit/create_order_cubit.dart';
import '../models/cart.dart';
import '../resources/cart_repository.dart';

class FetchAllCartCubit extends Cubit<CommonState> {
  final CartRepository cartRepository;

  final UpdateCartQuantityCubit updateCartQuantityCubit;
  StreamSubscription? updateSubscription;

  final CreateOrderCubit createOrderCubit;
  StreamSubscription? orderSubscription;

  FetchAllCartCubit({
    required this.cartRepository,
    required this.updateCartQuantityCubit,
    required this.createOrderCubit,
  }) : super(CommonInitialState()) {
    updateSubscription = updateCartQuantityCubit.stream.listen((event) {
      if (event is CommonSuccessState<Cart>) {
        final oldData = [...cartRepository.cart];
        final index = oldData.indexWhere((e) => e.id == event.item.id);
        if (index != -1) {
          oldData[index] = event.item;
          emit(CommonLoadingState());
          emit(CommonSuccessState<List<Cart>>(item: oldData));
        }
      }
    });

    orderSubscription = createOrderCubit.stream.listen((event) {
      if (event is CommonSuccessState) {
        fetch();
      }
    });
  }

  fetch() async {
    emit(CommonLoadingState());
    final res = await cartRepository.fetchCarts();
    res.fold(
      (error) => emit(CommonErrorState(message: error)),
      (data) => emit(CommonSuccessState<List<Cart>>(item: data)),
    );
  }

  @override
  Future<void> close() {
    updateSubscription?.cancel();
    orderSubscription?.cancel();
    return super.close();
  }
}
