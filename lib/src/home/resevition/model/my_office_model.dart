import 'PaymentInfo.dart';

class MyOfficeModel {
  int? id;
  String? title;
  String? image;
  String? description;
  String? workingHours;
  int? currentPlanId;
  String? address;
  String? commercialRegisterationNo;
  String? paymentMethod;
  PaymentInfo? paymentInfo;
  String? rate;
  int? countryId;
  int? cityId;

  MyOfficeModel(
      {this.id,
        this.title,
        this.image,
        this.description,
        this.workingHours,
        this.currentPlanId,
        this.address,
        this.commercialRegisterationNo,
        this.paymentMethod,
        this.paymentInfo,
        this.rate,
        this.countryId,
        this.cityId});

  MyOfficeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    workingHours = json['working_hours'];
    currentPlanId = json['current_plan_id'];
    address = json['address'];
    commercialRegisterationNo = json['commercial_registeration_no'];
    paymentMethod = json['payment_method'];
    paymentInfo = json['payment_info'] != null
        ? new PaymentInfo.fromJson(json['payment_info'])
        : null;
    rate = json['rate'];
    countryId = json['country_id'];
    cityId = json['city_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['description'] = this.description;
    data['working_hours'] = this.workingHours;
    data['current_plan_id'] = this.currentPlanId;
    data['address'] = this.address;
    data['commercial_registeration_no'] = this.commercialRegisterationNo;
    data['payment_method'] = this.paymentMethod;
    if (this.paymentInfo != null) {
      data['payment_info'] = this.paymentInfo!.toJson();
    }
    data['rate'] = this.rate;
    data['country_id'] = this.countryId;
    data['city_id'] = this.cityId;
    return data;
  }
}
