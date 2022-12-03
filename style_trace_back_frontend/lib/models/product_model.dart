class Product {
  String brand;
  String category;
  String description;
  String onlinePrice;
  String storePrice;
  String imagePath;

  Product(
      {required this.brand,
      required this.category,
      required this.description,
      required this.onlinePrice,
      required this.storePrice,
      required this.imagePath});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        brand: json["Brand"] as String,
        category: json["Category"] as String,
        description: json["Description"] as String,
        onlinePrice: json["OnlinePrice"] as String,
        storePrice: json["OnlinePrice"] as String,
        imagePath: json["ImgUrl"] as String);
  }
}
