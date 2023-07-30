// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce_project/features/cart/models/cart.dart';

class ProductOrder {
  final String id;
  final String status;
  final int totalAmount;
  final String dateOrdered;
  final List<Cart> carts;
  ProductOrder({
    required this.id,
    required this.status,
    required this.totalAmount,
    required this.dateOrdered,
    required this.carts,
  });

  factory ProductOrder.fromMap(Map<String, dynamic> map) {
    return ProductOrder(
      id: map['_id'] as String,
      status: map['status'] as String,
      totalAmount: map['totalPrice'] as int,
      dateOrdered: map['dateOrdered'] as String,
      carts: List.from(map['orderItems'])
          .map<Cart>((x) => Cart.fromMap(x as Map<String, dynamic>))
          .toList(),
    );
  }
}
