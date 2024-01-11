import 'package:flutter/material.dart';

import '../widgets/homepage_widget.dart';

class HomePageScreen extends StatelessWidget {
  final TextEditingController searchController;
  const HomePageScreen({Key? key, required this.searchController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePageWidget(
      searchController: searchController,
    );
  }
}

// return BlocProvider(
//       create: (context) => FetchProductCubit(
//           productRepository: context.read<ProductRepository>())
//         ..add(FetchProductEvent()),
//       child: const HomePageWidget(),
//     );
