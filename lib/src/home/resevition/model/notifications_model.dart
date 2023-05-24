class NotificationModel {
  int? id;
  String? type;
  String? title;
  String? description;
  NotificationModel({this.id, this.type, this.title, this.description});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    title = json['title'];
    description = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['title'] = this.title;
    data['message'] = this.description;
    return data;
  }
}