

import 'package:sama_offices/src/auth/signup/all_filter/paln_model.dart';
import 'package:sama_offices/src/auth/signup/all_filter/service_model.dart';

import 'country_model.dart';

class FilterModel {
  List<CountryModel>? countries;
  List<ServiceModel>? services;
  List<PlansModel>? plans;

  String? minPrice;
  String? maxPrice;

  FilterModel({this.countries, this.services, this.minPrice, this.maxPrice,this.plans});

  FilterModel.fromJson(Map<String, dynamic> json) {
    if (json['countries'] != null) {
      countries = <CountryModel>[];
      json['countries'].forEach((v) {
        countries!.add(new CountryModel.fromJson(v));
      });
    }
    if (json['services'] != null) {
      services = <ServiceModel>[];
      json['services'].forEach((v) {
        services!.add(ServiceModel.fromJson(v));
      });
    }
    if (json['plans'] != null) {
      plans = <PlansModel>[];
      json['plans'].forEach((v) {
        plans!.add(PlansModel.fromJson(v));
      });
    }
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.countries != null) {
      data['countries'] = this.countries!.map((v) => v.toJson()).toList();
    }
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    data['min_price'] = this.minPrice;
    data['max_price'] = this.maxPrice;
    return data;
  }
}
