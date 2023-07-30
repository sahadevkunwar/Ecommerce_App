import 'package:ecommerce_project/features/cart/cubit/fetch_all_cart_cubit.dart';
import 'package:ecommerce_project/features/cart/cubit/update_cart_quantity_cubit.dart';
import 'package:ecommerce_project/features/cart/resources/cart_repository.dart';
import 'package:ecommerce_project/features/checkout/cubit/create_order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => UpdateCartQuantityCubit(
                cartRepository: context.read<CartRepository>())),
        BlocProvider(
          create: (context) => FetchAllCartCubit(
            cartRepository: context.read<CartRepository>(),
            updateCartQuantityCubit: context.read<UpdateCartQuantityCubit>(),
            createOrderCubit: context.read<CreateOrderCubit>(),
          )..fetch(),
        ),
      ],
      child: const CartWidget(),
    );
  }
}
