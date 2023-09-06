class Product {
  int ?id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String ?image;
  Product.fromJson(Map<String,dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }

}