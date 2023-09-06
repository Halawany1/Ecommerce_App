

class SearchModel{
  bool ?status;
  String ?message;
  Data ?data;

  SearchModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}


class Data {

  int ?currentPage;
  List<DataModel> ?data;
  String ?firstPageUrl;
  int ?from;
  int ?lastPage;
  String ?lastPageUrl;
  dynamic nextPageUrl;
  String ?path;
  int ?perPage;
  dynamic prevPageUrl;
  int ?to;
  int ?total;
  Data.fromJson(dynamic json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DataModel.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }



}
class DataModel{
  int ?id;
  String ?name;
  String ?image;
  List<String> ?images;
  dynamic price;
  dynamic discount;
  bool ?inFavourite;
  String ?description;
  bool ?inCart;
  DataModel.fromJson(Map<String,dynamic> json) {
    id=json['id'];
    name=json['name'];
    image=json['image'];
    price=json['price'];
    inFavourite=json['in_favorites'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    inCart=json['in_cart'];
    description=json['description'];
  }
}