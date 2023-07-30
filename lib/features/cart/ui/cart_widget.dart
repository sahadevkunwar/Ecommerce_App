import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/common/utils/snackbar_utils.dart';
import 'package:ecommerce_project/features/cart/cubit/update_cart_quantity_cubit.dart';
import 'package:ecommerce_project/features/cart/ui/widgets/cart_card.dart';
import 'package:ecommerce_project/features/checkout/ui/screens/checkout_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/fetch_all_cart_cubit.dart';
import '../models/cart.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  //bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateCartQuantityCubit, CommonState>(
      listener: (context, state) {
        // if (state is CommonLoadingState) {
        //   setState(() {
        //     isLoading = true;
        //   });
        // } else {
        //   setState(() {
        //     isLoading = true;
        //   });
        // }
        if (state is CommonErrorState) {
          SnackbarUtils.showMessage(context: context, message: state.message);
        }
      },
      child: Column(
        children: [
          Expanded(child: BlocBuilder<FetchAllCartCubit, CommonState>(
            builder: (context, state) {
              if (state is CommonErrorState) {
                return Center(child: Text(state.message));
              } else if (state is CommonSuccessState<List<Cart>>) {
                if (state.item.isNotEmpty) {
                  return ListView.builder(
                      itemCount: state.item.length,
                      padding: const EdgeInsets.only(top: 16),
                      itemBuilder: (context, index) {
                        return CartCard(
                          cart: state.item[index],
                        );
                      });
                } else {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          "assets/images/empty_cart.png",
                          height: 200,
                        ),
                        const SizedBox(height: 10),
                        const Text('No items in the cart')
                      ],
                    ),
                  );
                }
              } else {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
            },
          )),
          BlocSelector<FetchAllCartCubit, CommonState, bool>(
            selector: (state) {
              if (state is CommonSuccessState<List<Cart>> &&
                  state.item.isNotEmpty) {
                return true;
              } else {
                return false;
              }
            },
            builder: (context, state) {
              if (state == false) {
                return Container();
              }
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(1, -3),
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 10,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocSelector<FetchAllCartCubit, CommonState, String>(
                      selector: (state) {
                        if (state is CommonLoadingState) {
                          return "Loading";
                        } else if (state is CommonSuccessState<List<Cart>>) {
                          return state.item
                              .fold<double>(
                                  0,
                                  (pv, e) =>
                                      pv + (e.quantity * e.product.price))
                              .toString();
                        } else {
                          return "Unknown";
                        }
                      },
                      builder: (context, state) {
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Text(
                            "Total cost:Rs$state",
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CheckOutPage()));
                          },
                          child: const Text('Checkout')),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
