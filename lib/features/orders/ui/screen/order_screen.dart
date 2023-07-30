import 'package:ecommerce_project/features/orders/cubit/fetch_all_order_cubit.dart';
import 'package:ecommerce_project/features/orders/resources/order_repository.dart';
import 'package:ecommerce_project/features/orders/ui/widgets/order_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FetchAllOrderCubit(orderRepository: context.read<OrderRepository>())
            ..fetch(),
      child: const OrderWidget(),
    );
  }
}
