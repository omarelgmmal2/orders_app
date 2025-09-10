class ProductsData {
  late final List<ProductsModel> model;
  late final String status;
  late final String message;
  late final int userCartCount;
  late final int maxPrice;
  late final double minPrice;

  ProductsData.fromJson(Map<String, dynamic> json){
    model = List.from(json['data'] ?? [])
        .map((e) => ProductsModel.fromJson(e))
        .toList();
    status = json['status'];
    message = json['message'];
    userCartCount = json['user_cart_count'] ?? 0;
    maxPrice = json['max_price'] ?? 0;
    minPrice = json['min_price'] ?? 0;
  }
}

class ProductsModel {
  late final int categoryId;
  late final int id;
  late final String title;
  late final String description;
  late final String code;
  late final int priceBeforeDiscount;
  late final double? price;
  late double dis;
  late final int discount;
  late final num? amount;
  late final int isActive;
  late final bool isFavorite;
  late final Unit unit;
  late final List<Images> images;
  late final String mainImage;
  late final String createdAt;

  ProductsModel.fromJson(Map<String, dynamic> json){
    categoryId = json['category_id'];
    id = json['id'];
    title = json['title'];
    description = json['description'];
    code = json['code'];
    priceBeforeDiscount = json['price_before_discount'];
    price = double.tryParse((json['price'] ?? 0).toString());
    dis = json['discount'] * 100;
    discount = dis.truncate();
    amount = json['amount'];
    isActive = json['is_active'];
    isFavorite = json['is_favorite'];
    unit = Unit.fromJson(json['unit']);
    images = List.from(json['images']).map((e)=>Images.fromJson(e)).toList();
    mainImage = json['main_image'];
    createdAt = json['created_at'];
  }
}

class Unit {
  late final int id;
  late final String name;
  late final String type;
  late final String createdAt;
  late final String updatedAt;

  Unit.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Images {
  late final String name;
  late final String url;

  Images.fromJson(Map<String, dynamic> json){
    name = json['name'];
    url = json['url'];
  }
}