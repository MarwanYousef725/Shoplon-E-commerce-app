class Product {
  final String image;
  final String text1;
  final String text2;
  final String price;
  final String pricedis;
  final String productinfo;
  final String? discount;
  final bool available;
  Product({
    required this.image,
    required this.text1,
    required this.text2,
    required this.price,
    required this.pricedis,
    required this.productinfo,
    required this.available,
    required this.discount,
  });
  Map<String, dynamic> toJson() {
    return {
      "image": image,
      'text1': text1,
      'text2': text2,
      'price': price,
      'pricedis': pricedis,
      'productinfo': productinfo,
      'discount': discount,
      'available': available,
    };
  }

  factory Product.fromJson(json) => Product(
    image: json['image'],
    text1: json['text1'],
    text2: json['text2'],
    price: json['price'],
    pricedis: json['pricedis'],
    productinfo: json['productinfo'],
    discount: json['discount'],
    available: json['available'],
  );
}
