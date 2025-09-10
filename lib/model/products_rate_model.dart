class ProductRateData {
  late final List<ProductsRateModel> model;
  late final String status;
  late final String message;

  ProductRateData.fromJson(Map<String, dynamic> json){
    model = List.from(json['data']).map((e)=>ProductsRateModel.fromJson(e)).toList();
    status = json['status'];
    message = json['message'];
  }
}

class ProductsRateModel {
  late final int value;
  late final String comment;
  late final String clientName;
  late final String clientImage;

  ProductsRateModel.fromJson(Map<String, dynamic> json){
    value = json['value'];
    comment = json['comment'] ?? "";
    clientName = json['client_name'];
    clientImage = json['client_image'];
  }
}