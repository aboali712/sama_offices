
import 'package:sama_offices/src/auth/auth_model/user_model.dart';
import 'package:sama_offices/src/home/offers/all/models/offer_model.dart';

import 'my_office_model.dart';
import 'my_service_model.dart';

class BookingsModel {
  int? id;
  int? userId;
  String? type;
  int? officeId;
  MyOfficeModel? office;
  int? offerId;
  String? numOfServices;
  String? childrenCount;
  String? adultsCount;
  String? startDate;
  String? endDate;
  String? status;
  bool? isRated;
  String? createdAt;
  List<MyServiceModel>? services;
  UserModel? user;
   OfferModel? offer;

  BookingsModel(
      {this.id,
        this.userId,
        this.type,
        this.officeId,
        this.office,
        this.offerId,
        this.numOfServices,
        this.status,
        this.isRated,
        this.adultsCount,
        this.childrenCount,
        this.startDate,
        this.endDate,
        this.createdAt,
        this.services,
        this.user,
      this.offer
      });

  BookingsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    officeId = json['office_id'];
    office =
    json['office'] != null ? new MyOfficeModel.fromJson(json['office']) : null;

    adultsCount = json['adults_count'];
    childrenCount = json['children_count'];
    startDate = json['start_date'];
    endDate = json['end_date'];

    offerId = json['offer_id'];
     offer = json['offer'] != null ? new OfferModel.fromJson(json['offer']) : null;
    numOfServices = json['num_of_services'];
    status = json['status'];
    isRated = json['is_rated'];
    createdAt = json['created_at'];
    user =
    json['user'] != null ? UserModel.fromJson(json['user']) : UserModel();

    if (json['services'] != null) {
      services = <MyServiceModel>[];
      json['services'].forEach((v) {
        services!.add(new MyServiceModel.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['office_id'] = this.officeId;
    data['adults_count'] = this.adultsCount;
    data['children_count'] = this.childrenCount;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    if (this.office != null) {
      data['office'] = this.office!.toJson();
    }
    data['user'] = user!.toJson();

    data['offer_id'] = this.offerId;
    if (this.offer != null) {
      data['offer'] = this.offer!.toJson();
    }
    data['num_of_services'] = this.numOfServices;
    data['status'] = this.status;
    data['is_rated'] = this.isRated;
    data['created_at'] = this.createdAt;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
