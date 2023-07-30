import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../orders/resources/order_repository.dart';

class CreateOrderCubit extends Cubit<CommonState> {
  final OrderRepository orderRepository;

  CreateOrderCubit({required this.orderRepository})
      : super(CommonInitialState());

  create({
    required String fullName,
    required String phone,
    required String city,
    required String address,
  }) async {
    emit(CommonLoadingState());
    final res = await orderRepository.createOrder(
        fullName: fullName, phone: phone, address: address, city: city);
    res.fold((error) => emit(CommonErrorState(message: error)),
        (data) => emit(CommonSuccessState(item: null)));
  }
}
