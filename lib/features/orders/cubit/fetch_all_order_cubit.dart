import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/features/orders/model/order.dart';
import 'package:ecommerce_project/features/orders/resources/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchAllOrderCubit extends Cubit<CommonState> {
  final OrderRepository orderRepository;
  FetchAllOrderCubit({required this.orderRepository})
      : super(CommonInitialState());

  fetch() async {
    emit(CommonLoadingState());
    final res = await orderRepository.fetchOrder();
    res.fold((error) => emit(CommonErrorState(message: error)),
        (data) => emit(CommonSuccessState<List<ProductOrder>>(item: data)));
  }
}
