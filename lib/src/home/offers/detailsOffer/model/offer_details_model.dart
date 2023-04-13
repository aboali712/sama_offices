
import '../../all/models/offer_model.dart';

class OfferDetailsModel {
  OfferModel? offerDetails;
  List<OfferModel>? relatedOffers;

  OfferDetailsModel({this.offerDetails, this.relatedOffers});

  OfferDetailsModel.fromJson(Map<String, dynamic> json) {
    offerDetails = json['offer_details'] != null
        ? OfferModel.fromJson(json['offer_details'])
        : null;
    if (json['related_offers'] != null) {
      relatedOffers = <OfferModel>[];
      json['related_offers'].forEach((v) {
        relatedOffers!.add(OfferModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.offerDetails != null) {
      data['offer_details'] = this.offerDetails!.toJson();
    }
    if (this.relatedOffers != null) {
      data['related_offers'] =
          this.relatedOffers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
