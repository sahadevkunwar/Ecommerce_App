import 'package:ecommerce_project/features/homepage/cubit/add_product_cubit.dart';
import 'package:ecommerce_project/features/homepage/resource/product_repository.dart';
import 'package:ecommerce_project/features/homepage/ui/widgets/add_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddProductCubit(productRepository: context.read<ProductRepository>()),
      child: const AddProductWidget(),
    );
  }
}
