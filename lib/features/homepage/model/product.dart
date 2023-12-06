// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  String id;
  String name;
  // String description;
  String image;
  String brand;
  int price;
  List<String> catagories;
  bool isInCart;

  Product({
    required this.id,
    required this.name,
    // required this.description,
    required this.image,
    required this.brand,
    required this.price,
    required this.catagories,
    required this.isInCart,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      // 'description': description,
      'image': image,
      'brand': brand,
      'price': price,
      'catagories': catagories,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id'] as String,
      name: map['name'] as String,
      // description: map['description'] as String,
      image: map['image'] as String,
      brand: map['brand'] as String,
      price: map['price'] as int,
      catagories:
          List.from(map['catagories']).map((e) => e.toString()).toList(),
      isInCart: map["added_in_cart"] ?? false,
    );
  }
}
