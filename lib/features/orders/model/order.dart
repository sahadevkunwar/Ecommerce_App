
class ProductOrder {
  final String id;
  final String status;
  final int totalPrice;
  final String dateOrdered;
  final int quantity;

  // final List<Cart> carts;
  ProductOrder({
    required this.id,
    required this.status,
    required this.totalPrice,
    required this.dateOrdered,
    required this.quantity,
    // required this.carts,
  });

  factory ProductOrder.fromMap(Map<String, dynamic> map) {
    return ProductOrder(
      id: map['_id'] as String,
      status: map['status'] as String,
      totalPrice: map['totalPrice'] as int,
      dateOrdered: map['dateOrdered'] as String,
      quantity: map['quantity'] as int,
      // carts: List.from(map['orderItems'])
      //     .map<Cart>((x) => Cart.fromMap(x as Map<String, dynamic>))
      //     .toList(),
    );
  }
}
