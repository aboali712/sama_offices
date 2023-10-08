class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? image;
  String? lat;
  String? lng;
  String? deviceToken;
  String? emailVerifiedAt;
  String? facebookId;
  String? googleId;
  Office? office;

  UserModel(
      {this.id,
        this.firstName,
        this.lastName,
        this.phone,
        this.email,
        this.image,
        this.lat,
        this.lng,
        this.deviceToken,
        this.emailVerifiedAt,
        this.facebookId,
        this.googleId,
        this.office});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    lat = json['lat'];
    lng = json['lng'];
    deviceToken = json['device_token'];
    emailVerifiedAt = json['email_verified_at'];
    facebookId = json['facebook_id'];
    googleId = json['google_id'];
    office =
    json['office'] != null ? new Office.fromJson(json['office']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['image'] = this.image;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['device_token'] = this.deviceToken;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['facebook_id'] = this.facebookId;
    data['google_id'] = this.googleId;
    if (this.office != null) {
      data['office'] = this.office!.toJson();
    }
    return data;
  }
}

class Office {
  int? id;
  int? currentPlanId;
  String? name;
  String? image;
  String? description;
  String? workingHours;
  String? address;
  String? commercialRegisterationNo;
  String? paymentMethod;
  PaymentInfo? paymentInfo;
  int? countryId;
  int? cityId;
  String? lat;
  String? lng;
  String? rate;
  int? distance;
  String? subscription_start_date;
  String? subscription_end_date;
  String? start_work_at;
  String? end_work_at;
  String? country_name;
  String? city_name;
  String? name_en;
  String? description_en;
  String? address_en;
  String? working_hours_en;


  Office(
      {this.id,
        this.currentPlanId,
        this.name,
        this.image,
        this.description,
        this.workingHours,
        this.address,
        this.commercialRegisterationNo,
        this.paymentMethod,
        this.paymentInfo,
        this.countryId,
        this.cityId,
        this.lat,
        this.lng,
        this.rate,
        this.distance,
      this.subscription_start_date,
        this.subscription_end_date,
        this.start_work_at,
        this.end_work_at,
        this.country_name,
        this.city_name,
        this .name_en,
        this.description_en,
        this.address_en,
        this.working_hours_en,

      });

  Office.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currentPlanId = json['current_plan_id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    workingHours = json['working_hours'];
    address = json['address'];
    commercialRegisterationNo = json['commercial_registeration_no'];
    paymentMethod = json['payment_method'];
    paymentInfo = json['payment_info'] != null
        ? new PaymentInfo.fromJson(json['payment_info'])
        : null;
    countryId = json['country_id'];
    cityId = json['city_id'];
    lat = json['lat'];
    lng = json['lng'];
    rate = json['rate'];
    distance = json['distance'];
    subscription_start_date = json['subscription_start_date'];
    subscription_end_date = json['subscription_end_date'];
    start_work_at = json['start_work_at'];
    end_work_at = json['end_work_at'];
    country_name = json['country_name'];
    city_name = json['city_name'];
    name_en= json['name_en'];
    description_en= json['description_en'];
    address_en= json['address_en'];
    working_hours_en= json['working_hours_en'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['current_plan_id'] = this.currentPlanId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['working_hours'] = this.workingHours;
    data['address'] = this.address;
    data['commercial_registeration_no'] = this.commercialRegisterationNo;
    data['payment_method'] = this.paymentMethod;
    if (this.paymentInfo != null) {
      data['payment_info'] = this.paymentInfo!.toJson();
    }
    data['country_id'] = this.countryId;
    data['city_id'] = this.cityId;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['rate'] = this.rate;
    data['distance'] = this.distance;
    data['subscription_start_date'] = this.subscription_start_date;
    data['subscription_end_date'] = this.subscription_end_date;
    data['start_work_at'] = this.start_work_at;
    data['end_work_at'] = this.end_work_at;
    data['country_name'] = this.country_name;
    data['city_name'] = this.city_name;
    data['name_en'] = this.name_en;
    data['description_en'] = this.description_en;
    data['address_en'] = this.address_en;
    data['working_hours_en'] = this.working_hours_en;
    return data;
  }
}

class PaymentInfo {
  String? bankName;
  String? bankAccount;
  String? iban;

  PaymentInfo({this.bankName, this.bankAccount, this.iban});

  PaymentInfo.fromJson(Map<String, dynamic> json) {
    bankName = json['bank_name'];
    bankAccount = json['bank_account'];
    iban = json['iban'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank_name'] = this.bankName;
    data['bank_account'] = this.bankAccount;
    data['iban'] = this.iban;
    return data;
  }
}