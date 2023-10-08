






import 'package:sama_offices/src/home/payment/model/payment_model.dart';

import '../../../../../core/utils/BaseResponse.dart';

class PaymentResponse extends BaseResponse<PaymentModel> {
  PaymentResponse(Map<String, dynamic> fullJson) : super(fullJson);

  @override
  dataToJson(PaymentModel data) {
    return data.toJson();
  }

  @override
  PaymentModel jsonToData(Map<String, dynamic> fullJson) {
    return PaymentModel.fromJson(fullJson['data']);
  }
}
