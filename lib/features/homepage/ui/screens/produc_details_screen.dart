import 'package:ecommerce_project/features/homepage/cubit/add_to_cart_cubit.dart';
import 'package:ecommerce_project/features/homepage/cubit/fetch_product_detail_cubit.dart';
import 'package:ecommerce_project/features/homepage/resource/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/product_detail_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;

  const ProductDetailScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FetchProductDetailCubit(
              productRepository: context.read<ProductRepository>()),
        ),
        BlocProvider(
          create: (context) => AddToCartCubit(
              productRepository: context.read<ProductRepository>()),
        ),
      ],
      child: ProductDetailWidget(
        productId: productId,
      ),
    );
  }
}
