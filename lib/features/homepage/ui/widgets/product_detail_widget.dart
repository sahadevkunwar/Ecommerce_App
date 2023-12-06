import 'package:ecommerce_project/common/utils/snackbar_utils.dart';
import 'package:ecommerce_project/features/homepage/cubit/add_to_cart_cubit.dart';
import 'package:ecommerce_project/features/homepage/cubit/fetch_product_detail_cubit.dart';
import 'package:ecommerce_project/features/homepage/model/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../../common/bloc/common_state.dart';

class ProductDetailWidget extends StatefulWidget {
  final String productId;

  const ProductDetailWidget({Key? key, required this.productId})
      : super(key: key);

  @override
  State<ProductDetailWidget> createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    context
        .read<FetchProductDetailCubit>()
        .fetchProductDetails(productId: widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(),
        body: BlocListener<AddToCartCubit, CommonState>(
          listener: (context, state) {
            if (state is CommonLoadingState) {
              setState(() {
                isLoading = true;
              });
            } else {
              setState(() {
                isLoading = false;
              });
            }
            if (state is CommonSuccessState) {
              context
                  .read<FetchProductDetailCubit>()
                  .fetchProductDetails(productId: widget.productId);
              SnackbarUtils.showMessage(
                context: context,
                message: "Product added to cart",
              );
            } else if (state is CommonErrorState) {
              SnackbarUtils.showMessage(
                context: context,
                message: state.message,
              );
            }
          },
          child: BlocBuilder<FetchProductDetailCubit, CommonState>(
            builder: (context, state) {
              if (state is CommonErrorState) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is CommonSuccessState<Product>) {
                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: double.infinity,
                      child: Image.network(
                        state.item.image,
                        fit: BoxFit.cover,
                        height: double.infinity,
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            height: double.infinity,
                            padding: const EdgeInsets.only(
                                top: 40, right: 14, left: 14),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.item.brand,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          state.item.name,
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(width: 16),
                                        Text(
                                          "Rs ${state.item.price}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                  // const SizedBox(height: 15),
                                  // Text(
                                  //   state.item.description,
                                  //   style: GoogleFonts.poppins(
                                  //     fontSize: 14,
                                  //     color: Colors.grey,
                                  //   ),
                                  // ),
                                  const SizedBox(height: 15),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: 50,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              } else {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
            },
          ),
        ),
        bottomNavigationBar:
            BlocSelector<FetchProductDetailCubit, CommonState, bool>(
          selector: (state) {
            if (state is CommonSuccessState<Product>) {
              return !state.item.isInCart;
            }
            return false;
          },
          builder: (context, state) {
            if (state) {
              return SafeArea(
                child: Container(
                  height: 70,
                  color: Colors.white,
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AddToCartCubit>().add(widget.productId);
                    },
                    child: const Text("+ Add to Cart"),
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
