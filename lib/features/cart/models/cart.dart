import 'package:ecommerce_project/features/homepage/model/product.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Cart {
  final String id;
  final int quantity;
  final Product product;

  Cart({
    required this.id,
    required this.quantity,
    required this.product,
  });

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['_id'] as String,
      quantity: map['quantity'] as int,
      product: Product.fromMap(map['product'] as Map<String, dynamic>),
    );
  }
}
