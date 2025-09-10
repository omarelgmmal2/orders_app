class SliderData {
  late final List<SliderModel> model;
  late final String status;
  late final String message;

  SliderData.fromJson(Map<String, dynamic> json){
    model = List.from(json['data']).map((e)=>SliderModel.fromJson(e)).toList();
    status = json['status'];
    message = json['message'];
  }
}

class SliderModel {
  late final int id;
  late final String media;

  SliderModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    media = json['media'];
  }
}