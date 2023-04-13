class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  Null? countryId;
  Null? cityId;
  String? email;
  String? phone;
  String? emailVerifiedAt;
  String? deviceToken;
  String? image;
  String? lat;
  String? lng;
  String? facebookId;
  String? googleId;
  int? status;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  UserModel(
      {this.id,
        this.firstName,
        this.lastName,
        this.countryId,
        this.cityId,
        this.email,
        this.phone,
        this.emailVerifiedAt,
        this.deviceToken,
        this.image,
        this.lat,
        this.lng,
        this.facebookId,
        this.googleId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    countryId = json['country_id'];
    cityId = json['city_id'];
    email = json['email'];
    phone = json['phone'];
    emailVerifiedAt = json['email_verified_at'];
    deviceToken = json['device_token'];
    image = json['image'];
    lat = json['lat'];
    lng = json['lng'];
    facebookId = json['facebook_id'];
    googleId = json['google_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['country_id'] = this.countryId;
    data['city_id'] = this.cityId;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['device_token'] = this.deviceToken;
    data['image'] = this.image;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['facebook_id'] = this.facebookId;
    data['google_id'] = this.googleId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}