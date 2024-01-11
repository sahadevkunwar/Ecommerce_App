import 'package:ecommerce_project/features/dashboard/widgets/dash_board_widget.dart';
import 'package:ecommerce_project/features/homepage/cubit/fetch_product_cubit.dart';
import 'package:ecommerce_project/features/homepage/resource/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchProductCubit(
          productRepository: context.read<ProductRepository>()),
      child: const DashBoardWidget(),
    );
  }
}
