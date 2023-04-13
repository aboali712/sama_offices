class CityModel {
  int? id;
  int? countryId;
  String? image;
  String? name;

  CityModel({this.id, this.countryId, this.image, this.name});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    image = json['image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_id'] = this.countryId;
    data['image'] = this.image;
    data['name'] = this.name;
    return data;
  }
}