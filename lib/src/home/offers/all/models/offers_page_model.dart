

import '../../../../auth/signup/all_filter/cities_model.dart';
import 'offer_model.dart';

class OfferPageModel {
  List<CityModel>? mostFamousCities;
  List<OfferModel>? offers;

  OfferPageModel({this.mostFamousCities, this.offers});

  OfferPageModel.fromJson(Map<String, dynamic> json) {
    if (json['most_famous_cities'] != null) {
      mostFamousCities = <CityModel>[];
      json['most_famous_cities'].forEach((v) {
        mostFamousCities!.add(new CityModel.fromJson(v));
      });
    }
    if (json['offers'] != null) {
      offers = <OfferModel>[];
      json['offers'].forEach((v) {
        offers!.add(new OfferModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mostFamousCities != null) {
      data['most_famous_cities'] =
          this.mostFamousCities!.map((v) => v.toJson()).toList();
    }
    if (this.offers != null) {
      data['offers'] = this.offers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}