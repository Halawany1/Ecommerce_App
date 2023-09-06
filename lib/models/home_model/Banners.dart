class Banners {
  int ?id;
  String ?image;
  dynamic category;
  dynamic product;

  Banners.fromJson(Map<String,dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
  }

}