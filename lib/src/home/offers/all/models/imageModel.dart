class ImagesModel {
  int? id;
  int? offerId;
  String? image;

  ImagesModel({this.id, this.offerId, this.image});

  ImagesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    offerId = json['offer_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['offer_id'] = this.offerId;
    data['image'] = this.image;
    return data;
  }
}