import 'package:ecommerce_project/common/bloc/common_state.dart';
import 'package:ecommerce_project/features/cart/cubit/update_cart_quantity_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/cart.dart';

class CartCard extends StatefulWidget {
  final Cart cart;

  const CartCard({Key? key, required this.cart}) : super(key: key);

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _quantity = widget.cart.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateCartQuantityCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonSuccessState<Cart> &&
            state.item.id == widget.cart.id) {
          setState(() {
            _quantity = state.item.quantity;
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16, left: 10, right: 10),
        child: Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    child: Image.network(
                      widget.cart.product.image,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        constraints: const BoxConstraints(maxWidth: 200.0),
                        child: Text(
                          widget.cart.product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Rs${widget.cart.product.price}",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        splashRadius: 10,
                        onPressed: () {
                          if (_quantity > 1) {
                            context.read<UpdateCartQuantityCubit>().update(
                                  cart: widget.cart,
                                  quantity: _quantity - 1,
                                );
                          }
                        },
                        icon: const Icon(
                          Icons.remove,
                          size: 15,
                        ),
                      ),
                      Text(
                        "$_quantity",
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      IconButton(
                        splashRadius: 8,
                        onPressed: () {
                          context.read<UpdateCartQuantityCubit>().update(
                                cart: widget.cart,
                                quantity: _quantity + 1,
                              );
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
