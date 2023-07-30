import 'package:ecommerce_project/features/homepage/cubit/fetch_product_cubit.dart';
import 'package:ecommerce_project/features/homepage/cubit/fetch_product_event.dart';
import 'package:ecommerce_project/features/homepage/resource/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/homepage_widget.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchProductCubit(
          productRepository: context.read<ProductRepository>())
        ..add(FetchProductEvent()),
      child: const HomePageWidget(),
    );
  }
}
