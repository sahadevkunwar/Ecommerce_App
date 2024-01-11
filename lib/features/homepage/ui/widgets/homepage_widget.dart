import 'dart:async';

import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/features/homepage/cubit/fetch_product_cubit.dart';
import 'package:ecommerce_project/features/homepage/cubit/fetch_product_event.dart';
import 'package:ecommerce_project/features/homepage/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/cards/product_card.dart';

class HomePageWidget extends StatefulWidget {
  final TextEditingController searchController;
  const HomePageWidget({Key? key,required this.searchController}) : super(key: key);

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  Completer<bool> _refreshCompleter = Completer<bool>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FetchProductCubit, CommonState>(
      listener: (context, state) {
        if (state is! CommonLoadingState &&
            _refreshCompleter.isCompleted == false) {
          _refreshCompleter.complete(true);
        }
      },
      buildWhen: (previous, current) {
        if (current is CommonLoadingState) {
          return current.showLoading;
        } else {
          return true;
        }
      },
      builder: (context, state) {
        if (state is CommonErrorState) {
          return Center(child: Text(state.message));
        } else if (state is CommonSuccessState<List<Product>>) {
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.pixels >
                      (notification.metrics.maxScrollExtent / 2) &&
                  _scrollController.position.userScrollDirection ==
                      ScrollDirection.reverse) {
                context.read<FetchProductCubit>().add(LoadMoreProductEvent(query: widget.searchController.text));
              }
              return false;
            },
            child: RefreshIndicator(
              onRefresh: () async {
                _refreshCompleter = Completer<bool>();
                context.read<FetchProductCubit>().add(RefreshProductEvent(query: widget.searchController.text));
                await _refreshCompleter.future;
              },
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.item.length,
                padding: const EdgeInsets.only(top: 16),
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: state.item[index],
                  );
                },
              ),
            ),
          );
        } else {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }
}
