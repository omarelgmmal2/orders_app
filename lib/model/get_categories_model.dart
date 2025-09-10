class GetCategoriesData {
  late final List<GetCategoriesModel> model;
  late final String status;
  late final String message;

  GetCategoriesData.fromJson(Map<String, dynamic> json){
    model = List.from(json['data']).map((e)=>GetCategoriesModel.fromJson(e)).toList();
    status = json['status'];
    message = json['message'];
  }
}

class GetCategoriesModel {
  late final int id;
  late final String name;
  late final String description;
  late final String media;

  GetCategoriesModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    description = json['description'];
    media = json['media'];
  }
}