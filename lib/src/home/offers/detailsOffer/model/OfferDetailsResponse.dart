






import '../../../../../core/utils/BaseResponse.dart';
import 'offer_details_model.dart';

class OffersDetailsResponse extends BaseResponse<OfferDetailsModel> {
  OffersDetailsResponse(Map<String, dynamic> fullJson) : super(fullJson);

  @override
  dataToJson(OfferDetailsModel data) {
    return data.toJson();
  }

  @override
  OfferDetailsModel jsonToData(Map<String, dynamic> fullJson) {
    return OfferDetailsModel.fromJson(fullJson['data']);
  }
}
