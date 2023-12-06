class AddProduct {
  String name;
  String description;
  String image;
  String brand;
  int price;
  List<String> catagories;

  AddProduct({
    required this.name,
    required this.description,
    required this.image,
    required this.brand,
    required this.price,
    required this.catagories,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'image': image,
      'brand': brand,
      'price': price,
      'catagories': catagories,
    };
  }

  factory AddProduct.fromMap(Map<String, dynamic> map) {
    return AddProduct(
      name: map['name'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      brand: map['brand'] as String,
      price: map['price'] as int,
      catagories:
          List.from(map['catagories']).map((e) => e.toString()).toList(),
    );
  }
}
