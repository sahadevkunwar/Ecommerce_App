import 'package:ecommerce_project/features/orders/model/order.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderCard extends StatefulWidget {
  final ProductOrder order;
  const OrderCard({super.key, required this.order});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(8),
              //     color: Colors.white,
              //   ),
              //   child: ClipRRect(
              //       borderRadius: BorderRadius.circular(9),
              //       child: Image.network(
              //         widget.order.carts.first.product.image,
              //         width: 70,
              //         height: 70,
              //         fit: BoxFit.cover,
              //       )),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 0, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   widget.order.carts.first.product.name,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: GoogleFonts.poppins(
                    //       fontSize: 14, fontWeight: FontWeight.w600),
                    // ),
                    const SizedBox(height: 4),
                    Text(
                      "Total price: Rs.${widget.order.totalPrice}",
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Text(
                        "Ordered date:${widget.order.dateOrdered.substring(0, 10)}"),
                    const SizedBox(height: 4),
                    Text("Quantity:${widget.order.quantity}"),
                    const SizedBox(height: 3),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        widget.order.status,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          height: 1.2,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
