import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/features/orders/cubit/fetch_all_order_cubit.dart';
import 'package:ecommerce_project/features/orders/model/order.dart';
import 'package:ecommerce_project/features/orders/ui/widgets/order_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FetchAllOrderCubit, CommonState>(
        builder: (context, state) {
          if (state is CommonErrorState) {
            return Center(child: Text(state.message));
          } else if (state is CommonSuccessState<List<ProductOrder>>) {
            return ListView.builder(
                itemCount: state.item.length,
                itemBuilder: (context, index) {
                  return OrderCard(
                    order: state.item[index],
                  );
                });
          } else {
            return const Center(child: CupertinoActivityIndicator());
          }
        },
      ),
    );
  }
}
