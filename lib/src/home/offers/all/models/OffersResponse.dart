





import '../../../../../core/utils/BaseResponse.dart';
import 'offer_model.dart';

class OffersResponse extends BaseResponse< List<OfferModel>> {
  OffersResponse(Map<String, dynamic> fullJson) : super(fullJson);

  @override
  dataToJson(List<OfferModel> data) {
    return data.map((v) => v.toJson()).toList();
  }

  @override
  List<OfferModel> jsonToData(Map<String, dynamic> fullJson) {
    var offers = <OfferModel>[];
    fullJson['data'].forEach((v) {
      offers.add(OfferModel.fromJson(v));
    });
    return offers;
  }
}
