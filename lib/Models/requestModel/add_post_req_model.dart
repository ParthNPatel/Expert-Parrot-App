class AddPostRequestModel {
  String? title;
  String? description;
  String? image;

  AddPostRequestModel({this.title, this.description, this.image});

  AddPostRequestModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}
